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
