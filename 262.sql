#https://leetcode.com/problems/trips-and-users/
SELECT t.request_at as Day, 
COUNT(CASE status WHEN 'cancelled_by_driver' THEN 1 ELSE NULL END)/
COUNT(CASE status WHEN 'completed' THEN 1 ELSE NULL END)
as Cancellation
FROM trips t
INNER JOIN users u
ON t.driver_id=u.users_id
WHERE u.banned='No'
GROUP BY t.request_at;

This above solution is correct; however, WHERE u.banned='No' does not filter banned users. 
How to fix this?

----------------------------
# Final Solution:
