# https://leetcode.com/problems/market-analysis-i/description/
# 1158. Market Analysis I - Medium Level
# The hard part is doing a left join on a newly created table
# Make sure to set the user_id = to buyer_id at end to get only buy orders
 
SELECT 
u.user_id as 'buyer_id',
u.join_date, 
COUNT(o.order_id) as 'orders_in_2019'
FROM Users u 
---below creates a new table 'o' with 2019 orders only:
LEFT JOIN (SELECT * from orders WHERE year(order_date)='2019') o
---or can use BETWEEN '2019-01-01' AND '2019-12'31'
ON u.user_id = o.buyer_id -- must be a buyer_id 
GROUP BY u.user_id 
;
