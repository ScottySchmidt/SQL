/* Odd-even-measurements https://datalemur.com/questions/odd-even-measurements
Assume you are given the table containing measurement values obtained from a Google sensor over several days. 
Measurements are taken several times within a given day.
Write a query to obtain the sum of the odd-numbered and even-numbered measurements on a particular day, in two different columns.

Error must appear in the GROUP BY clause or be used in an aggregate function
Solved https://stackoverflow.com/questions/19601948/must-appear-in-the-group-by-clause-or-be-used-in-an-aggregate-function
One must use PARTION BY and ORDER BY within the row_number window function itself not on the bottom
*/

SELECT  
cast(measurement_time as DATE) AS measure_day,
measurement_value,
 ROW_NUMBER() OVER (
   PARTITION BY cast(measurement_time as DATE)
   ORDER BY measurement_time
   ) AS row_num
FROM measurements
) 

SELECT 
measure_day,
SUM(CASE WHEN row_num % 2!=0 
THEN measurement_value ELSE 0 END) as odd_sum,
SUM(CASE WHEN row_num % 2= 0 
THEN measurement_value ELSE 0 END) as even_sum
FROM measures
GROUP BY measure_day
;
