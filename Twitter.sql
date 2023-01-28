/* 
Tweets' Rolling Averages [Twitter SQL Interview Question]
https://datalemur.com/questions/rolling-average-tweets

Sources Used:
https://stackoverflow.com/questions/57969069/rolling-sum-over-the-last-7-days-how-to-include-missing-dates-postresql
generate_series() is generally needed to fill in missing dates 

Rolling Averages
https://stackoverflow.com/questions/57969069/rolling-sum-over-the-last-7-days-how-to-include-missing-dates-postresql

https://stackoverflow.com/questions/113045/how-to-return-only-the-date-from-a-sql-server-datetime-datatype
select cast(getdate() as date)

The hint suggested using: 
avg(daily_tweets) OVER(
PARTITION BY user_id
ORDER BY tweet_date

This was my first thinking. 
However, this method does not include missing dates.
Therefore, I believe using generate_series is the actual correct method.
)
*/
---------------------
with twitter as(
SELECT user_id, tweet_date,
count(tweet_id) as daily_tweets
FROM tweets
GROUP BY user_id, tweet_date
)

SELECT user_id, tweet_date, 
round(1.0*avg(daily_tweets) OVER(
PARTITION BY user_id
ORDER BY user_id, tweet_date
ROWS BETWEEN 2 preceding AND CURRENT ROW
),2) as rolling_avg_3d
FROM twitter;
