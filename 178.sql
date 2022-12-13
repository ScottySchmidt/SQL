# Only a Medium level problem but good DENSE_RANK practice
#https://leetcode.com/problems/rank-scores/description/
SELECT s.score, DENSE_RANK () OVER (
    ORDER BY s.score DESC 
) as 'rank'
FROM scores s;

#Sources: https://www.sqlservertutorial.net/sql-server-window-functions/sql-server-dense_rank-function/
