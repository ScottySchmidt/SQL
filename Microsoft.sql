/* 
Microsoft SQL Interview Question:  https://datalemur.com/questions/supercloud-customer

A Microsoft Azure Supercloud customer is a company which buys at least 1 product from each product category.
Write a query to report the company ID which is a Supercloud customer.
As of 5 Dec 2022, data in the customer_contracts and products tables were updated.

Customer 1 bought from Analytics, Containers, and Compute categories of Azure, and thus is a Supercloud customer. 
Customer 2 isn't a Supercloud customer, since they don't buy any container services from Azure.
*/ 

---Use t1 as a temp table to get the unique count of products using customer_id
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
