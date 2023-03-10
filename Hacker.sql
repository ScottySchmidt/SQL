/* 
HARD SQL Hackerrank: https://www.hackerrank.com/challenges/interviews/problem?isFullScreen=true
Samantha interviews many candidates from different colleges using coding challenges and contests. 
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. 
Exclude the contest from the result if all four sums are .
Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.

To solve this problem one must:
1. Join contest, college, and challenge tables.
2. LEFT JOIN view table which is grouped by challenge_id
3. LEFT JOIN submissions table which is grouped by challenge_id
4. GROUP c.contest_id to find sums of submissions and views.
5. Using HAVING clause to exclude those with totals of 0
*/

SELECT c.contest_id, c.hacker_id, c.name,
sum(s.total_submissions),
sum(s.total_accepted_submissions),
sum(v.total_views),
sum(v.total_unique_views)
FROM contests c
JOIN colleges col
ON c.contest_id=col.contest_id
JOIN challenges ch
on ch.college_id=col.college_id
LEFT JOIN(SELECT 
challenge_id, 
sum(total_views) as total_views,
sum(total_unique_views) as total_unique_views
FROM view_stats 
GROUP BY challenge_id) v
ON v.challenge_id=ch.challenge_id
LEFT JOIN(SELECT
challenge_id,
sum(total_submissions) as total_submissions,
sum(total_accepted_submissions) as total_accepted_submissions
FROM Submission_Stats
GROUP BY challenge_id
) s
ON s.challenge_id=ch.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING sum(s.total_submissions)+sum(s.total_accepted_submissions)+sum(v.total_views)+sum(v.total_unique_views)>0
order by c.contest_id
