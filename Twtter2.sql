/*
Twitter Campaign activation date
https://sqlpad.io/questions/189/campaign-activation-date/

Twitter's users can create an advertiser account so that they start ad campaigns;
A campaign has a unique campaign_id and a unique campaign_type;
Activation day is the first day an advertiser account starts spending.
Instruction

Write a query to find the activation day for every account.
Return null if an account has not activated any of the campaigns yet.

This problem is a great question that tests using a window function while detecting NULL values:
1. Use row_number window function which can put a row_num on each account_id by date.
2. Use a case statement to fnd NULL values not detected within the window function
*/

with twitter as(
SELECT c.account_id, s.date,
CASE
  WHEN s.date IS NOT NULL THEN row_number() OVER(PARTITION BY account_id ORDER BY s.date ASC) 
 ELSE NULL END as rn
  
FROM twitter_campaigns c
JOIN twitter_campaign_spend s
ON c.campaign_id = s.campaign_id
GROUP BY c.account_id, s.date
ORDER BY c.account_id
),

nulls as (
SELECT c.account_id, s.date
FROM twitter_campaigns c
JOIN twitter_campaign_spend s
ON c.campaign_id = s.campaign_id
WHERE s.date IS null
)

select account_id, date as start_date
FROM twitter 
WHERE rn=1
UNION
SELECT account_id, date as start_date
FROM twitter
WHERE date IS null
