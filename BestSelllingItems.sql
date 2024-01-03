/* Best Selling Items, Hard Amazon and Ebay SQL: https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=3
Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. 
The best selling item is calculated using the formula (unitprice * quantity). 
Output the month, the description of the item along with the amount paid.
*/

-- YouTube Solution: https://www.youtube.com/watch?v=ON61CG7BvGs
with items as(SELECT month(invoicedate) as month, description, 
sum(unitprice * quantity) as total_sales,
dense_rank() OVER(PARTITION BY month(invoicedate) ORDER BY sum(unitprice * quantity) DESC) as ranked
FROM online_retail
GROUP BY month(invoicedate), description
)

--Select final table with rank 1 and change month to 01 format:
SELECT LPAD(month, 2, "0") as month, description, total_sales
FROM items
WHERE ranked =1
