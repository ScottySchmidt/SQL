# https://www.hackerrank.com/challenges/the-company/problem
# This problem becomes easier once one realizes you only have to join the company and employee tables.
# The last trick is to GROUP BY both company_code AND founder (grouping by just company_code gets innacurate results).

SELECT 
c.company_code,
c.founder,
count(distinct(e.lead_manager_code)),
count(distinct(e.senior_manager_code)),
count(distinct(e.manager_code)),
count(distinct(e.employee_code))
FROM Employee e
INNER JOIN company c
ON c.company_code=e.company_code
GROUP BY c.company_code, c.founder;
