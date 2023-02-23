/* 
https://www.codewars.com/kata/5811527d9d278b242f000006/train/sql

Create a VIEW. This VIEW is used by a sales store to give out vouches to members who have spent over $1000 in departments
that have brought in more than $10000 total ordered by the members id.
The VIEW must be called members_approved_for_voucher then you must create a SELECT query using the view.

This is a great problem that has to join three datasets together and have two seperate subtotals:
1. JOIN the three datasets together.
2. Use a subquery to find which departments have total spending above 10,000
3. Use a groupby on the member id/name to find which member has spending above 1000.

I plan to reattempt this problem later and make a YouTube video as I had to reverse engineer this problem as it was my first time using view instead of CTE.
----------------------------------------
*/

CREATE VIEW members_approved_for_voucher as 
SELECT
m.id, m.name, m.email, sum(p.price) as total_spending
FROM members m
INNER JOIN sales s ON m.id=s.member_id
INNER JOIN products p ON p.id=s.product_id

WHERE s.department_id IN (
SELECT s2.department_id
FROM sales s2
INNER JOIN products p2 ON p2.id=s2.product_id
GROUP BY s2.department_id
HAVING sum(p2.price)>10000
  )
GROUP BY m.id, m.name, m.email
HAVING sum(p.price)>1000
ORDER BY m.id;

SELECT id, name, email, total_spending
FROM members_approved_for_voucher;

