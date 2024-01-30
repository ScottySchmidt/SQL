/*
Election Results - Deloitte and Google - StrataScratch 

The election is conducted in a city and everyone can vote for one or more candidates, or choose not to vote at all. 
Each person has 1 vote so if they vote for multiple candidates, their vote gets equally split across these candidates.
For example, if a person votes for 2 candidates, these candidates receive an equivalent of 0.5 vote each.
Find out who got the most votes and won the election. Output the name of the candidate or multiple names in case of a tie. 
To avoid issues with a floating-point error you can round the number of votes received by a candidate to 3 decimal places.
*/

-- 1. Get the num of votes each person made 
-- 2. Join the two datasets together, divide by 1 by amount of votes each person made (since the votes get split across these candidates)
-- 3. Get the election results sum GROUP BY the candidate
-- 4. To get the answer select first (top 1) candidate ordered by total_votes in descending order. 

--- SQL Server Solution:
with num_votes as(SELECT voter, count(candidate) as num_votes
FROM voting_results
GROUP BY voter
),

cte as(SELECT v.voter, v.candidate, (1/n.num_votes) as total_votes
FROM voting_results v
INNER JOIN num_votes n
ON v.voter = n.voter
WHERE n.num_votes <> 0 
AND v.candidate is not null
), 
election as (SELECT candidate, sum(total_votes) as total_votes
FROM cte
GROUP BY candidate
)
SELECT top 1 candidate
FROM election
ORDER BY total_votes DESC
