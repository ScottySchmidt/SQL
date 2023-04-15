/*
570. Managers with at Least 5 Direct Reports: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key column for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
-------------------------------------------
*/

-- Initial quick solution:
with managers as(
SELECT e1.managerId, count(e1.managerId) as manage_count
FROM employee e1
GROUP BY e1.managerId
HAVING count(e1.managerId) > 4
)

SELECT 
CASE WHEN employee.name IS NULL THEN ""
ELSE employee.name 
END  as name
FROM managers
LEFT JOIN employee
ON managers.managerId = employee.id
