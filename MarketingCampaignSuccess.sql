/* Marketing Campaign Success [Advanced]; Hard Amazon SQL 
You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases.
Find the number of users that made additional in-app purchases due to the success of the marketing campaign.
The marketing campaign doesn't start until one day after the initial in-app purchase so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day.
https://platform.stratascratch.com/coding/514-marketing-campaign-success-advanced?code_type=5
*/

--- YouTube Solution: https://www.youtube.com/watch?v=azxXnO81OwQ
with cte as (SELECT user_id, created_at, product_id,
rank() over(partition by user_id order by created_at) date_rank,
RANK() OVER (PARTITION BY product_id, user_id ORDER BY created_at) AS prod_rank
FROM marketing_campaign
)

SELECT count(DISTINCT user_id) FROM cte
WHERE date_rank > 1
AND prod_rank =1
;


--Python Solution, must use DenseRank for date_rank to get a date other than original created_at
import pandas as pd

df = marketing_campaign
df['date_rank'] = df.groupby('user_id')['created_at'].rank(method='dense')
df['prod_rank'] = df.groupby(['user_id', 'product_id'])['created_at'].rank()

# Resetting the index
filter_df = df[(df['date_rank'] > 1) & (df['prod_rank'] == 1)]

# Counting distinct user_ids
distinct_user_count = filter_df['user_id'].nunique()

print(distinct_user_count)

--SQL Server, this solution is incorrect by 5% because you must find the number of same products too:
with cte as (SELECT user_id, created_at,
	LAG(created_at,1) OVER ( PARTITION BY user_id ORDER BY created_at
	) as prev_day,
	ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_at) AS purchase_number
FROM marketing_campaign),

--- Get users with a second purchase a day after:
users_second_day as (SELECT user_id, created_at, prev_day, purchase_number
FROM cte
WHERE purchase_number = 2
--and datediff(day, created_at, prev_day) =-1
)

SELECT count(DISTINCT user_id) FROM users_second_day
;
