/* 
New Companies Medium Difficulty:  https://www.hackerrank.com/challenges/the-company/problem
This problem becomes easier once one realizes you only have to join the company and employee tables.
The second time I attempted the problem I forgot you only need to join employee and company tables.
*/

--Second solution, the complex way:
SELECT c.company_code, c.founder, 
count(DISTINCT lm.lead_manager_code), 
count(DISTINCT m.senior_manager_code), 
count(DISTINCT m.manager_code),
count(DISTINCT e.employee_code)
FROM Company c
INNER JOIN Lead_Manager lm 
ON c.company_code = lm.company_code
INNER JOIN Senior_Manager sm 
ON sm.lead_manager_code = lm.lead_manager_code
INNER JOIN Manager m
ON sm.senior_manager_code = m.senior_manager_code
INNER JOIN Employee e
ON e.manager_code = m.manager_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code



--First solutions with hints:
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
