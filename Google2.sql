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
*/
 
 WITH t1 as( SELECT searches
  FROM search_frequency
  GROUP BY 
    searches, 
    GENERATE_SERIES(1, num_users)
    )
    
    SELECT PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY searches)
    FROM t1
    ;
