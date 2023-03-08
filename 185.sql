*/
https://leetcode.com/problems/department-top-three-salaries/description/
185. Department Top Three Salaries - HARD Leetcode Problem

A company's executives are interested in seeing who earns the most money in each of the company's departments.
A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
Write an SQL query to find the employees who are high earners in each of the departments.

The slow runtime way to solve this problem is to use a window function.
The below method is only 10% faster than other solutions.
In addition, I will post a second more efficient way to solve this problem.
/*

with salaries as (SELECT 
d.name as Department,
e.name as Employee, 
e.salary as Salary,
dense_rank() over(PARTITION BY d.id ORDER BY e.salary DESC) as rn
FROM Employee e
JOIN Department d
ON e.departmentId=d.id
)

SELECT Department, Employee, Salary
FROM salaries
WHERE rn<4
