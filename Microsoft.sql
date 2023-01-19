# https://datalemur.com/questions/supercloud-customer
# Microsoft SQL Interview Question

# Use t1 as a temp table to get the unique count of products using customer_id
with t1 as(
SELECT c.customer_id,
count(DISTINCT p.product_category) as unique_count
FROM customer_contracts c
LEFT JOIN products p
USING (product_id)
GROUP BY c.customer_id
ORDER BY unique_count DESC
)

SELECT customer_id
FROM t1
WHERE unique_count=3
;
