/* 
https://www.codewars.com/kata/5811527d9d278b242f000006/train/sql

Create a VIEW. This VIEW is used by a sales store to give out vouches to members who have spent over $1000 in departments
that have brought in more than $10000 total ordered by the members id.
The VIEW must be called members_approved_for_voucher then you must create a SELECT query using the view.
----------------------------------------
*/

CREATE VIEW members_approved_for_voucher as 
SELECT
m.id as id, 
m.name as name,
m.email as email,
sum(p.price) as total_spending
FROM members m
JOIN sales s
ON m.id=s.member_id
JOIN products p
ON p.id=s.product_id

WHERE m.id IN (
SELECT s1.department_id
FROM sales s1
JOIN products p1
ON p1.id=s1.product_id
JOIN members m1 
ON m1.id=s1.member_id
GROUP BY s1.department_id
HAVING sum(p1.price)>1000
  )
GROUP BY m.id, m.name, m.email
ORDER BY m.id
