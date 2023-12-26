/*
Naive Forecasting, Hard SQL: https://platform.stratascratch.com/coding/10313-naive-forecasting?code_type=3

Some forecasting methods are extremely simple and surprisingly effective.
Naïve forecast is one of them; we simply set all forecasts to be the value of the last observation.
Our goal is to develop a naïve forecast for a new metric called "distance per dollar" defined as the (distance_to_travel/monetary_cost) in our dataset and measure its accuracy.

To develop this forecast,  sum "distance to travel"  and "monetary cost" values at a monthly level before calculating "distance per dollar".
This value becomes your actual value for the current month. 
The next step is to populate the forecasted value for each month. 
This can be achieved simply by getting the previous month's value in a separate column. 
Now, we have actual and forecasted values. This is your naïve forecast. 
Let’s evaluate our model by calculating an error matrix called root mean squared error (RMSE). 
RMSE is defined as sqrt(mean(square(actual - forecast)).
Report out the RMSE rounded to the 2nd decimal spot.
*/

-- SQL Server and MySQL 
---YouTube solution: https://www.youtube.com/watch?v=8PP3oKxd1x8: 
WITH MonthlyMetrics AS (
    SELECT
        MONTH(request_date) AS month,
        SUM(distance_to_travel) AS total_distance,
        SUM(monetary_cost) AS total_cost
    FROM uber_request_logs
    GROUP BY MONTH(request_date)
),
-- Use Lag to get the previous month: 
NaiveForecast AS (
    SELECT
        month,
        total_distance / total_cost AS actual_value,
        LAG(total_distance / total_cost, 1) OVER (ORDER BY month) AS forecasted_value
    FROM MonthlyMetrics
)
-- Calculate error of actual versus predicted value:
SELECT
    ROUND(SQRT(AVG(POWER(actual_value - forecasted_value, 2))), 2) AS rmse
FROM NaiveForecast;
