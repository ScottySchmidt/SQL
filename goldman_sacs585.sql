/*
585. Investments in 2016: https://leetcode.com/problems/investments-in-2016/description/

Table: Insurance
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key column for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
 
Write an SQL query to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city like any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.
----------------------------------------------------------
*/


--- Initial solution that needs to be more concise:
with location as ( 
SELECT pid, concat(lat, " ", lon) as place FROM insurance
), 

unique_location as (SELECT min(pid) as pid, place 
FROM location
GROUP BY place
HAVING count(place) = 1
)

SELECT tiv_2016 
FROM insurance
WHERE pid IN (SELECT pid FROM insurance 
GROUP BY tiv_2015 HAVING count(tiv_2015) > 1 )
AND pid IN (SELECT pid FROM unique_location)
