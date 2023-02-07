Pharmacy Analytics (Part 1) [CVS Health SQL Interview Question]
Top three most profitable drugs
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

==============================================================
Pharmacy Analytics (Part 2) [CVS Health SQL Interview Question]
CVS Health is trying to better understand its pharmacy sales, and how well different products are selling.
Each drug can only be produced by one manufacturer.
Write a query to find out which manufacturer is associated with the drugs that were not profitable and how much money CVS lost on these drugs. 
Output the manufacturer, number of drugs and total losses. Total losses should be in absolute value. Display the results with the highest losses on top.

Must do total_sales-cogs so profitable drugs are not included. 
This part is slightly confusing.
--------------------------

with cvs as (SELECT manufacturer, 
count(drug) as drug_count,
sum(total_sales-cogs) as net_total
FROM pharmacy_sales
WHERE total_sales-cogs<=0
GROUP BY manufacturer
)

=================================================================
Pharmacy Analytics (Part 3) [CVS Health SQL Interview Question]
CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. 
Each drug can only be produced by one manufacturer.
Write a query to find the total sales of drugs for each manufacturer.
Round your answer to the closest million, and report your results in descending order of total sales.
Because this data is being directly fed into a dashboard which is being seen by business stakeholders, format your result like this: "$36 million".
--------------------------------------------------------

with cvs as (SELECT manufacturer, sum(total_sales) as sales
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY sales DESC
)

SELECT manufacturer, concat('$', round((sales/1000000),0) ,' million') as sales
FROM cvs
;

SELECT manufacturer, drug_count,
abs(net_total)
FROM cvs
ORDER BY abs(net_total) DESC
;
