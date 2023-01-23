# https://datalemur.com/questions/frequently-purchased-pairs
# Frequently Purchased Pairs [Walmart SQL Interview Question]
Assume you are given the following tables on Walmart transactions and products. 
Find the number of unique product combinations that are bought together (purchased in the same transaction).
For example, if I find two transactions where apples and bananas are bought, and another transaction where bananas and soy milk are bought,
my output would be 2 to represent the 2 unique combinations. 
-------------------------------------------------------------

with purchase as (
SELECT t.transaction_id, t.product_id
FROM transactions t  
JOIN products p  
USING (product_id)
),

combo as (
SELECT p1.transaction_id, p1.product_id 
FROM purchase p1  
JOIN purchase p2
ON p1.transaction_id=p2.transaction_id
AND p1.product_id<p2.product_id
)

SELECT count(combo.transaction_id)
FROM combo
;
