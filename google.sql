# https://datalemur.com/questions/odd-even-measurements

# Error must appear in the GROUP BY clause or be used in an aggregate function
# Solved https://stackoverflow.com/questions/19601948/must-appear-in-the-group-by-clause-or-be-used-in-an-aggregate-function
# One must use PARTION BY and ORDER BY within the row_number window function itself not on the bottom
# This problem is considered a medium 'Google' question and was more challenging than I thought.

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
