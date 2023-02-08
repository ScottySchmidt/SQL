/* 
Maximize Prime Item Inventory [Amazon SQL Interview Question]
https://datalemur.com/questions/prime-warehouse-storage

To prioritise storage of prime_eligible items:
The combination of the prime_eligible items has a total square footage of 161.50 sq ft (68.00 sq ft + 85.00 sq ft + 8.50 sq ft).
To prioritise the storage of the prime_eligible items, we find the number of times that we can stock the combination of the prime_eligible items 
which are 3,095 times, mathematically expressed as: 500,000 sq ft / 161.50 sq ft = 3,095 items
Then, we multiply 3,095 times with 3 items (because we're asked to output the number of items to stock), which gives us 9,285 items.

Stocking not_prime items with remaining storage space:
After stocking the prime_eligible items, we have a remaining 157.50 sq ft (500,000 sq ft - (3,095 times x 161.50 sq ft).
Then, we divide by the total square footage for the combination of 2 not_prime items which is mathematically expressed as 
157.50 sq ft / (26.40 sq ft + 22.60 sq ft) = 3 times so the total number of not_prime items that we can stock is 6 items (3 times x (26.40 sq ft + 22.60 sq ft)).

My answer is very messy as this problem is very difficult
*/

with prime as (SELECT item_type, 
count(DISTINCT item_id) as prime_items,
sum(square_footage) as sq_foot
FROM inventory
WHERE item_type='prime_eligible'
GROUP BY item_type
),

not_prime as (SELECT item_type, 
count(DISTINCT item_id) as item_count,
sum(square_footage) as sq_foot
FROM inventory
WHERE item_type='not_prime'
GROUP BY item_type
),

prime_items as (SELECT item_type,
floor(500000/(sq_foot))*prime_items as item_count
FROM prime
),

left_over as ( SELECT 
(SELECT floor(500000- (floor(500000/sq_foot)*sq_foot)) 
FROM prime) as remain
),

not_prime_items as (SELECT
(SELECT item_type FROM not_prime) as item_type,
(SELECT remain FROM left_over) as item_count 
)


SELECT item_type,item_count 
FROM prime_items
UNION
SELECT 
item_type, floor(item_count/(SELECT sq_foot FROM not_prime)*(SELECT item_count FROM not_prime) ) 
FROM not_prime_items
ORDER BY item_count DESC
;
