/*
Risky Projects: https://platform.stratascratch.com/coding/10304-risky-projects?code_type=5

Identify projects that are at risk for going overbudget. A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.
You'll need to prorate the cost of the employees to the duration of the project. For example, if the budget for a project that takes half a year to complete is $10K, then the total half-year salary of all employees assigned to the project should not exceed $10K.
Salary is defined on a yearly basis, so be careful how to calculate salaries for the projects that last less or more than one year.
Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).
HINT: to make it simpler, consider that all years have 365 days. You don't need to think about the leap years.
*/

-- MY_SQL
WITH p AS (
    SELECT REPLACE(title, 'Project', '') AS project_id, title, budget,
           DATEDIFF(end_date, start_date) / 365 AS year_percent
    FROM linkedin_projects
),

cost as(SELECT p.project_id, sum(e.salary) as salary_cost
FROM linkedin_employees e
INNER JOIN linkedin_emp_projects p
ON e.id = p.emp_id
GROUP BY p.project_id
),

variance as(SELECT p.project_id, p.title, p.budget, p.year_percent, cost.salary_cost, 
CEIL(p.year_percent*cost.salary_cost) as prorated_employee_expense
FROM p
INNER JOIN linkedin_emp_projects ep ON p.project_id = ep.project_id
INNER JOIN cost ON cost.project_id = p.project_id
)

SELECT title, budget, prorated_employee_expense
FROM variance
WHERE prorated_employee_expense > budget
;

--SQL Server (in process)
WITH p AS (
    SELECT REPLACE(title, 'Project', '') AS project_id, title, budget,
           DATEDIFF(DAY, start_date, end_date) / 365.25 AS year_percent
    FROM linkedin_projects
),

cost as(SELECT p.project_id, sum(e.salary) as salary_cost
FROM linkedin_employees e
INNER JOIN linkedin_emp_projects p
ON e.id = p.emp_id
GROUP BY p.project_id
),

variance as(SELECT p.project_id, p.title, p.budget, p.year_percent, cost.salary_cost, 
CEILING(p.year_percent*cost.salary_cost) as prorated_employee_expense
FROM p
INNER JOIN linkedin_emp_projects ep ON p.project_id = ep.project_id
INNER JOIN cost ON cost.project_id = p.project_id
)

SELECT title, budget, prorated_employee_expense
FROM variance
WHERE prorated_employee_expense > budget
;
