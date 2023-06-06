/* 
Advertiser Status [Facebook SQL Interview Question]   https://datalemur.com/questions/updated-status

Write a query to update the Facebook advertiser's status using the daily_pay table. 
Advertiser is a two-column table containing the user id and their payment status based on the last payment and daily_pay table has current information about their payment. 
Only advertisers who paid will show up in this table.
Output the user id and current payment status sorted by the user id.

New: newly registered users who made their first payment.
Existing: users who paid previously and recently made a current payment.
Churn: users who paid previously, but have yet to make any recent payment.
Resurrect: users who did not pay recently but may have made a previous payment and have made payment again recently.
Example Output:
user_id	new_status
bing	CHURN
yahoo	EXISTING
alibaba	EXISTING
Bing's updated status is CHURN because no payment was made in the daily_pay table whereas Yahoo which made a payment is updated as EXISTING.

The dataset you are querying against may have different input & output - this is just an example!
Read this before proceeding to solve the question
For better understanding of the advertiser's status, we're sharing with you a table of possible transitions based on the payment status.

#	Start	End	Condition
1	NEW	EXISTING	Paid on day T
2	NEW	CHURN	No pay on day T
3	EXISTING	EXISTING	Paid on day T
4	EXISTING	CHURN	No pay on day T
5	CHURN	RESURRECT	Paid on day T
6	CHURN	CHURN	No pay on day T
7	RESURRECT	EXISTING	Paid on day T
8	RESURRECT	CHURN	No pay on day T
Row 2, 4, 6, 8: As long as the user has not paid on day T, the end status is updated to CHURN regardless of the previous status.
Row 1, 3, 5, 7: When the user paid on day T, the end status is updated to either EXISTING or RESURRECT, depending on their previous state. RESURRECT is only possible when the previous state is CHURN. When the previous state is anything else, the status is updated to EXISTING.
---------------------------------------

HOW TO SOLVE:
This problem requires dealing with new potential data that will not match with a normal join.
The typical FULL OUTER JOIN method will work if used with a COALSECE() function.
This function will still find the user_id if one table happens to be NULL. 
*/
SELECT COALESCE(a.user_id, d.user_id) as user_id, 
CASE 
WHEN status='CHURN' AND d.paid>0 THEN 'RESURRECT' 
WHEN paid IS NULL THEN 'CHURN'
WHEN a.user_id IS NULL THEN 'NEW'
ELSE 'EXISTING'
END as new_stats
FROM advertiser a 
FULL OUTER JOIN daily_pay d   
USING(user_id)
ORDER BY user_id


#Another method is to use UNION which was an original way that the hints recommended:
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
