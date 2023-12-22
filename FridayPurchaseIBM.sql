/*
IBM is working on a new feature to analyze user purchasing behavior for all Fridays in the first quarter of the year. 
For each Friday, calculate the average amount users have spent. 
The output should contain the week number of that Friday and average amount spent.
https://platform.stratascratch.com/coding/10358-friday-purchases?code_type=5
*/

---Sql Server Solution:
with sales_data as (SELECT user_id, date, 
amount_spent, day_name, DATEPART(WEEK, date) AS WeekNumber 
FROM user_purchases
WHERE day_name = 'Friday' 
AND MONTH(date) IN (1, 2, 3) 
AND year(date) ='2023'
),

-- Create WeekNumbers 1 to 13 in this case so we can match if WeekNumber null within sales_data:
WeekCTE AS (
  SELECT TOP 13
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS WeekNumber
  FROM sys.objects
)
-- Select WeekNumber with average amount_spent, handling null values with 0:
SELECT WeekCTE.WeekNumber, COALESCE(avg(amount_spent), 0)
FROM WeekCTE
LEFT JOIN cte 
ON cte.WeekNumber = WeekCTE.WeekNumber
GROUP BY WeekCTE.WeekNumber



---Python
import pandas as pd

df= user_purchases
df = user_purchases[
    (user_purchases['date'].dt.year == 2023) &
    (user_purchases['date'].dt.month.between(1, 3)) &
    (user_purchases['date'].dt.weekday == 4)  # Monday is 0 and Sunday is 6
]
df['week_number'] = df['date'].dt.week
average_amount_per_week = df.groupby('week_number')['amount_spent'].mean().reset_index()
