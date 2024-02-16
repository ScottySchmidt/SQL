/*
User with Most Approved Flags - Google Interview - StrataScratch

Which user flagged the most distinct videos that ended up approved by YouTube?
Output, in one column, their full name or names in case of a tie. 
In the user's full name, include a space between the first and the last name.
*/

--SQL Server Solution:
with videos as(SELECT f.video_id, 
concat(f.user_firstname, ' ' ,f.user_lastname) as full_name,
r.reviewed_outcome
FROM user_flags f
INNER JOIN flag_review r
ON f.flag_id = r.flag_id
WHERE r.reviewed_outcome = 'APPROVED'
),

cte as(SELECT full_name, count(distinct video_id) as approve_count,
dense_rank()OVER(ORDER BY count(distinct video_id) DESC) as ranked 
FROM videos
GROUP BY full_name
)
SELECT full_name
FROM cte
WHERE ranked = 1 
