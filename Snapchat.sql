/* 
Sending vs. Opening Snaps [Snapchat SQL Interview Question] https://datalemur.com/questions/time-spent-snaps
Assume you are given the tables below containing information on Snapchat users, their ages, and their time spent sending and opening snaps.
Write a query to obtain a breakdown of the time spent sending vs. opening snaps (as a percentage of total time spent on these activities) for each age group.
Output the age bucket and percentage of sending and opening snaps. Round the percentage to 2 decimal places.

You should calculate these percentages:
time sending / (time sending + time opening)
time opening / (time sending + time opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.
------------------------------------
*/

---Second Solution without any hints:
with snap as ( SELECT a.activity_type, a.user_id, a.time_spent, a.activity_date, ages.age_bucket
FROM activities a
INNER JOIN age_breakdown ages 
ON a.user_id = ages.user_id
),

open as (
SELECT age_bucket, sum(time_spent) as open_perc
FROM snap
WHERE activity_type='open'
GROUP BY age_bucket
),

send as (
SELECT age_bucket, sum(time_spent) as send_perc
FROM snap
WHERE activity_type='send'
GROUP BY age_bucket
),

total as (
SELECT age_bucket, sum(time_spent) as total
FROM snap
WHERE activity_type='send' OR activity_type='open'
GROUP BY age_bucket
)

SELECT o.age_bucket, 
round((100.00*s.send_perc/t.total), 2)  as send_perc,
round((100.00*o.open_perc/t.total), 2)  as open_perc
FROM open o
JOIN send s  
ON o.age_bucket = s.age_bucket
JOIN total t
ON s.age_bucket = t.age_bucket

--First CASE solution with some hints:
WITH snap AS (
SELECT 
age.age_bucket,
SUM(CASE WHEN a.activity_type='send' THEN a.time_spent
ELSE 0 END) as send_time,
SUM(CASE WHEN a.activity_type='open'
THEN a.time_spent ELSE 0 END) as open_time,
SUM(CASE WHEN a.activity_type='send' OR a.activity_type='open' THEN a.time_spent
ELSE 0 END) as total_time
  
FROM activities a
INNER JOIN age_breakdown as age
USING (user_id)
GROUP BY age.age_bucket
)

SELECT age_bucket, 
round(send_time/total_time*100, 2) as send_perc, 
round(open_time/total_time*100, 2) as open_perc
FROM snap
;
