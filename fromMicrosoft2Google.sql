/*
From Microsoft to Google, Hard SQL StrataScratch: 
Consider all LinkedIn users who, at some point, worked at Microsoft. 
For how many of them was Google their next employer right after Microsoft (no employers in between)?

--------------------------

This problem is practical when analyzing employee or customer churn. 
What graduates were most successul from 'x' school? Or former companies? 
*/

--- SQL Server Solution self join method:
 WITH RankedEmployment AS (
  SELECT
    user_id,
    employer,
    start_date,
    end_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY start_date) AS employment_rank
  FROM linkedin_users
)
SELECT COUNT(*) AS count_of_users
FROM RankedEmployment AS a
JOIN RankedEmployment AS b ON a.user_id = b.user_id
WHERE a.employer = 'Microsoft'
  AND b.employer = 'Google'
  AND b.employment_rank - a.employment_rank = 1;
