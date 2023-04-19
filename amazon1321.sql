/*
Amazon 1321. Restaurant Growth https://leetcode.com/problems/restaurant-growth/

Table: Customer
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
-----------------------------------
*/

-- Final solution beats 82%:
with day_totals as (
SELECT visited_on, sum(amount) as amount
FROM customer
GROUP BY visited_on
)

SELECT visited_on, 
round(sum(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) as amount,
round(avg(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) as average_amount
FROM day_totals
GROUP BY visited_on 
ORDER BY visited_on
LIMIT 99999999999 OFFSET 6



-- The above solution fixed the bottom solution because you first have to do a groupby on the days:
-- Initial start that has everything correct but last row:
SELECT visited_on, 
round(sum(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING and current row), 2) as amount,
round(avg(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING and current row), 2) as average_amount
FROM customer
GROUP BY visited_on 
ORDER BY visited_on
LIMIT 99999999999 OFFSET 6
