/*
Risky Projects: https://platform.stratascratch.com/coding/10304-risky-projects?code_type=5

Identify projects that are at risk for going overbudget. 
A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.
You'll need to prorate the cost of the employees to the duration of the project.
For example, if the budget for a project that takes half a year to complete is $10K,
then the total half-year salary of all employees assigned to the project should not exceed $10K.
Salary is defined on a yearly basis, so be careful how to calculate salaries for the projects that last less or more than one year.
Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).
HINT: to make it simpler, consider that all years have 365 days. You don't need to think about the leap years.
*/

-- SQL Server Solution:
with budgets as(SELECT p.title, p.budget,
datediff(day, p.start_date, p.end_date) as project_days, l.emp_id, e.salary
FROM linkedin_projects p
INNER JOIN linkedin_emp_projects l
ON TRY_CAST(l.project_id AS INT) = p.id
INNER JOIN linkedin_employees e
ON l.emp_id = e.id
),

salary as(SELECT title, sum(salary) as total_employee_expense
FROM budgets
GROUP BY title
),

variance as(SELECT b.title, b.budget,
CEILING((CAST(s.total_employee_expense AS DECIMAL) * b.project_days) / 365.0) AS prorated_employee_expense
FROM budgets b
INNER JOIN salary s
ON s.title = b.title
)

SELECT DISTINCT title, budget, prorated_employee_expense
FROM variance
WHERE prorated_employee_expense > budget
ORDER BY title

SELECT title, budget, prorated_employee_expense
FROM variance
WHERE prorated_employee_expense > budget
;
