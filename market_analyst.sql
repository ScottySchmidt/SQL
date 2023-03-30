/*
1158. Market Analysis I - Medium Level  https://leetcode.com/problems/market-analysis-i/description/

Table: Users
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| join_date      | date    |
| favorite_brand | varchar |
+----------------+---------+
user_id is the primary key of this table.
This table has the info of the users of an online shopping website where users can sell and buy items.
 
Table: Orders
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| item_id       | int     |
| buyer_id      | int     |
| seller_id     | int     |
+---------------+---------+
order_id is the primary key of this table.
item_id is a foreign key to the Items table.
buyer_id and seller_id are foreign keys to the Users table.
 
Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.
Return the result table in any order.
 -------------------------------------
 
To solve this problem one must:
Use a LEFT JOIN on a newly created table so user_id with a 0 count get selected
Make sure to set the user_id = to buyer_id at end to get only buy orders
 */

---The below 'solution' will not show user_id as a 0 count 
SELECT u.user_id as buyer_id, u.join_date, COUNT(order_id) as orders_in_2019
FROM users u
LEFT JOIN Orders o 
ON u.user_id = O.buyer_id
WHERE EXTRACT(YEAR from order_date) = 2019
GROUP BY u.user_id, u.join_date


--Therfore, this is the final solution:
SELECT u.user_id as 'buyer_id',
u.join_date, 
COUNT(o.order_id) as 'orders_in_2019'
FROM Users u 
---below creates a new table 'o' with 2019 orders only:
LEFT JOIN (SELECT * from orders WHERE year(order_date)='2019') o
---or can use BETWEEN '2019-01-01' AND '2019-12'31'
ON u.user_id = o.buyer_id -- must be a buyer_id 
GROUP BY u.user_id 
;
