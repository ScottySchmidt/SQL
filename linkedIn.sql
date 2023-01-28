/*   
Duplicate Job Listings [Linkedin SQL Interview Question]
https://datalemur.com/questions/duplicate-job-listings

This is only an easy problem but worth posting since duplicate values is very important to data.
Source: https://stackoverflow.com/questions/2594829/finding-duplicate-values-in-a-sql-table
/*


with linkedin as (SELECT company_id, title, description, 
count(distinct company_id) as cnt
FROM job_listings
GROUP BY  company_id, title, description
HAVING (count(*)>1)
)
SELECT count(DISTINCT company_id) as duplicate_companies
FROM linkedin
