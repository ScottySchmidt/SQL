/* Worst Businesses, Hard SQL: https://platform.stratascratch.com/coding/9739-worst-businesses?code_type=5
For every year, find the worst business in the dataset. The worst business has the most violations during the year. You should output the year, business name, and number of violations.
*/ 

--SQL Server and MySQL:
with business as (SELECT business_name, year(inspection_date) as inspect_year, COUNT(business_name) as violations_count
FROM sf_restaurant_health_violations
GROUP BY business_name, year(inspection_date)
), 

business2 as (SELECT business_name, inspect_year, violations_count,
ROW_NUMBER() OVER (PARTITION BY inspect_year ORDER BY violations_count DESC) as rn
FROM business)

SELECT business_name, inspect_year, violations_count
FROM business2
WHERE rn = 1
