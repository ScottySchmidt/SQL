/*
Naive Forecasting, Hard SQL: https://platform.stratascratch.com/coding/10313-naive-forecasting?code_type=3

Some forecasting methods are extremely simple and surprisingly effective.
Naïve forecast is one of them; we simply set all forecasts to be the value of the last observation.
Our goal is to develop a naïve forecast for a new metric called "distance per dollar" defined as the (distance_to_travel/monetary_cost) in our dataset and measure its accuracy.

To develop this forecast,  sum "distance to travel"  and "monetary cost" values at a monthly level before calculating "distance per dollar".
This value becomes your actual value for the current month. 
The next step is to populate the forecasted value for each month. This can be achieved simply by getting the previous month's value in a separate column. Now, we have actual and forecasted values. This is your naïve forecast. Let’s evaluate our model by calculating an error matrix called root mean squared error (RMSE). 
RMSE is defined as sqrt(mean(square(actual - forecast)). Report out the RMSE rounded to the 2nd decimal spot.
*/

-- SQL Server and MySQL: 
with cte as ( SELECT month(request_date) as month,
round(avg(distance_to_travel/monetary_cost),2) as distance_per_dollar
FROM uber_request_logs
GROUP BY month(request_date)
),
  
-- Naive Forecasting uses the 'last month' as a future predictor. Therefore, LAG function needed:
cte2 as (SELECT month, distance_per_dollar,
COALESCE(lag(distance_per_dollar) OVER(ORDER BY month ASC),0) as prior_month_average  --COALESCE will fill in 0 if empty
FROM cte)

SELECT month, SQRT(POWER(distance_per_dollar-prior_month_average, 2)) as RMSE --technically avg_RMSE
FROM cte2

/*
Above code generates the report by month like below:
month	RMSE
1	7.44
2	1.36
3	0.53
4	3.49
5	4.46
6	0.2
7	4.53
8	10.8
9	11.7
10	0.86
*/
