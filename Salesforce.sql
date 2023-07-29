'''
The company for which you work is reviewing its 2021 monthly sales.
For each month of 2021, calculate what percentage of restaurants have reached at least 100$ or more in monthly sales.
Note: Please remember that if an order has a blank value for actual_delivery_time, it has been canceled and therefore does not count towards monthly sales.
'''
--- SQL_Server Solution:
with orders as (
select restaurant_id, delivery_id,
month(order_placed_time) as mth
FROM delivery_orders
WHERE year(order_placed_time) = 2021
AND WHERE actual_delivery_time IS NOT NULL
)

SELECT o.restaurant_id, o.mth, 
sum(v.sales_amount) as total_sales
FROM orders o
INNER JOIN order_value v
ON v.delivery_id=o.delivery_id
GROUP BY o.restaurant_id, o.mth
HAVING sum(v.sales_amount) > 100
