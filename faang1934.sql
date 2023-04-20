/*  
1934. Confirmation Rate https://leetcode.com/problems/confirmation-rate/description/
Table: Signups
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the primary key for this table.
Each row contains information about the signup time for the user with ID user_id.
 
Table: Confirmations
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key for this table.
user_id is a foreign key with a reference to the Signups table.
action is an ENUM of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 
The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages.
The confirmation rate of a user that did not request any confirmation messages is 0.
Round the confirmation rate to two decimal places.
Write an SQL query to find the confirmation rate of each user.
*/

-- Beats 83% runtime:
SELECT user_id, round(confirm/attempts, 2) as confirmation_rate FROM
(SELECT user_id, count(action) as attempts, 
count(CASE 
WHEN action = 'confirmed' THEN 1 
END) as confirm
FROM confirmations
GROUP BY user_id
) t
UNION 
SELECT 
user_id, 0
FROM signups
WHERE user_id NOT IN (SELECT distinct user_id FROM confirmations)

-- The trick to solving this problem is to use a UNION statement to find user_id not in the confirmation table.
-- Those will need to have a 0 as they did not confirm and not registered in the main table.
