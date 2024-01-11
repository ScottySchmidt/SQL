/*
Distance Per Dollar, Hard SQL Uber: https://platform.stratascratch.com/coding/10302-distance-per-dollar?code_type=5

You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. 
First, find the difference between the distance-per-dollar for each date and the average distance-per-dollar for that year-month. 
Distance-per-dollar is defined as the distance traveled divided by the cost of the ride. 
Use the calculated difference on each date to calculate absolute average difference in distance-per-dollar metric on monthly basis (year-month).
The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).
You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. 
Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.
*/

-- Solution without a window function, easy to understand: 
with daily as (SELECT FORMAT(CONVERT(DATETIME, request_date), 'yyyy-MM') AS year_month,
round(distance_to_travel/monetary_cost, 2) as dist_per_dollar
FROM uber_request_logs
),

avg_month as(SELECT year_month, avg(dist_per_dollar) as avg_month
FROM daily
GROUP BY year_month
)

SELECT d.year_month, avg(abs(d.dist_per_dollar-m.avg_month)) as difference
FROM daily d
INNER JOIN avg_month m 
ON d.year_month = m.year_month
GROUP BY d.year_month

    
-- SQL Server Solution: Create request_date to a year-month (YYYY-MM):
with uber as(SELECT request_date, 
    FORMAT(CONVERT(DATETIME, request_date), 'yyyy-MM') AS year_month,
    ROUND(distance_to_travel / monetary_cost, 2) AS distance_per_dollar
    FROM  uber_request_logs
    ),
     --- absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal
    uber2 as (SELECT year_month,
    round(ABS(distance_per_dollar - AVG(distance_per_dollar) OVER (PARTITION BY year_month)), 2) AS difference_from_average
    FROM uber )
    --get the average and correct columns with final table:
    SELECT year_month, avg(difference_from_average) 
    FROM uber2
    GROUP BY year_month


-- MySQL Solution:    
with uber as(SELECT request_date, 
    FORMAT(CONVERT(DATETIME, request_date), 'yyyy-MM') AS year_month,
    ROUND(distance_to_travel / monetary_cost, 2) AS distance_per_dollar
    FROM  uber_request_logs
    ),
    
    --- absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal
    uber2 as (SELECT year_month,
    round(ABS(distance_per_dollar - AVG(distance_per_dollar) OVER (PARTITION BY year_month)), 2) AS difference_from_average
    FROM uber )
    
