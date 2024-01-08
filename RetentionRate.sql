/* 
Retention Rate: Hard Meta/SakesForce SQL StrataSratch
Find the monthly retention rate of users for each account separately for Dec 2020 and Jan 2021. 
Retention rate is the percentage of active users an account retains over a given period of time.
In this case, assume the user is retained if he/she stays with the app in any future months. 
For example, if a user was active in Dec 2020 and has activity in any future month, consider them retained for Dec. 
You can assume all accounts are present in Dec 2020 and Jan 2021. 
Your output should have the account ID and the Jan 2021 retention rate divided by Dec 2020 retention rate.
https://platform.stratascratch.com/coding/2053-retention-rate?code_type=3
*/

--- SQL Server Solution: A subquery is needed for this solution within each cte first.  
with dec2020 as (SELECT account_id, 
count(user_id) as count1
FROM sf_events
where user_id in(
Select user_id from sf_events where year(date)='2021'and month(date)='1'
)
GROUP BY account_id
),

jan2021 as(SELECT account_id, 
count(user_id) as count2
FROM sf_events
where user_id in(
Select user_id from sf_events where year(date)='2020'and month(date)='12'
)
GROUP BY account_id
)

SELECT j.account_id, (d.count1/j.count2) as retention
FROM jan2021 j
INNER JOIN dec2020 d
ON d.account_id = j.account_id
ORDER BY j.account_id
