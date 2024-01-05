/*
185. Department Top Three Salaries - HARD Leetcode Problem
https://leetcode.com/problems/department-top-three-salaries/description/

A company's executives are interested in seeing who earns the most money in each of the company's departments.
A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
Write an SQL query to find the employees who are high earners in each of the departments.
*/

-- SQL Server Solution beats 79% runtime: https://www.youtube.com/watch?v=JKWqHmUvT2w
with emp_data as (SELECT d.name as Department, e.name as Employee, e.salary as Salary,
e.departmentId as dept_id, 
dense_rank() OVER(PARTITION BY e.departmentId ORDER BY e.salary DESC) as d_rank
FROM Employee e
INNER JOIN Department d
ON e.departmentId = d.id
)

SELECT Department, Employee, Salary
FROM emp_data
WHERE d_rank < 4

