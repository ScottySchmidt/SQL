Pharmacy Analytics (Part 1) [CVS Health SQL Interview Question]

--------------------
with cvs as(SELECT product_id, drug, 
sum(total_sales) as sales, 
sum(cogs) as cogs,
(sum(total_sales)-sum(cogs)) as profit
FROM pharmacy_sales
GROUP BY product_id, drug
)

select drug, profit
FROM cvs
ORDER BY profit DESC
LIMIT 3
;
