/*
Distance Per Dollar, Uber Hard question: https://platform.stratascratch.com/coding/10302-distance-per-dollar?code_type=5

You’re given a dataset of uber rides with the traveling distance (‘distance_to_travel’) and cost (‘monetary_cost’) for each ride. 
First, find the difference between the distance-per-dollar for each date and the average distance-per-dollar for that year-month. 
Distance-per-dollar is defined as the distance traveled divided by the cost of the ride. Use the calculated difference on each date to calculate absolute average difference in distance-per-dollar metric on monthly basis (year-month).
--The output should include the year-month (YYYY-MM) and the absolute average difference in distance-per-dollar (Absolute value to be rounded to the 2nd decimal).
You should also count both success and failed request_status as the distance and cost values are populated for all ride requests. Also, assume that all dates are unique in the dataset. Order your results by earliest request date first.
*/

with uber as(SELECT 
    request_date, 
    CONCAT(YEAR(CONVERT(DATETIME, request_date)), '-', FORMAT(CONVERT(DATETIME, request_date), 'MM')) AS year_month, 
    ROUND(distance_to_travel / monetary_cost, 2) AS distance_per_dollar
FROM 
    uber_request_logs
    )
    
    SELECT request_date, year_month, distance_per_dollar,
    round(ABS(distance_per_dollar - AVG(distance_per_dollar) OVER (PARTITION BY year_month)), 2) AS difference_from_average
    FROM uber
    ORDER BY request_date;