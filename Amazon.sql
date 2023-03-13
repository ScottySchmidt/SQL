/* 
Highest-Grossing Items [Amazon SQL Interview Question] https://datalemur.com/questions/sql-highest-grossing
he most challenging partusing row_number OVER to rank the products 
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


/*
Using https://www.eversql.com/sql-query-optimizer/ found two ways to increase efficiency:
1. Explicitly ORDER BY After GROUP BY:
By default, the database sorts all 'GROUP BY col1, col2, ...' queries as if you specified 'ORDER BY col1, col2, ...' in the query as well. 
If a query includes a GROUP BY clause but you want to avoid the overhead of sorting the result, you can suppress sorting by specifying 'ORDER BY NULL'.
2. Mixed Order By Directions Prevents Index Use
The database will not use a sorting index (if exists) in cases where the query mixes ASC (the default if not specified) and DESC order. 
To avoid filesort, you may consider using the same order type for all columns
*/

#EverSQL recommended solution:
WITH amazon AS (SELECT
        product_spend.category,
        product_spend.product,
        sum(product_spend.spend) AS total_spend,
        EXTRACT(YEAR 
    FROM
        transaction_date) AS date_year,
        row_number() OVER (PARTITION 
    BY
        category 
    ORDER BY
        sum(product_spend.spend) DESC) AS rn 
    FROM
        product_spend 
    GROUP BY
        product_spend.category,
        product_spend.product,
        date_year 
    ORDER BY
        NULL) SELECT
        amazon.category,
        amazon.product,
        amazon.total_spend 
    FROM
        amazon 
    WHERE
        amazon.date_year = 2022 
        AND amazon.rn < 3 
    ORDER BY
        amazon.category,
        amazon.total_spend DESC
