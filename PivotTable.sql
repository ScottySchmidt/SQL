/*  
City of San Fran: https://platform.stratascratch.com/coding/10145-make-a-pivot-table-to-find-the-highest-payment-in-each-year-for-each-employee?code_type=5
Make a pivot table to find the highest payment in each year for each employee
Make a pivot table to find the highest payment in each year for each employee.
Find payment details for 2011, 2012, 2013, and 2014.
Output payment details along with the corresponding employee name.
Order records by the employee name in ascending order
*/

SELECT id, employeename, year,
max(totalpaybenefits) as high_pay
FROM sf_public_salaries
WHERE YEAR in (2011, 2012, 2013, 2014)
GROUP BY id, employeename, year
ORDER BY employeename asc
