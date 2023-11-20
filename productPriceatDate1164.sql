/* 
1164. Product Price at a Given Date: https://leetcode.com/problems/product-price-at-a-given-date/description/

Table: Products
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 
Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
Return the result table in any order.

The query result format is in the following example.

Example 1:
Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

# 1. This solution requires getting the closest date to '2019-08-16' by using a window function.
# 2. Do a union statement for all IDs that had am order date above '2019-08-16'

# beats 46% runtime:
with t as (SELECT product_id, new_price, change_date,
row_number() OVER (PARTITION BY product_id ORDER BY change_date DESC) as rn
FROM products
WHERE change_date <= '2019-08-16')

SELECT product_id, new_price as price
FROM  t
WHERE rn=1
UNION
SELECT product_id, 10
FROM products
WHERE product_id NOT IN (
  SELECT product_id
  FROM t)
