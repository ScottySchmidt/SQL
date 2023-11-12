/*
Monthly Percentage Difference Amazon: https://platform.stratascratch.com/coding/10319-monthly-percentage-difference?code_type=5

Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.
*/ 

--MySql and SQL Server
WITH amazon_sales AS (
    SELECT
        LEFT(created_at, 7) AS FormattedMonth,
        sum(value) as month_sales
    FROM
        sf_transactions
    GROUP BY LEFT(created_at, 7)
), 

amazon_variance as(SELECT
    FormattedMonth,
    month_sales,
    lag(month_sales, 1) OVER (ORDER BY FormattedMonth) as prev_month_sales
FROM
    amazon_sales
    )
    
    SELECT FormattedMonth,
    100.00*(month_sales - prev_month_sales)/prev_month_sales
    FROM amazon_variance;


--Python
import pandas as pd

df= sf_transactions[['created_at', 'value']]
df['year_month'] = df['created_at'].astype(str).str[:7]

# Create a DataFrame to store the monthly sums
variance_df = df.groupby('year_month')['value'].sum().reset_index()

# Create the 'previous_month' column by shifting 'year_month'
variance_df['previous_month_revenue'] = variance_df['value'].shift(1)

variance_df['revenue_change'] = (100.00*(variance_df['value']-variance_df['previous_month_revenue'])/variance_df['previous_month_revenue']).round(2)

final_df = variance_df[['year_month', 'revenue_change']]
