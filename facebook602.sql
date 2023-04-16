/*
Facebook602 602. Friend Requests II: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/

Table: RequestAccepted
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 
Write an SQL query to find the people who have the most friends and the most friends number.
The test cases are generated so that only one person has the most friends.

 Example 1:
Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
Explanation: 
The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
-------------------------------------
*/

-- Final solution beats 45% runtime:
SELECT distinct id, count(DISTINCT friend) as num
FROM 
(SELECT accepter_id as id, requester_id as friend
FROM RequestAccepted
UNION
SELECT requester_id as id, accepter_id as friend
FROM RequestAccepted
) t
GROUP BY id
ORDER BY num DESC LIMIT 1



-- Using a union avoids null values issue, but this solution passes 9/10. One test case count is slighly off:
SELECT id, sum(numm) as num
FROM (SELECT id, sum(friendCount) as numm
FROM a
GROUP BY id
UNION
SELECT id, sum(friendCount) as numm
FROM r
GROUP BY id
) t
GROUP BY id
ORDER BY num DESC
LIMIT 1


-- First solution passes 9/10, struggles to join two tables on NULL values:
with a as(SELECT a.accepter_id as id, count(a.accepter_id) as num1
FROM RequestAccepted a
GROUP BY a.accepter_id
),

r as( SELECT r.requester_id as id, count(r.requester_id) as num2
FROM RequestAccepted r
GROUP BY r.requester_id
),

combined as (SELECT r.id as id, COALESCE(a.num1+r.num2, 0) as num
FROM a 
JOIN r 
ON a.id = r.id
)

SELECT id, num
FROM combined
ORDER BY num DESC
LIMIT 1

