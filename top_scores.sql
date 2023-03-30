/* 
Top Competitors, Medium SQL: https://www.hackerrank.com/challenges/full-score/problem
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
----------------------------------------------
*/

SELECT h.hacker_id, h.name
FROM submissions s
JOIN hackers h
ON h.hacker_id = s.hacker_id
JOIN challenges c
ON s.challenge_id=c.challenge_id
JOIN difficulty d ON d.difficulty_level=c.difficulty_level
AND s.score=d.score
GROUP BY h.hacker_id, h.name
HAVING count(*) > 1 ---Must use count(*) DESC so it orders by number of times person scored full points
ORDER BY count(*) DESC, h.hacker_id ASC
;
