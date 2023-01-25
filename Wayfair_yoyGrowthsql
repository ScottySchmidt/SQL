Y-on-Y Growth Rate [Wayfair SQL Interview Question]
https://datalemur.com/questions/yoy-growth-rate
This is my first hard problem! And first time using LAG window_function.
Need to reattempt the problem again had to use lots of research

========================================
with yearly_spend AS (
SELECT
EXTRACT(YEAR from transaction_date) as year,
product_id, 
spend as year_spend
FROM user_transactions
),

yearly_lag as (
SELECT year, product_id, year_spend,
LAG(year_spend, 1) OVER ( 
PARTITION BY product_id
) AS prev_year_spend
FROM yearly_spend 
)

SELECT year, product_id, year_spend, prev_year_spend,
round( 100*(year_spend-prev_year_spend) / prev_year_spend, 2) as yoy_rate
FROM yearly_lag
;
