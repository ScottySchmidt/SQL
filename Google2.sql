/*
Median Google Search Frequency [Google SQL Interview] 
https://datalemur.com/questions/median-search-freq

Google's marketing team is making a Superbowl commercial and needs a simple statistic to put on their TV ad: 
the median number of searches a person made last year.
However, at Google scale, querying the 2 trillion searches is too costly. 
Luckily, you have access to the summary table which tells you the number of searches made last year and how many Google users fall into that bucket.
Write a query to report the median of searches made by a user. Round the median to one decimal point.

This problem is considered HARD level even thought it looks easy.
It is indeed challenging as one must use GENERATE SERIES.
Table1 will create GROUP by serach then product that same number
the amount of num_users.

Below is the most concise solution that makes sense without having to write 50 lines of code.
Searches will be produced num_users times. 
Then the select statement finds the mediam.
*/
 
 
with google as
(SELECT searches, GENERATE_SERIES(1, num_users)
FROM search_frequency
order by searches)

select PERCENTILE_CONT(0.5) WITHIN group (order by searches) from google;
 
 
 
