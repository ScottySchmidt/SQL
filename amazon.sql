# https://datalemur.com/questions/sql-avg-review-ratings
# Average Review Ratings [Amazon SQL Interview Question]
# This question is cosnidered easy and the only challenging part was using EXTRACT 


SELECT EXTRACT(MONTH FROM submit_date) as mth,
product_id as product,
round(avg(stars), 2) as avg_stars
FROM reviews
GROUP BY mth, product
ORDER BY mth, product
;
