/*
1193. Monthly Transactions I https://leetcode.com/problems/monthly-transactions-i/description/

Table: Transactions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 
Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/

-- Final Accepted Solution with descent runtime speed:
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month, country,
count(id) as trans_count, 
count(CASE WHEN state = 'approved' THEN 1
END) as approved_count,
sum(amount) as trans_total_amount,
ifnull(sum(CASE WHEN state = 'approved' THEN amount 
END), 0) as approved_total_amount
FROM transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country
