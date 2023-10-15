/*
Comments Distribution, Facebook: https://platform.stratascratch.com/coding/10297-comments-distribution?code_type=5

Write a query to calculate the distribution of comments by the count of users that joined Meta/Facebook between 2018 and 2020, for the month of January 2020.
The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020. For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. Your left column in the output will be the number of comments while your right column in the output will be the number of users. 
Sort the output from the least number of comments to highest.
To add some complexity, there might be a bug where an user post is dated before the user join date. You'll want to remove these posts from the result.
*/

with facebook as (SELECT c.user_id, month(c.created_at) as month_num, year(c.created_at) as year_num
FROM fb_users u
INNER JOIN fb_comments c
ON u.id = c.user_id
WHERE u.joined_at > c.created_at
)

SELECT user_id, count(user_id) as comment_count
FROM facebook
WHERE month_num = 1 
AND year_num = 2020
GROUP BY user_id
ORDER BY count(user_id) DESC;
