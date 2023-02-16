/*
https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem?isFullScreen=true
ADVANCED - Hardest Hackerrank SQL problem

The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest). 
Fnd the hacker_id and name of the hacker who made maximum number of submissions each day.
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.
-----------------
*/

#SETUP DAILY HACKERS TBL:
DECLARE @daily_hackers TABLE (
hacker_id INT,
submission_date DATE
);

INSERT INTO @daily_hackers
SELECT 
hacker_id,
submission_date
FROM submissions 
;

SELECT hacker_id, submission_date
FROM @daily_hackers;



---------------------------------------
--- person with most submissions each day:
with max_sub as ( SELECT h.hacker_id, h.name, s.submission_date, count(h.hacker_id) as subs, 
rank() OVER(PARTITION BY submission_date ORDER BY count(h.hacker_id) DESC, h.hacker_id ASC) as rn 
FROM hackers h
INNER JOIN submissions s
ON h.hacker_id=s.hacker_id
GROUP BY h.hacker_id, h.name, s.submission_date
                 )
                 
SELECT submission_date, subs, hacker_id, name, rn
FROM max_sub
WHERE rn=1
;



-----------------
#INCORRECT! This method below I realized will ignore the daily_count of users:
select h.hacker_id ,h.name
from submissions as s
join hackers as h 
on h.hacker_id = s.hacker_id
group by s.hacker_id,h.name
having count(distinct submission_date) = 15
