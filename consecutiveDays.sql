/*
Consecutive Days: Hard SQL StrataSratch, Netflix and SalesForce
Find all the users who were active for 3 consecutive days or more.
https://platform.stratascratch.com/coding/2054-consecutive-days?code_type=3

StrataScratch Affiliate, Master Data Analytics, SQL, and Python: https://www.stratascratch.com/?via=scott
*/


-- Final MySQL Solution using two window functions method:
WITH cte AS (
    SELECT user_id, 
           date,
           LAG(date, 1) OVER (PARTITION BY user_id ORDER BY date) as lag1,  -- Day After
           LAG(date, 2) OVER (PARTITION BY user_id ORDER BY date) as lag2   -- Two day After
    FROM sf_events
)
SELECT DISTINCT user_id  
FROM cte 
WHERE DATEDIFF(date, lag1) = 1 
  AND DATEDIFF(date, lag2) = 2;

/*
An advanced and more difficult way to solve this problem is using self joins. 
However, this method above as we see is solved easly within 10 lines of code.
*/
