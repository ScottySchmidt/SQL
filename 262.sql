#https://leetcode.com/problems/trips-and-users/
#This method uses am IF statement which makes using a JOIN statement challenging;

SELECT Request_at as Day,
       ROUND(COUNT(IF(Status != 'completed', TRUE, NULL)) / COUNT(*), 2) AS 'Cancellation Rate'
FROM Trips
WHERE (Request_at BETWEEN '2013-10-01' AND '2013-10-03')
AND client_id NOT IN (SELECT user_id FROM users WHERE banned= 'No');



------------------------------------------------------------
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





