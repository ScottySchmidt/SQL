# https://leetcode.com/problems/department-highest-salary/description/
SELECT 
Department.name as Department, 
Employee.name as Employee,
Salary 
FROM Employee 
JOIN 
Department on Employee.DepartmentId=Department.id
WHERE 
(Employee.DepartmentId, Salary) IN 
(SELECT 
DepartmentId, MAX(Salary)
FROM Employee 
GROUP BY DepartmentId
)
;
