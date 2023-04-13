/*
550. Game Play Analysis IV  https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/

Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 
Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.
In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.
--------------------------------------------------------
*/

--- Beats 16% runtime, need a better solution:
with msft as(SELECT player_id, event_date, 
row_number() OVER(PARTITION BY player_id ORDER BY event_date) as rn
FROM activity
),

msft_login as (SELECT player_id, event_date, 
lag(event_date, 1) OVER(PARTITION BY player_id) as day_prior
FROM msft
WHERE rn <= 2
)

SELECT round( (SELECT count(DISTINCT player_id) FROM msft_login WHERE datediff(event_date, day_prior) = 1)/(SELECT count(DISTINCT player_id) FROM msft),2) as fraction

SELECT round(count(DISTINCT player_id) / (SELECT count(DISTINCT player_id) FROM msft), 2) as fraction
FROM login_next_day 
