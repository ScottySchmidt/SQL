/*
Best Selling Item, HARD MySQL Problem: https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=3

Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. 
The best selling item is calculated using the formula (unitprice * quantity).
Output the month, the description of the item along with the amount paid.
*/

with month_sales as ( 
select stockcode, description, sum(quantity*unitprice) as month_total,
month(invoicedate) as month 
FROM online_retail 
GROUP BY stockcode, description, month(invoicedate)
)

SELECT 
    LPAD(month, 2, '0') as month,  -- Not needed, but this makes month 01 instead of 1
    (SELECT description FROM month_sales WHERE month = m.month AND month_total = MAX(m.month_total)) as description,
    MAX(month_total) as total_paid  -- Gets the correct description to match
FROM month_sales m
GROUP BY month
ORDER BY month;

/*
month	description	total_paid
01	LUNCH BAG SPACEBOY DESIGN	74.26
02	REGENCY CAKESTAND 3 TIER	38.25
03	PAPER BUNTING WHITE LACE	102
04	SPACEBOY LUNCH BOX	23.4
05	PAPER BUNTING WHITE LACE	51
06	Dotcomgiftshop Gift Voucher £50.00	41.67
07	PAPER BUNTING WHITE LACE	56.1
08	LUNCH BAG PINK POLKADOT	16.5
09	RED RETROSPOT PEG BAG	34.72
10	CHOCOLATE HOT WATER BOTTLE	102
11	RED WOOLLY HOTTIE WHITE HEART.	228.25
12	PAPER BUNTING RETROSPOT	35.4
*/
