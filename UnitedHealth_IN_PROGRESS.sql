/*
Patient Analysis [UnitedHealth SQL Interview Question]
https://datalemur.com/questions/patient-call-history

UnitedHealth Group has a program called Advocate4Me,
which allows members to call an advocate and receive support for their health care needs 
– whether that's behavioural, clinical, well-being, health care financing, benefits, claims or pharmacy help.
Write a query to get the patients who made a call within 7 days of their previous call. 
If a patient called more than twice in a span of 7 days, count them as once.

Use of Lag likely required which is what I assumed:
https://stackoverflow.com/questions/52874919/returning-data-where-dates-are-at-least-7-days-apart
*/

with policies as (
SELECT policy_holder_id, call_received,
LAG (call_received) OVER (
PARTITION BY policy_holder_id
ORDER BY policy_holder_id DESC, call_received
) prev_date
FROM callers
) 

SELECT * FROM policies
---where call_received > dateadd(dd, 7, prev_date)
;
