/*
APPLE PRODUCT COUNTS. StrataScratch: 
Find the number of Apple product users and the number of total users with a device and group the counts by language. 
Assume Apple products are only MacBook-Pro, iPhone 5s, and iPad-air. 
Output the language along with the total number of Apple users and users with any device.
Order your results based on the number of total users in descending order.
*/

--- SQL Server Solution:
with apple as(SELECT u.language, 
COUNT(distinct e.user_id) as n_apple_user
FROM playbook_events e
JOIN playbook_users u
ON u.user_id = e.user_id
WHERE e.device IN('macbook pro', 'iphone 5s', 'ipad air')
GROUP BY u.language
),

total as(SELECT u.language, 
COUNT(distinct e.user_id) as n_total_user
FROM playbook_events e
JOIN playbook_users u
ON u.user_id = e.user_id
GROUP BY u.language
)

SELECT t.language, 
COALESCE(a.n_apple_user,0) as apple_users, 
COALESCE(t.n_total_user,0) as total_users
FROM total t
FULL OUTER JOIN apple a 
ON t.language = a.language
ORDER BY t.n_total_user DESC

-- Python Solution: 
import pandas as pd

df1 = playbook_events
df2 = playbook_users

df = df1.merge(df2, on='user_id', how='inner')

mac_device = ["macbook pro", "iphone 5s", "ipad air"]
appleDF = df[df['device'].isin(mac_device)]
appleDF = appleDF.groupby('language')['user_id'].nunique().reset_index(name="n_apple_users")

df = df.groupby('language')['user_id'].nunique().reset_index(name="n_total_users")
finalDF = appleDF.merge(df, on='language', how='outer').fillna(0)
finalDF



