/*
Correlation Between E-mails And Activity Time - Hard Oracle SQL
There are two tables with user activities. 
The google_gmail_emails table contains information about emails being sent to users. 
Each row in that table represents a message with a unique identifier in the id field. The google_fit_location table contains user activity logs from the Google Fit app.
Find the correlation between the number of emails received and the total exercise per day. 
The total exercise per day is calculated by counting the number of user sessions per day.
https://platform.stratascratch.com/coding/10069-correlation-between-e-mails-and-activity-time?code_type=7
*/

--Since SQL Server and MySQL has no CORR function, I will be using Oracle. Note: Doing this in Python way easier since Python is build for statistics

-- Current first solution is close but incorrect:
with cte as(select DISTINCT f.user_id, f.session_id as session_id, f.day as f_day, 
COALESCE(e.day,0) as e_day
from google_fit_location f
LEFT JOIN google_gmail_emails e
ON e.to_user = f.user_id
AND e.day = f.day
),

email_cte as(
SELECT e_day, count(user_id) as num_emails
FROM cte
GROUP BY e_day
),

fit_cte as(SELECT f_day, count(DISTINCT session_id) as fit_count
FROM cte
GROUP BY f_day
)

SELECT corr(f.fit_count, e.num_emails) as corr 
FROM fit_cte f
FULL OUTER JOIN email_cte e
ON e.e_day = f.f_day


