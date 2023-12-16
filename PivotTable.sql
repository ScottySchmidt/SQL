/*  
City of San Fran: https://platform.stratascratch.com/coding/10145-make-a-pivot-table-to-find-the-highest-payment-in-each-year-for-each-employee?code_type=5
Make a pivot table to find the highest payment in each year for each employee
Make a pivot table to find the highest payment in each year for each employee.
Find payment details for 2011, 2012, 2013, and 2014.
Output payment details along with the corresponding employee name.
Order records by the employee name in ascending order
*/

--- MySQL, Oracle and SqlServer Solution. 
--- Pivot tables are important, this creates a pivot table without using PIVOT
--- This problem is labeled 'hard' but more so medium, but pivot tables are very practical. 
SELECT employeename, year,
max(totalpaybenefits) as high_pay
FROM sf_public_salaries
WHERE year in (2011, 2012, 2013, 2014)
GROUP BY id, employeename, year  -- GROUP BY is in case two people have exact same name.
ORDER BY employeename asc


--When possible, this method above is easier than using the pivot from Microsoft docs: 
  SELECT <non-pivoted column>,  
    [first pivoted column] AS <column name>,  
    [second pivoted column] AS <column name>,  
    ...  
    [last pivoted column] AS <column name>  
FROM  
    (<SELECT query that produces the data>)   
    AS <alias for the source query>  
PIVOT  
(  
    <aggregation function>(<column being aggregated>)  
FOR   
[<column that contains the values that will become column headers>]   
    IN ( [first pivoted column], [second pivoted column],  
    ... [last pivoted column])  
) AS <alias for the pivot table>  
<optional ORDER BY clause>;  
