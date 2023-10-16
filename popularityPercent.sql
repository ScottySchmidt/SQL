/* 
Popularity Percentage, Meta: https://platform.stratascratch.com/coding/10284-popularity-percentage?code_type=5
Find the popularity percentage for each user on Meta/Facebook. 
The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, 
then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. 
Order records in ascending order by user id.
The 'user1' and 'user2' column are pairs of friends.
*/

SELECT user1, 
round(100.00*count(user2)/(SELECT count(user1) FROM facebook_friends),2) as popular_percentage
FROM facebook_friends
GROUP BY user1
ORDER BY user1
