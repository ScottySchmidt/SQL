/*
Comments Distribution, Hard SQL Meta:
Write a query to calculate the distribution of comments by the count of users that joined Meta/Facebook between 2018 and 2020, for the month of January 2020.
The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020. 
For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. 
Your left column in the output will be the number of comments while your right column in the output will be the number of users. 
Sort the output from the least number of comments to highest.
To add some complexity, there might be a bug where an user post is dated before the user join date. 
You'll want to remove these posts from the result.
https://platform.stratascratch.com/coding/10297-comments-distribution?code_type=3
*/

--SQL Server and MySQL Solution:

-- create user table with date requirements
with user_cte as(SELECT u.id, u.name, 
u.joined_at, c.created_at 
FROM fb_users u
INNER JOIN fb_comments c
ON u.id = c.user_id
WHERE year(u.joined_at) BETWEEN 2018 and 2020
AND year(c.created_at) = 2020
AND month(c.created_at) = 1
AND c.created_at > u.joined_at
), 
-- count comment by user
comment_cte as(SELECT COUNT(id) as comment_count 
FROM user_cte
GROUP BY id
)
-- create the distribution
SELECT comment_count, 
count(comment_count) as num_occurances
FROM comment_cte
GROUP BY comment_count
ORDER BY comment_count

