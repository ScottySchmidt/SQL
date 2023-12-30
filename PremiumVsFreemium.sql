/*
Premium vs Freemium, Hard SQL: https://platform.stratascratch.com/coding/10300-premium-vs-freemium/submissions?code_type=3
Find the total number of downloads for paying and non-paying users by date. 
Include only records where non-paying customers have more downloads than paying customers. 
The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.
*/

--YouTube Solution: https://www.youtube.com/watch?v=bZQI-gXQBDk
with cte as (SELECT d.date, d.downloads, 
a.paying_customer
FROM ms_user_dimension u
INNER JOIN ms_acc_dimension a
ON u.acc_id = a.acc_id
INNER JOIN ms_download_facts d
ON d.user_id = u.user_id
ORDER BY d.date
),

day_metrics as(SELECT date, 
sum(CASE WHEN paying_customer = 'yes' THEN downloads 
END) as pay,
sum(CASE WHEN paying_customer = 'no' THEN downloads 
END) as free
FROM cte
GROUP BY date
ORDER BY date
)

SELECT date, free, pay
FROM day_metrics
WHERE free > pay
