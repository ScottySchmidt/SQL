/* 
Find the variance and the standard deviation of scores
Find the variance of scores that have grade A using the formula AVG((X_i - mean_x) ^ 2).
Output the result along with the corresponding standard deviation.
https://platform.stratascratch.com/coding/9708-find-the-variance-and-the-standard-deviation-of-scores-that-have-grade-a?code_type=5
*/

--SQL Server and MySQL
WITH cte AS (
    SELECT POWER(score - (SELECT AVG(score) AS avg_score
                         FROM los_angeles_restaurant_health_inspections
                         WHERE grade = 'A'), 2) AS squared_deviation
    FROM los_angeles_restaurant_health_inspections
)

SELECT SQRT(SUM(squared_deviation)) AS variance
FROM cte;
