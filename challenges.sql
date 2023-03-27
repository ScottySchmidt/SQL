/* Challenges HackerRank Medium SQL:  https://www.hackerrank.com/challenges/challenges/problem
Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order.
If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
*/ 

# Table1: hacker_id, ch_count
with t1 as (
SELECT h.hacker_id, 
count(DISTINCT ch.challenge_id) as ch_count
FROM hackers h
JOIN Challenges ch
ON h.hacker_id=ch.hacker_id
GROUP BY h.hacker_id
),

# Table2: attempts, ch_count
# Attempts is needed to not double count same challenge_id used in final WHERE statement
t2 AS (
SELECT count(hacker_id) as attempts, ch_count   
FROM t1
GROUP BY ch_count
)

# Final Results:
SELECT a.hacker_id, h.name, a.ch_count 
FROM t1 a
LEFT JOIN hackers h ON a.hacker_id=h.hacker_id
LEFT JOIN t2 b on a.ch_count=b.ch_count
where (b.attempts<2 OR
       a.ch_count in (SELECT max(ch_count) FROM t1) )
ORDER BY a.ch_count  DESC, a.hacker_id ASC
;
