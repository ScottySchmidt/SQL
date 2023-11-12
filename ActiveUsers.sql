/*
https://datalemur.com/questions/user-retention
Active User Retention [Facebook SQL Interview Question]

The table below containing information on Facebook user actions. 
Write a query to obtain the active user retention in July 2022. 
Output the month (in numerical format 1, 2, 3) and the number of monthly active users (MAUs).
Hint: An active user is a user who has user action ("sign-in", "like", or "comment") 
in the current month and last month.

FIRST SQL HARD PROBLEM. 
This problem was hard. In fact, my current solution below takes 50 codes of line which seems too long.
I would likely need a better solution althought it gets the correct solution
*/

---More concise solution I did months later:
with facebook as(SELECT user_id, event_id,
EXTRACT(MONTH FROM event_date) as mth
FROM user_actions
WHERE event_type in ('sign-in', 'like', 'comment')
AND EXTRACT(YEAR FROM event_date)='2022'
AND EXTRACT(MONTH FROM event_date) IN ('6', '7') )

SELECT mth, 
count(DISTINCT user_id) as monthly_active_users
FROM facebook
WHERE mth='7'
AND user_id IN 
(SELECT user_id FROM facebook WHERE mth='6')
GROUP BY mth
;


---First Working Solution:
with facebook as (
SELECT user_id,
EXTRACT(MONTH FROM event_date) as m,
EXTRACT(YEAR FROM event_date) as y
FROM user_actions
),

cur_month as(
SELECT m as month, user_id
FROM facebook
WHERE m=7
AND y=2022
GROUP BY user_id, m, y
),

prev_month as (
SELECT m, user_id
FROM facebook
WHERE m=6
AND y=2022
GROUP BY user_id, m, y
),

active AS (SELECT month, user_id
FROM cur_month
JOIN prev_month
USING (user_id)
)

SELECT month, count(user_id) as monthly_active_users
FROM active
GROUP BY month
;

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
