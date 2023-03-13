/*
HARD Stripe SQL https://datalemur.com/questions/sql-rolling-earnings
Assume you are given the table below containing information on user transactions on Stripe. 
Write a query to obtain all of the users' rolling 3-day earnings. Output the user ID, transaction date and rolling 3-day earnings.
*/

# This was my first solution which correctly gets the rolling 3 day sum by rows:
with earnings as (SELECT user_id, sum(amount) as earnings, cast(transaction_date as date)
FROM user_transactions
GROUP BY user_id, cast(transaction_date as date)
)

SELECT user_id, transaction_date, 
sum(earnings) OVER(PARTITION BY user_id ORDER BY transaction_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as rolling_earnings_3d
FROM earnings
;

#However, the above method should only sum if the days are 3 days previously:
with earnings as (SELECT user_id, sum(amount) as earnings, cast(transaction_date as date)
FROM user_transactions
GROUP BY user_id, cast(transaction_date as date)
)

SELECT user_id, transaction_date, 
sum(earnings) OVER(PARTITION BY user_id ORDER BY transaction_date RANGE BETWEEN INTERVAL '2' DAY PRECEDING AND CURRENT ROW) as rolling_earnings_3d
FROM earnings
;

#Source: https://learnsql.com/blog/range-clause/
