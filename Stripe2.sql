/*
HARD Stripe SQL https://datalemur.com/questions/sql-rolling-earnings
Assume you are given the table below containing information on user transactions on Stripe. 
Write a query to obtain all of the users' rolling 3-day earnings. Output the user ID, transaction date and rolling 3-day earnings.
*/

with stripe as(SELECT user_id, round(sum(amount),2) as total, 
cast(transaction_date as date)
FROM user_transactions
GROUP BY user_id, cast(transaction_date as date)
)

SELECT user_id, transaction_date,
avg(total) OVER(ORDER BY transaction_date
     ROWS BETWEEN 2 PRECEDING AND CURRENT ROW )
     as rolling_earnings_3d
     FROM stripe
     ORDER BY user_id, transaction_date
