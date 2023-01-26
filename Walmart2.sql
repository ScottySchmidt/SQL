/* 
Histogram of Users and Purchases [Walmart SQL Interview Question]
https://datalemur.com/questions/histogram-users-purchases

Assume you are given the table on Walmart user transactions.
Based on a user's most recent transaction date, write a query to obtain the users and the number of products bought.
Output the user's most recent transaction date, user ID and the number of products sorted by the transaction date in chronological order.

Once the RANK() window function is setup, the problem becomes easy.
Must remember to setup window function in a CTE temp table or cannot use where 
*/
-----------------------------------------------------
with walmart as (
SELECT RANK() OVER(
PARTITION BY user_id
ORDER BY transaction_date DESC ) AS rn, 
transaction_date, user_id, product_id
FROM user_transactions
)

SELECT transaction_date, user_id, count(product_id) as purchase_count
FROM walmart
WHERE rn=1
GROUP BY transaction_date, user_id
ORDER BY transaction_date, user_id, purchase_count 
;
