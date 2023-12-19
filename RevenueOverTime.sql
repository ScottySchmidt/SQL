/* Revenue Over Time https://platform.stratascratch.com/coding/10314-revenue-over-time?code_type=5

Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. Do not include returns which are represented by negative purchase values. 
Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.

A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.
*/


--My SQL has a different date_format:
with amazon_revenue as (
SELECT DATE_FORMAT(created_at, '%Y-%m') AS YearMonth, purchase_amt 
FROM amazon_purchases
WHERE purchase_amt  >0),

amazon_month_revenue as (SELECT YearMonth, 
sum(purchase_amt) as revenue
FROM amazon_revenue
GROUP BY YearMonth
)

SELECT YearMonth, AVG(revenue) OVER (ORDER BY YearMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as ThreeMonthAverageSales
FROM amazon_month_revenue;

YearMonth	ThreeMonthAverageSales
2020-01	26292
2020-02	23493
2020-03	25535


--- Python
import pandas as pd

df=amazon_purchases

#Get each datetime as a date:
df['YearMonth'] = df['created_at'].astype(str).str[:7]

#Filter out negative purchase values:
filter_df = df[df['purchase_amt'] > 0]

#Group sum by purchase amount
grouped_df = filter_df.groupby('YearMonth')['purchase_amt'].sum().reset_index()

# Calculate the rolling average on the grouped DataFrame
grouped_df['RollingAverage'] = grouped_df['purchase_amt'].rolling(window=3, min_periods=1).mean().round(2)
grouped_df[['YearMonth', 'RollingAverage']]
