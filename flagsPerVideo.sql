/*
Flags per Video, StrataSratch, Netflix Interview:  
For each video, find how many unique users flagged it.
A unique user can be identified using the combination of their first name and last name. 
Do not consider rows in which there is no flag ID.
*/

-- Get new table with first and last together and flag_id not null:
with cte as(
SELECT video_id, concat(user_firstname, user_lastname) as full_name 
FROM user_flags
WHERE flag_id is not null
)

-- Need the Distinct Full Name count so does not count people twice: 
SELECT video_id, count(distinct full_name) as num_flags
FROM cte
GROUP BY video_id
