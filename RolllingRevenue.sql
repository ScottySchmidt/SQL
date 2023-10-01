/* Revenue Over Time https://platform.stratascratch.com/coding/10314-revenue-over-time?code_type=5

Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. Do not include returns which are represented by negative purchase values. 
Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.

A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.
*/

with amazon_revenue as (
SELECT FORMAT(CAST(created_at AS DATE), 'yyyy-MM') AS YearMonth, purchase_amt 
FROM amazon_purchases),

amazon_month_revenue as (SELECT YearMonth, 
sum(purchase_amt) as revenue
FROM amazon_revenue
GROUP BY YearMonth
)

SELECT YearMonth, AVG(revenue) OVER (ORDER BY YearMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as ThreeMonthAverageSales
FROM amazon_month_revenue;


YearMonth	ThreeMonthAverageSales
2020-01	17330
2020-02	18708
2020-03	21397
2020-04	21398
2020-05	22936
2020-06	22035
2020-07	22705
2020-08	21496
