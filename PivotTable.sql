/*  
City of San Fran: https://platform.stratascratch.com/coding/10145-make-a-pivot-table-to-find-the-highest-payment-in-each-year-for-each-employee?code_type=5
Make a pivot table to find the highest payment in each year for each employee
Make a pivot table to find the highest payment in each year for each employee.
Find payment details for 2011, 2012, 2013, and 2014.
Output payment details along with the corresponding employee name.
Order records by the employee name in ascending order
*/

--- Sql Server Solution using Microsoft Docs:
SELECT employeename,
    COALESCE([2011], 0) AS [2011],
    COALESCE([2012], 0) AS [2012],
    COALESCE([2013], 0) AS [2013],
    COALESCE([2014], 0) AS [2014]
FROM (
    SELECT employeename, year, totalpay
    FROM sf_public_salaries
    WHERE year in (2011, 2012, 2013, 2014)
) AS pivot_table 
PIVOT (
    MAX(totalpay) FOR Year IN ([2011], [2012], [2013], [2014])
) AS PivotTable
ORDER BY employeename;
