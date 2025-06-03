select max(transaction_date)
from transactions;

-- the most recent transaction was "2019-02-28" so lets assume that today is "2019-03-01" 
-- to feel more in touch with our dataset

-------------------------------------------------------------------------------------------------

-- i will create a view of the following to use it later for the segmentation 

CREATE OR REPLACE VIEW rfm_scores AS ( 

-- calculate metrics
 
with scores as (
	select user_id
         , max(transaction_date)
	     , date '2019-03-01' - max(transaction_date) recency_score
	     , count(order_id) as frequency_score
	     , sum(net_amount) monetary_score
    from transactions
    group by user_id
),

-- assign a score to each metric

rfm as (
	select
		user_id
	  , recency_score
	  , frequency_score
	  , monetary_score
	  , ntile(5) over (order by recency_score desc) as R
	  , ntile(5) over (order by frequency_score) as F
	  , ntile(5) over (order by monetary_score) as M
	from scores
)

-- compute final rfm_score in 2 ways (3-digit and avg)
-- postgres returns int by default so cast to get 2 decimal points for more accuracy in avg score
-- create segments based on different rfm scores combinations

select * 
from
(
	select
	  rfm.*
	, (r * 100 + f * 10 + m) rfm_score_3_digits
	, cast((cast(r as decimal(10,2))+f+m) / 3 as decimal(10,2)) avg_rfm_score
	, CASE 
	    WHEN R = 5 AND F >= 4 AND M >= 4 THEN 'Champions'
	    WHEN R >= 3 AND F >= 4 THEN 'Loyal Customers'
	    WHEN R >= 4 AND F >= 2 THEN 'Potential Loyalists'
	    WHEN R = 5 AND F = 1 THEN 'New Customers'
	    WHEN R = 4 AND F = 1 THEN 'Promising'
	    WHEN R = 3 AND F BETWEEN 2 AND 3 THEN 'Need Attention'
	    WHEN R = 2 AND F BETWEEN 2 AND 3 THEN 'About to Sleep'
	    WHEN R <= 2 AND F >= 3 THEN 'At Risk'
	    WHEN R = 1 AND F >= 4 AND M >= 4 THEN 'Cant Lose Them'
	    ELSE 'Lost'
	  END AS segment
	from rfm
) sub
order by avg_rfm_score desc
) ;

-- View created. if you want to run it as a query, run lines 15-63
-- cool
