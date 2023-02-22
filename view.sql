/* 
https://www.codewars.com/kata/5811527d9d278b242f000006/train/sql

Create a VIEW. This VIEW is used by a sales store to give out vouches to members who have spent over $1000 in departments
that have brought in more than $10000 total ordered by the members id.
The VIEW must be called members_approved_for_voucher then you must create a SELECT query using the view.

----------------------------------------
*/


CREATE VIEW members_approved_for_voucher as 
SELECT s.department_id, sum(p.price) as total
FROM sales s
JOIN products p
ON p.id=s.product_id
JOIN members m 
ON m.id=s.member_id
GROUP BY s.department_id
HAVING sum(p.price)>10000
