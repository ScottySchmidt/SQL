*/ 
International Call Percentage [Verizon SQL Interview Question] https://datalemur.com/questions/international-call-percentage

Notes: If one uses *100 the nunber rounds to a whole decimal. Therefore, one must use 100.0. 
-------------------------------------
/*


WITH phone AS (
SELECT 
pc.caller_id,
pc.receiver_id,
caller.country_id as call_country,
rec.country_id as rec_country
FROM phone_calls pc 
LEFT JOIN phone_info caller 
ON pc.caller_id=caller.caller_id
LEFT JOIN phone_info rec  
ON pc.receiver_id=rec.caller_id
),

international AS (SELECT caller_id, receiver_id, call_country, rec_country
FROM phone
WHERE call_country<>rec_country
)

SELECT ROUND((SELECT COUNT(*) FROM international)*100.0/(SELECT COUNT(*) FROM phone_calls),1)AS international_calls_pct
;
