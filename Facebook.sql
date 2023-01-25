Advertiser Status [Facebook SQL Interview Question]
https://datalemur.com/questions/updated-status

Need to reattempt at later day had to use a hint 

--------------------------------
WITH payments AS (
SELECT ad.user_id, ad.status, pay.paid
FROM advertiser ad
LEFT JOIN daily_pay pay
USING (user_id)
UNION
SELECT pay.user_id, ad.status, pay.paid
FROM daily_pay pay
LEFT JOIN advertiser ad
USING (user_id)
)

SELECT 
user_id,
CASE 
WHEN status IS NULL THEN 'NEW' 
WHEN paid IS NULL THEN 'CHURN'
WHEN status='CHURN' AND paid>0 THEN 'RESURRECT'
WHEN paid >0 THEN 'EXISTING'
END AS new_status
FROM payments
ORDER BY user_id
;
