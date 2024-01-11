/*
Department Manager and Employee Salary Comparison: Hard SQL StrataSratch
Oracle is comparing the monthly wages of their employees in each department to those of their managers and co-workers.
You have been tasked with creating a table that compares an employee's salary to that of their manager and to the average salary of their department.
It is expected that the department manager's salary and the average salary of employee's from that department are in their own separate column.

Order the employee's salary from highest to lowest based on their department.
Your output should contain the department, employee id, salary of that employee, salary of that employee's manager and the average salary from employee's within that department rounded to the nearest whole number.
Note: Oracle have requested that you not include the department manager's salary in the average salary for that department in order to avoid skewing the results. Managers of each department do not report to anyone higher up; they are their own manager.
https://platform.stratascratch.com/coding/2146-department-manager-and-employee-salary-comparison?code_type=5
/*

-- SQL Server Solution:
with cte as (SELECT employee_title, salary, department
FROM employee_o)

, avg_dept_salary as (SELECT avg(salary) as avg_salary, department
FROM cte
WHERE employee_title <> 'Manager'
GROUP BY department)

, manager_dept_salary as (
SELECT avg(salary) as manager_salary, department
FROM cte
WHERE employee_title = 'Manager'
GROUP BY department
)

SELECT m.manager_salary, m.department, d.avg_salary
FROM manager_dept_salary m
INNER JOIN avg_dept_salary d
ON d.department = m.department
ORDER BY d.avg_salary;
