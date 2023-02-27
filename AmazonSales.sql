/*
https://sqlpad.io/questions/94/top-3-products-vs-bottom-3-products/
Top 3 products vs. bottom 3 products 
Only a Medium Amazon problem but stll worth solving.

Write a query to return the top 3 and bottom 3 products in August 2021 ranked by sales.
sales = sum(unit_price_usd * qty) .

An eCommerce company's online order table.

  col_name    | col_type
--------------+-------------------
order_id      | bigint
product_id    | bigint
customer_id   | bigint
order_dt      | date
qty           | integer
unit_price_usd| float
channel       | varchar(20) -- mobile, desktop
*/

with amazon_sales as(
SELECT 
product_id,
sum(unit_price_usd*qty) as sales
FROM orders
WHERE year(order_dt)=2021 AND month(order_dt)=08
GROUP BY product_id
),

topThree as(
SELECT product_id, 'top' as category, sales
FROM amazon_sales
ORDER BY sales DESC
LIMIT 3
),

botThree as(
SELECT product_id, 'bottom' as category, sales
FROM amazon_sales
ORDER BY sales asc
LIMIT 3
)

SELECT product_id, category
FROM topThree
UNION
SELECT product_id, category
FROM botThree

