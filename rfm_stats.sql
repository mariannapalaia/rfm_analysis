-- lets create the rfm segments and see some stats



with customer_groups as (
	SELECT *
	FROM rfm_scores
)


select
	segment
  , count(user_id) customer_count
  , sum(monetary_score) total_net_revenue
  , cast(sum(monetary_score) / count(user_id) as decimal(10,2)) avg_net_revenue_per_customer
from customer_groups
group by segment
