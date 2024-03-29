/* 
Host Response Rates With Cleaning Fees https://platform.stratascratch.com/coding/9634-host-response-rates-with-cleaning-fees?code_type=5

Find the average host response rate with a cleaning fee for each zipcode. 
Present the results as a percentage along with the zip code value.
Convert the column 'host_response_rate' from TEXT to NUMERIC using type casts and string processing (take missing values as NULL).
Order the result in ascending order based on the average host response rater after cleaning.
*/

--- SQL Server
WITH airbnb AS (
  SELECT 
    zipcode,
    host_response_rate,
    TRY_CAST(REPLACE(host_response_rate, '%', '') AS FLOAT) AS numeric_response_rate
  FROM airbnb_search_details
  WHERE cleaning_fee = 'TRUE' 
    AND TRY_CAST(REPLACE(host_response_rate, '%', '') AS FLOAT) IS NOT NULL
),

air2 as(
SELECT zipcode, 
  avg(numeric_response_rate) 
  as avg_response 
FROM airbnb
GROUP BY zipcode
)

SELECT zipcode, avg_response
FROM air2
ORDER BY avg_response ASC

  

--MY_SQL, one liner:
SELECT zipcode,  
CAST(AVG(CAST(REPLACE(host_response_rate, '%', '') AS DECIMAL(10, 2))) AS DECIMAL(10, 2)) AS avg_rate
FROM airbnb_search_details
WHERE cleaning_fee = 1
AND host_response_rate IS NOT null
GROUP BY zipcode
ORDER BY avg_rate ASC
;
;
