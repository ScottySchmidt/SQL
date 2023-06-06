/*
1070. Product Sales Analysis III:  https://leetcode.com/problems/product-sales-analysis-iii/description/     Medium Amazon Interview Question

Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key of this table.
product_id is a foreign key to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 
Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key of this table.
Each row of this table indicates the product name of each product.
 
Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.
------------------------------------------
*/

-- Solution Beats 55% in runtime: 
SELECT product_id, year as first_year, quantity, price
FROM (SELECT s.product_id, s.year, s.quantity, s.price, 
dense_rank() OVER(PARTITION BY s.product_id ORDER BY s.year) as rn
FROM sales s
LEFT JOIN product p
ON s.product_id = p.product_id
) t
WHERE rn = 1
