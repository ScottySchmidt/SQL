/*
https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem?isFullScreen=true
ADVANCED - Hardest Hackerrank SQL problem?

The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest). 
Fnd the hacker_id and name of the hacker who made maximum number of submissions each day.
If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. 
The query should print this information for each day of the contest, sorted by the date.
-----------------
*/

select h.hacker_id ,h.name
from submissions as s
join hackers as h 
on h.hacker_id = s.hacker_id
group by s.hacker_id,h.name
having count(distinct submission_date) = 15
