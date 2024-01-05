/* 
Year Over Year Churn, Hard SQL Lyft
StrataScratch Affiliate, Master Data Analytics, SQL, and Python: https://www.stratascratch.com/?via=scott

Find how the number of drivers that have churned changed in each year compared to the previous one.
Output the year (specifically, you can use the year the driver left Lyft) along with the corresponding number of churns in that year, the number of churns in the previous year, 
and an indication on whether the number has been increased (output the value 'increase'), decreased (output the value 'decrease') or stayed the same (output the value 'no change').
*/

-- SQL Server Solution:
WITH cte AS (
    SELECT COUNT([index]) AS total_churns, YEAR(end_date) AS end_year
    FROM lyft_drivers
    WHERE YEAR(end_date) IS NOT NULL
    GROUP BY YEAR(end_date)
),

cte2 as(SELECT end_year, total_churns, 
lead(total_churns, 1) OVER(ORDER BY end_year DESC) as previous_churn
FROM cte
),

cte3 as (SELECT end_year, COALESCE(total_churns,0) as total_churns, 
COALESCE(previous_churn,0) as previous_churn
FROM cte2
