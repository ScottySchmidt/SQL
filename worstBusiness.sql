/* Worst Businesses, Hard SQL: https://platform.stratascratch.com/coding/9739-worst-businesses?code_type=5
For every year, find the worst business in the dataset. The worst business has the most violations during the year. You should output the year, business name, and number of violations.
*/ 

--SQL Server and MySQL:
with business as (SELECT business_name, year(inspection_date) as inspect_year, COUNT(business_name) as violations_count
FROM sf_restaurant_health_violations
GROUP BY business_name, year(inspection_date)
), 

business2 as (SELECT business_name, inspect_year, violations_count,
ROW_NUMBER() OVER (PARTITION BY inspect_year ORDER BY violations_count DESC) as rn
FROM business)

SELECT business_name, inspect_year, violations_count
FROM business2
WHERE rn = 1


--- Python
import pandas as pd

# Assuming df is your DataFrame with 'business_name' and 'inspection_date'
df = sf_restaurant_health_violations[['business_name', 'inspection_date']]

# Add a 'Year' column
df['Year'] = df['inspection_date'].dt.year

# Group by 'Year' and 'business_name', find the maximum count for each combination
count_df = df.groupby(['Year', 'business_name']).size().reset_index(name='count')

# Find the index of the maximum count for each year
max_counts_index = count_df.groupby('Year')['count'].idxmax()

# Get the corresponding rows with the highest count for each year
max_counts = count_df.loc[max_counts_index]
