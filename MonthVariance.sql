/*
Monthly Percentage Difference Amazon: https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?code_type=5

Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.
*/ 

with amazon_sales as (SELECT id, month(created_at) as mth, year(created_at) as year, value, purchase_id 
FROM sf_transactions),

monthly_amazon_sales as (SELECT sum(value) as monthly_sales, min(mth) as mth, min(year) as year
FROM amazon_sales
GROUP BY mth, year),

amazon_variance AS (
    SELECT monthly_sales, mth, year, 
    LAG(monthly_sales) OVER (ORDER BY year, mth) AS prev_month_sales
    FROM monthly_amazon_sales
)

SELECT mth, year, monthly_sales, prev_month_sales
FROM amazon_variance
;
