/*
Patient Analysis [UnitedHealth SQL Interview Question]
https://datalemur.com/questions/patient-call-history

UnitedHealth Group has a program called Advocate4Me,
which allows members to call an advocate and receive support for their health care needs 
– whether that's behavioural, clinical, well-being, health care financing, benefits, claims or pharmacy help.
Write a query to get the patients who made a call within 7 days of their previous call. 
If a patient called more than twice in a span of 7 days, count them as once.

Use of Lag: https://stackoverflow.com/questions/52874919/returning-data-where-dates-are-at-least-7-days-apart
Note: PostSQL uses date_part and not the typical datediff.
*/

with cte as (SELECT policy_holder_id, 
call_received, 
lag(call_received, 1) OVER(PARTITION BY policy_holder_id ORDER BY date(call_received)) as prev_date
FROM callers
)

SELECT count(distinct(policy_holder_id))
FROM cte
where date_part('day', call_received-prev_date)<7;



---After research, I found EPOCH which can convert datetime into seconds.
with united_policy as (
SELECT policy_holder_id,
call_received,
EXTRACT(EPOCH FROM call_received - LAG(call_received) 
OVER(
PARTITION BY policy_holder_id
ORDER BY call_received) )
FROM callers
),

t2 as (SELECT policy_holder_id,
extract/(60*60*24) as day_diff 
FROM united_policy
),

t3 as (SELECT policy_holder_id, day_diff
FROM t2
WHERE day_diff<7
)

SELECT count(DISTINCT policy_holder_id)
FROM t3
;
