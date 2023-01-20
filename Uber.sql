# https://datalemur.com/questions/sql-third-transaction
# User's Third Transaction [Uber SQL Interview Question]
Assume you are given the table below on Uber transactions made by users.
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

This problem was rather simple because it was similiar to the JP Morgan problem

WITH uber AS (
SELECT user_id, spend, transaction_date,
rank() OVER (
PARTITION BY user_id
ORDER BY transaction_date ASC
) as rn 
FROM transactions
)

SELECT user_id, spend, transaction_date
FROM uber
WHERE mod(rn, 3)=0
;
