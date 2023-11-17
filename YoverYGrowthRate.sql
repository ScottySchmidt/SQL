/*
Y-over-Y Growth Rate [Wayfair SQL Interview Question] https://datalemur.com/questions/yoy-growth-rate  First Hard SQL

Assume you are given the table below containing information on user transactions for particular products.
Write a query to obtain the year-on-year growth rate for the total spend of each product for each year.
Output the year (in ascending order) partitioned by product id, current year's spend, previous year's spend and year-on-year growth rate (percentage rounded to 2 decimal places).

user_transactions Example Input:
transaction_id	product_id	spend	transaction_date
1341	123424	1500.60	12/31/2019 12:00:00
1423	123424	1000.20	12/31/2020 12:00:00
1623	123424	1246.44	12/31/2021 12:00:00
1322	123424	2145.32	12/31/2022 12:00:00

Example Output:
year	product_id	curr_year_spend	prev_year_spend	yoy_rate
2019	123424	1500.60		
2020	123424	1000.20	1500.60	-33.35
2021	123424	1246.44	1000.20	24.62
2022	123424	2145.32	1246.44	72.12
The third row in the example output shows that the spend for product 123424 grew 24.62% from 1000.20 in 2020 to 1246.44 in 2021.
-----------------------------------------------------------------------------------------------------------------------
*/

with wayfair as(SELECT transaction_id, product_id, spend,
EXTRACT(YEAR FROM transaction_date) as year
FROM user_transactions
),

way_curr as (SELECT product_id, year, sum(spend) as curr_year_spend
FROM wayfair
GROUP BY product_id, year
ORDER BY product_id, year
),

way_prev as( SELECT product_id, year, curr_year_spend,
lag(curr_year_spend, 1) OVER(PARTITION BY product_id) as prev_year_spend
FROM way_curr
)

SELECT year, product_id, curr_year_spend, prev_year_spend,
round((100.00*(curr_year_spend-prev_year_spend)/prev_year_spend), 2) as yoy_rate
FROM way_prev


---First original solution using a hint:
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
