/*
Sales Growth per Territory, Hard Shopify, StrataStratch Affiliate: https://www.stratascratch.com/?via=scott
Write a query to return Territory and corresponding Sales Growth. 
Compare growth between periods Q4-2021 vs Q3-2021.
If Territory (say T123) has Sales worth $100 in Q3-2021 and Sales worth $110 in Q4-2021, 
then the Sales Growth will be 10% [ i.e. = ((110 - 100)/100) * 100 ]
Output the ID of the Territory and the Sales Growth. 
Only output these territories that had any sales in both quarters.
*/

-- YouTube Solution: https://www.youtube.com/watch?v=Fpa1As5TgB0
WITH q3 AS (
    SELECT t.territory_id,
           SUM(s.order_value) AS total_sales_q3
    FROM fct_customer_sales s
    INNER JOIN map_customer_territory t
    USING (cust_id)
    WHERE YEAR(order_date) = 2021
    AND EXTRACT(QUARTER FROM order_date) = 3
    GROUP BY t.territory_id
),
q4 AS (
    SELECT t.territory_id,
           SUM(s.order_value) AS total_sales_q4
    FROM fct_customer_sales s
    INNER JOIN map_customer_territory t
    USING (cust_id)
    WHERE YEAR(order_date) = 2021
    AND EXTRACT(QUARTER FROM order_date) = 4
    GROUP BY t.territory_id
)

SELECT 
    q3.territory_id,
    (q4.total_sales_q4 - q3.total_sales_q3) / q3.total_sales_q3 * 100 AS sales_growth
FROM q3
JOIN q4 ON q3.territory_id = q4.territory_id; 4
    GROUP BY s.cust_id, t.territory_id
),

variance as(SELECT q3.territory_id, 
       sum(q3.total_sales) AS q3_total_sales,
       sum(q4.total_sales) AS q4_total_sales
FROM q3 
INNER JOIN q4 
ON q3.territory_id = q4.territory_id
GROUP BY q3.territory_id
ORDER BY q3.territory_id
)

SELECT 
territory_id, 
(q4_total_sales-q3_total_sales)/
q3_total_sales*100 as sales_growth
FROM variance

