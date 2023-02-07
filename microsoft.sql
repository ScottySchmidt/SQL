Teams Power Users [Microsoft SQL Interview Question]
https://datalemur.com/questions/teams-power-users

Write a query to find the top 2 power users who sent the most messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. 
Output the results in descending count of the messages.
-------------


with msft as (SELECT message_id, sender_id, 
EXTRACT(MONTH FROM sent_date) as mth,
EXTRACT(YEAR FROM sent_date) as yr
FROM messages

)

SELECT sender_id, count(sender_id) as message_count
FROM msft
WHERE mth=8 and yr=2022
GROUP BY sender_id
ORDER BY count(sender_id) DESC
LIMIT 2
;
