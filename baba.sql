/*
Compressed Mode [Alibaba SQL Interview Question]
https://datalemur.com/questions/alibaba-compressed-mode

Source:
https://stackoverflow.com/questions/12235595/find-most-frequent-value-in-sql-column

This problem gets the correct answer.
However, using limit1 is not prefered as mode could require an average of two top.
*/

with baba as (SELECT order_occurrences,
count(order_occurrences) as value_counts
FROM items_per_order
GROUP BY order_occurrences
ORDER BY value_counts DESC, order_occurrences DESC
LIMIT 1
),

orders as (SELECT order_occurrences
FROM baba
WHERE value_counts=(SELECT max(value_counts) FROM baba)
),

occur as (
SELECT item_count, order_occurrences
FROM items_per_order
WHERE order_occurrences=(SELECT order_occurrences FROM baba)
)

SELECT item_count as mode 
FROM occur
;

---SELECT item_count, order_occurrences
---FROM items_per_order
---WHERE order_occurrences IN 
---(SELECT order_occurrences FROM orders)
;