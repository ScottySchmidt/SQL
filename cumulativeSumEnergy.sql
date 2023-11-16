*/
Cum Sum Energy Consumption: https://platform.stratascratch.com/coding/10084-cum-sum-energy-consumption?code_type=3
Calculate the running total (i.e., cumulative sum) energy consumption of the Meta/Facebook data centers in all 3 continents by the date. Output the date, running total energy consumption, and running total percentage rounded to the nearest whole number.
/*

--MySQL  
with joined as (select a.date, a.consumption as total_consumption
FROM fb_asia_energy a
UNION 
SELECT na.date, na.consumption 
FROM fb_na_energy na
UNION 
SELECT eu.date, eu.consumption 
FROM fb_eu_energy eu 
)

SELECT date, SUM(total_consumption) OVER (ORDER BY date) AS cumulative_consumption
FROM joined 
GROUP BY date
ORDER BY DATE ASC;

