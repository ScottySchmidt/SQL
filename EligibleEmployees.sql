/*
IBM wants to reward employees who meet certain criteria. However, to ensure fairness, the following conditions must be met:

•	The employee must have been with the company for at least 3 years
•	The employee's department must have at least 5 employees
•	The salary must be within the top 10% of salaries within the department

The output should include the Employee ID, Salary, and Department of the employees meeting the criteria.
https://platform.stratascratch.com/coding/10359-eligible-employees?code_type=3
*/

--SQL Server Solution:
with cte as (SELECT employee_id, salary, department, tenure,
PERCENTILE_CONT(0.10) WITHIN GROUP (ORDER BY salary) OVER (PARTITION BY department) as top_ten_percent
FROM employee_salaries)

SELECT employee_id, salary, department
FROM cte
WHERE salary > top_ten_percent 
AND tenure > 3
AND DEPARTMENT IN (SELECT department
FROM employee_salaries
GROUP BY department
HAVING COUNT(DISTINCT employee_id) > 5)
;


--MySQL Solution:
with cte as (SELECT employee_id, salary, department, 
 PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) as top_ten_percent
FROM employee_salaries
WHERE tenure > 3)

SELECT employee_id, salary, department
FROM cte
WHERE salary > top_ten_percent 
AND DEPARTMENT IN (SELECT department
FROM employee_salaries
GROUP BY department
HAVING COUNT(DISTINCT employee_id) > 5)
;
