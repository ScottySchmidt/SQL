/*
https://datalemur.com/questions/user-retention
Active User Retention [Facebook SQL Interview Question]

The table below containing information on Facebook user actions. 
Write a query to obtain the active user retention in July 2022. 
Output the month (in numerical format 1, 2, 3) and the number of monthly active users (MAUs).
Hint: An active user is a user who has user action ("sign-in", "like", or "comment") 
in the current month and last month.

FIRST SQL HARD PROBLEM. 
Keeping record of failed attempts. 
*/


---FAILED ATTEMPT 1 
---I had the right idea but definitely too complex has to be a better way
WITH facebook as (
SELECT EXTRACT(MONTH FROM event_date) as month, 
EXTRACT(YEAR FROM event_date) as year, 
user_id, event_id
FROM user_actions
WHERE event_type IN ('sign-in', 'like', 'comment')
),

active as (SELECT month, user_id 
FROM facebook
WHERE year=2022
AND MONTH in (6, 7)
ORDER BY user_id
)

SELECT month,  user_id 
FROM active
WHERE (month,user_id) IN(SELECT month, user_id 
FROM active
GROUP BY month, user_id
HAVING count(*)>0)
ORDER BY user_id
;
