#https://leetcode.com/problems/trips-and-users/
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

# Currently solves everything except for the output days are reversed


