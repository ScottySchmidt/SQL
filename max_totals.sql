# https://www.hackerrank.com/challenges/contest-leaderboard/problem 
# Must create a second table with every max_score using a groupby both hacker_id and challenge_id
# Get sum of every max_score. Use a USING JOIN by hacker_id

SELECT hacker_id, name, sum(max_score) as total_score
FROM
(SELECT hacker_id, max(score) as max_score
FROM submissions
GROUP BY hacker_id, challenge_id
) as t
INNER JOIN hackers USING (hacker_id)
GROUP BY hacker_id, name
HAVING total_score>0
ORDER by total_score DESC, hacker_id ASC
;
