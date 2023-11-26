/*
IBM is working on a new feature to analyze user purchasing behavior for all Fridays in the first quarter of the year. 
For each Friday, calculate the average amount users have spent. 
The output should contain the week number of that Friday and average amount spent.
https://platform.stratascratch.com/coding/10358-friday-purchases?code_type=5
*/

---Sql Server 
with cte as (SELECT user_id, date, amount_spent, day_name
, DATEPART(WEEK, date) AS WeekNumber 
FROM user_purchases
WHERE day_name = 'Friday')

SELECT WeekNumber , avg(amount_spent) as avg_spent
FROM cte
GROUP BY WeekNumber 
ORDER BY WeekNumber
;
