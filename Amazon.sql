/* 
Highest-Grossing Items [Amazon SQL Interview Question] https://datalemur.com/questions/sql-highest-grossing
The most challenging part is using row_number OVER to rank the products 
But otherwise this is a rather simple problem thus why its only ranked Medium level.
Source: https://stackoverflow.com/questions/2129693/using-limit-within-group-by-to-get-n-results-per-group
*/

# My solution on Jan 2023:
with amazon as (
SELECT category, product, sum(spend) as total_spend,
EXTRACT(YEAR FROM transaction_date) as date_year,
row_number() over (partition by category 
ORDER BY sum(spend) DESC) as rn
FROM product_spend
GROUP BY category, product, date_year
)

SELECT category, product, total_spend
from amazon
WHERE date_year=2022
AND amazon.rn < 3
ORDER BY category, total_spend DESC
;

