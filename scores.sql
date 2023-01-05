#https://www.hackerrank.com/challenges/full-score/problem
# My initial answer was incorrect because I JOINED difficulty first rather than challenges, Challenges must be first because it is joined later.
# Must use count(*) DESC so it orders by number of times person scored full points
# GROUPBY 1, 2 is shortcut for doing groupBy first two columns.
# EDIT - GROUPBY 1,2 shouldn't be used as not very documentary and columns can change later

SELECT h.hacker_id, h.name
FROM submissions s
JOIN hackers h
ON h.hacker_id = s.hacker_id
JOIN challenges c
ON s.challenge_id=c.challenge_id
JOIN difficulty d ON d.difficulty_level=c.difficulty_level
AND s.score=d.score
GROUP BY h.hacker_id, h.name
HAVING count(*) > 1
ORDER BY count(*) DESC, h.hacker_id ASC
;
