/*
Patient Support Analysis (Part 4) [UnitedHealth SQL Interview Question]
https://datalemur.com/questions/long-calls-growth

UnitedHealth Group has a program called Advocate4Me, which allows members to call an advocate and receive support for their health care needs
A long-call is categorised as any call that lasts more than 5 minutes (300 seconds). 
What's the month-over-month growth of long-calls?
Output the year, month (both in numerical and chronological order) and growth percentage rounded to 1 decimal place.

My current solution gets the correct answer only some of the time. 
Need to a small error.
*/

with health as (
SELECT policy_holder_id,
EXTRACT(YEAR FROM call_received) as yr,
EXTRACT(MONTH FROM call_received) as mth,
call_received, call_duration_secs
FROM callers
WHERE call_duration_secs>300
),

calls AS (SELECT yr, mth, count(policy_holder_id) as call_count
FROM health
GROUP BY yr, mth
),

previous as ( SELECT *, LAG(call_count, 1) OVER (order by mth ASC) as prev
FROM calls
)

SELECT yr, mth, call_count, prev, 
round( (call_count-prev)/prev,1)*100.0 as growth_pct
FROM previous
ORDER BY yr, mth ASC
;


