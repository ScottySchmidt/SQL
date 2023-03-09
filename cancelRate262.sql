/* 
HARD Leetcode SQL https://leetcode.com/problems/trips-and-users/
The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.
Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03".
Round Cancellation Rate to two decimal points.
Return the result table in any order.
*/

SELECT Request_at as Day,
       ROUND(COUNT(IF(Status != 'completed', TRUE, NULL)) / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
WHERE (Request_at BETWEEN '2013-10-01' AND '2013-10-03')
AND client_id NOT IN (SELECT user_id FROM users WHERE banned= 'No');




#Original solution reverses some days but everything's right

SELECT t.request_at as Day, 
round((COUNT(CASE when t.status <> "completed" THEN 1 ELSE NULL END)/
COUNT(*)),2) as Cancellation_Rate
FROM trips t
LEFT JOIN users u
ON t.driver_id=u.users_id
AND u.banned='No'
AND DATEDIFF(request_at, '2013-10-01')>=0 
AND DATEDIFF('2013-10-03 ', request_at)>=0
GROUP BY request_at;





