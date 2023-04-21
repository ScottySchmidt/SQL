/*
1907. Count Salary Categories, Medium level: https://leetcode.com/problems/count-salary-categories/

Table: Accounts
+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key for this table.
Each row contains information about the monthly income for one bank account.
 
Write an SQL query to report the number of bank accounts of each salary category. The salary categories are:
"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, then report 0.
*/

-- To avoid not having a 0 in final answer, use 3 UNION statements is easy to understand but likely slower runetime:
SELECT "High Salary" as category,
sum(CASE WHEN income > 50000 THEN 1 else 0
END) as accounts_count
FROM accounts
UNION
SELECT "Low Salary" as category,
sum(CASE WHEN income < 20000 then 1 else 0
END) as accounts_count
FROM accounts
UNION
SELECT "Average Salary" as category,
sum(CASE WHEN income >= 20000 and income <= 50000 then 1 else 0 END) as accounts_count
FROM accounts


-- Passes 10/11, does not find a salary if null need to fix this bug:
with cte as (SELECT account_id, 
CASE
when income < 20000 then 'Low Salary' 
when income <= 50000 and income >=20000 then 'Average Salary'
when income > 50000 then 'High Salary'
END as category
FROM Accounts
) 

SELECT category, count(account_id) as accounts_count
FROM cte
GROUP BY category
