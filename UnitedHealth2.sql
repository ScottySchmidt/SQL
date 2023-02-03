/*
Patient Support Analysis (Part 4) [UnitedHealth SQL Interview Question]
https://datalemur.com/questions/long-calls-growth

UnitedHealth Group has a program called Advocate4Me, which allows members to call an advocate and receive support for their health care needs
A long-call is categorised as any call that lasts more than 5 minutes (300 seconds). 
What's the month-over-month growth of long-calls?
Output the year, month (both in numerical and chronological order) and growth percentage rounded to 1 decimal place.

Must do an order by in the LAG statement or the months will do incorrect calculations.
*/

with health as (
SELECT 
EXTRACT(YEAR FROM call_received) as yr,
EXTRACT(MONTH FROM call_received) as mth,
count(case_id) as curr
FROM callers
WHERE call_duration_secs>300
GROUP BY 
EXTRACT(YEAR FROM call_received),
EXTRACT(MONTH FROM call_received)
),

calls as (
SELECT yr, mth, curr,
lag(curr, 1) OVER (ORDER BY yr, mth ASC) as prev
FROM health
)

SELECT yr, mth, 
round(100.0*(curr-prev)/prev, 1) as growth_pct
FROM calls
ORDER BY yr, mth ASC
;

