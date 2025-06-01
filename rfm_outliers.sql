-- anomaly behavior is detected in the following users
-- VIP customers or errors? food for thought

with stats as (
	select 
		avg(monetary_score) avg_mon_score
	  , stddev(monetary_score) stddev_mon_score
	from rfm_scores
),

z_scores as (
	select 
		rfm_scores.*
      , cast((monetary_score - stats.avg_mon_score) / stats.stddev_mon_score as decimal(10,2)) z_score
	from rfm_scores
	cross join stats
)

select * 
from z_scores
where z_score > 3
order by z_score desc