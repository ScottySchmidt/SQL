/*
Correlation Between E-mails And Activity Time - Hard Oracle SQL
There are two tables with user activities. 
The google_gmail_emails table contains information about emails being sent to users. 
Each row in that table represents a message with a unique identifier in the id field. 
The google_fit_location table contains user activity logs from the Google Fit app.
Find the correlation between the number of emails received and the total exercise per day. 
The total exercise per day is calculated by counting the number of user sessions per day.
https://platform.stratascratch.com/coding/10069-correlation-between-e-mails-and-activity-time?code_type=7
*/

-- YouTube Solution: https://www.youtube.com/watch?v=x08iNjp2r8g&feature=youtu.be
--Since SQL Server and MySQL has no CORR function, I will be using Oracle. Note: Doing this in Python way easier since Python is build for statistics
WITH cte AS (
    SELECT day, to_user, COUNT(*) AS c1
    FROM google_gmail_emails
    GROUP BY day, to_user
),
cte2 AS (
    SELECT day, user_id, COUNT(distinct session_id) AS c2
    FROM google_fit_location
    GROUP BY day, user_id
)

SELECT corr(COALESCE(a.c1,0), COALESCE(b.c2,0))
FROM cte a
FULL OUTER JOIN cte2 b 
ON a.day = b.day
AND a.to_user = b.user_id
