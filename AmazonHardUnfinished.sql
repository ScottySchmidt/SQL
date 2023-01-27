/* 
Maximize Prime Item Inventory [Amazon SQL Interview Question]
https://datalemur.com/questions/prime-warehouse-storage

This question must be solved mathematically before coding:
How many sums of primze items fit into 500,000 sq feet in Amazon storage?
In this case, prime is 555.20 sq feet with 6 items.
500000/$555.20 = 900. Use floor to round down.
This means 900*$555.20 = 499,680 feet are prime items.

500000-499680= 320 sq feet left over for not_prime items
320/128.50 = 2 rounded down again. 
*/

--- Currently my first attempt is not the correct method:
WITH amazon as (
SELECT item_type,
sum(square_footage) as total_sqft,
count(item_id) as num_items
FROM inventory
GROUP BY item_type 
),

packages as( 
SELECT item_type,
total_sqft,
Floor(500000/total_sqft) as item_count, 
num_items 
FROM amazon
ORDER BY item_count 
),

prime as(
SELECT total_sqft*item_count as prime_space
FROM packages
WHERE item_type='prime_eligible'
)

SELECT FLOOR((500000-prime_space)/(SELECT total_sqft FROM amazon WHERE item_type='not_prime'))
FROM prime
;
