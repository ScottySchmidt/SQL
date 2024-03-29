/*
https://leetcode.com/problems/department-top-three-salaries/description/
185. Department Top Three Salaries

This problem is considered HARD level.
Write an SQL query to find the employees who are high earners in each of the departments.

I solved this problem using dense_rank(). 
However, most people likely would use a HAVING count(*) statement.
I will keep trying to make a second solution without dense_rank().
---------------
*/

with cte as (
SELECT 
d.name as Department,
e.name as Employee,
salary,
dense_rank () OVER(PARTITION BY d.name order by salary DESC ) as rn
FROM employee e
JOIN department d
on e.departmentId=d.id
)

SELECT Department, Employee, Salary
FROM cte
WHERE rn<4
;



#https://leetcode.com/problems/rank-scores/description/
# Only a Medium level problem but good DENSE_RANK practice
SELECT s.score, DENSE_RANK () OVER (
    ORDER BY s.score DESC 
) as 'rank'
FROM scores s;

#Sources: https://www.sqlservertutorial.net/sql-server-window-functions/sql-server-dense_rank-function/
