/* 
User's Third Transaction [Uber SQL Interview Question]  https://datalemur.com/questions/sql-third-transaction
Assume you are given the table below on Uber transactions made by users.
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

transactions Example Input:
user_id	spend	transaction_date
111	100.50	01/08/2022 12:00:00
111	55.00	01/10/2022 12:00:00
121	36.00	01/18/2022 12:00:00
145	24.99	01/26/2022 12:00:00
111	89.60	02/05/2022 12:00:00
--------------------------------------------------
*/ 
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
