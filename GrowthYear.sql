'''
Growth of Airbnb:  Hard Data Analytics Question: https://platform.stratascratch.com/coding/9637-growth-of-airbnb?code_type=2
Estimate the growth of Airbnb each year using the number of hosts registered as the growth metric. 
The rate of growth is calculated by taking ((number of hosts registered in the current year - number of hosts registered in the previous year) / the number of hosts registered in the previous year) * 100.
Output the year, number of hosts in the current year, number of hosts in the previous year, and the rate of growth. 
Round the rate of growth to the nearest percent and order the result in the ascending order based on the year.
Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.
'''
  
--- SQL Server Solution
with cte as (select id, year(host_since) as year
from airbnb_search_details),

cte2 as (SELECT count(id) as cur_count_id, year
FROM cte
GROUP BY year
),

cte3 as (SELECT year, cur_count_id,
lag(cur_count_id, 1) OVER(ORDER BY year) as prev_year_count
FROM cte2 )

SELECT year, cur_count_id, prev_year_count,
  CASE
           WHEN prev_year_count IS NULL OR prev_year_count = 0 THEN NULL
           ELSE (100*(cur_count_id - prev_year_count) / prev_year_count) 
       END AS growth_rate
FROM cte3;


--- Python Solution
import pandas as pd

# Get the only filters needed:
df=airbnb_search_details[['host_since', 'id']]

# Get current year:
df['year'] = df['host_since'].dt.year

# Drop the old date column:
df.drop('host_since', axis=1, inplace=True)

#Get unique id count, group by year
unique_id_year = df.groupby('year')['id'].nunique().reset_index().rename(columns={'id': 'cur_id_count'})

#Calculate growth metric:
unique_id_year['prev_id_count'] = unique_id_year['cur_id_count'].shift(1).fillna(0)
unique_id_year['growth_metric'] = (unique_id_year['cur_id_count']-unique_id_year['prev_id_count'])/unique_id_year['prev_id_count']*100

unique_id_year['growth_metric']=unique_id_year['growth_metric'].round()
print(unique_id_year)
