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

with uber as (SELECT request_id, month(request_date) as month, request_status, monetary_cost, 
  driver_to_client_distance, (monetary_cost/ driver_to_client_distance) distance_per_dollar
FROM uber_request_logs
)

SELECT * FROM uber;
