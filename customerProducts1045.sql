/*
1045. Customers Who Bought All Products: https://leetcode.com/problems/customers-who-bought-all-products/description/

Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
There is no primary key for this table. It may contain duplicates. customer_id is not NULL.
product_key is a foreign key to Product table.
 
Table: Product
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key column for this table.
 
Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
------------------------------------------------------
*/

--Solution beats 49% of runtime:
with cust_count as (SELECT c.customer_id, count(DISTINCT c.product_key) as prod_count
FROM customer c
GROUP BY c.customer_id
)
SELECT customer_id
FROM cust_count
WHERE prod_count = (SELECT count(DISTINCT product_key) FROM product)
