/*
Google Fit User Tracking, Hard SQL, StrataSratch Affiliate:
Find the average session distance travelled by Google Fit users based on GPS location data.
Calculate the distance for two scenarios:
Taking into consideration the curvature of the earth
Taking into consideration the curvature of the earth as a flat surface

Assume one session distance is the distance between the biggest and the smallest step. 
If the session has only one step id, discard it from the calculation. 
Assume that session can't span over multiple days.
Output the average session distances calculated in the two scenarios and the difference between them.

Formula to calculate the distance with the curvature of the earth:
*/

-- YouTube Solution: https://www.youtube.com/watch?v=wbofjfiu6aQ
with m1 as(SELECT user_id, session_id, day, count(*) as step_count
FROM google_fit_location
GROUP BY user_id, session_id, day
),

m2 as(SELECT user_id, session_id
FROM m1
WHERE step_count > 1
),

cte as ( SELECT user_id, session_id, day, latitude, longitude,
row_number() OVER(PARTITION BY user_id, session_id, day ORDER BY step_id asc) as first_step,
row_number() OVER(PARTITION BY user_id, session_id, day ORDER BY step_id desc) as last_step
FROM google_fit_location
),

cte2 as (SELECT a.latitude as latitude1, 
a.longitude as longitude1, 
b.latitude as latitude2, 
b.longitude as longitude2
FROM cte a
INNER JOIN cte b 
ON a.user_id = b.user_id AND a.day = b.day
WHERE a.first_step = 1
AND b.last_step = 1
)

-- This is prewrote code template for calculatng curved and flat distance
SELECT 
    AVG(ACOS(SIN(RADIANS(latitude1)) * SIN(RADIANS(latitude2)) + COS(RADIANS(latitude1)) * COS(RADIANS(latitude2)) * COS(RADIANS(longitude2)  - RADIANS(longitude1))) * 6371) as curved,
    AVG(SQRT(POWER(latitude2 - latitude1,2) + POWER(longitude2 - longitude1,2)) * 111) as flat, 
    AVG(ACOS(SIN(RADIANS(latitude1)) * SIN(RADIANS(latitude2)) + COS(RADIANS(latitude1)) * COS(RADIANS(latitude2)) * COS(RADIANS(longitude2)  - RADIANS(longitude1))) * 6371) -
    AVG(SQRT(POWER(latitude2 - latitude1,2) + POWER(longitude2 - longitude1,2)) * 111) as diff
FROM cte2
