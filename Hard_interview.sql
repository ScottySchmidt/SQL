# https://www.hackerrank.com/challenges/interviews/forum
# My intial solution is currently showing duplicates which is why I believe it is incorrect.
# After some research, I realize this problem is rated 'Hard' which is why it is hard. 
# I will keep my initial solution as a draft below

SELECT c.contest_id, c.hacker_id, c.name,
SUM(s.total_submissions),
SUM(s.total_accepted_submissions),
SUM(v.total_views),
SUM(v.total_unique_views)
FROM contests c
INNER JOIN colleges col ON c.contest_id=col.contest_id
INNER JOIN challenges ch ON col.college_id=ch.college_id
JOIN view_stats v on ch.challenge_id=v.challenge_id
JOIN submission_stats s ON ch.challenge_id=s.challenge_id
GROUP BY c.contest_id, col.college_id, c.name, c.hacker_id
HAVING
SUM(s.total_submissions+s.total_accepted_submissions+v.total_views+v.total_unique_views) 
ORDER BY c.contest_id ASC
;
