/*
Cum Sum Energy Consumption, Hard: https://platform.stratascratch.com/coding/10084-cum-sum-energy-consumption?code_type=3
Calculate the running total (i.e., cumulative sum) energy consumption of the Meta/Facebook data centers in all 3 continents by the date. 
Output the date, running total energy consumption, and running total percentage rounded to the nearest whole number.
*/

--MySQL Solution:
with data_table as (
select * from fb_eu_energy
union all
select * from fb_na_energy
union all
select * from fb_asia_energy
),

daily_energy as(SELECT date,
sum(consumption) as total
FROM data_table
GROUP BY date
ORDER BY date
)

SELECT date, 
sum(total) OVER(order by date asc) as running_total,
round(100*sum(total) OVER(order by date asc)/(SELECT
sum(total) FROM daily_energy)) as run_percent
FROM daily_energy
