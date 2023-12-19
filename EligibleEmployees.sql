/*
IBM wants to reward employees who meet certain criteria. However, to ensure fairness, the following conditions must be met:

•	The employee must have been with the company for at least 3 years
•	The employee's department must have at least 5 employees
•	The salary must be within the top 10% of salaries within the department

The output should include the Employee ID, Salary, and Department of the employees meeting the criteria.
https://platform.stratascratch.com/coding/10359-eligible-employees?code_type=3
*/

--SQL Server Solution:
with cte as (SELECT employee_id, salary, department, 
 PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) as top_percent
FROM employee_salaries
WHERE tenure >= 3)

SELECT employee_id, salary, department
FROM cte
WHERE top_percent >= .90
AND DEPARTMENT IN (SELECT department
FROM employee_salaries
GROUP BY department
HAVING COUNT(DISTINCT employee_id) > 5)



--MySQL and Oracle Solution:
with cte as (SELECT employee_id, salary, department, 
 PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary) as top_percent
FROM employee_salaries
WHERE tenure >= 3)

SELECT employee_id, salary, department
FROM cte
WHERE top_percent >= .90
AND DEPARTMENT IN (SELECT department
FROM employee_salaries
GROUP BY department
HAVING COUNT(DISTINCT employee_id) > 5)




--Python Solution:
import pandas as pd
import numpy as np

df = employee_salaries

# Calculate top 10 salary percent by department
df['salary_10_percent'] = df.groupby('department')['salary'].transform(lambda x: np.percentile(x, 90))

# Calculate the count of distinct employee_id within each department and create a new column
df['dept_count'] = df.groupby('department')['employee_id'].transform('nunique')
filter_df = df[(df['salary'] > df['salary_10_percent']) & (df['tenure'] >= 3) & (df['dept_count']> 5)]

filter_df[['employee_id', 'salary', 'department']]
