/* 
Counting overlapping events:
Create a SQL query which returns the maximum number of simultaneous uses of a service. 
Each usage ("visit") is logged with its entry and exit timestamps in a "visits" table structured as follows:
A visit starts at entry time and ends at exit time. 
At exactly exit time the visit is considered to have already finished. 
The visits table always contains at least one entry.
Your query should return a single row.
*/

--The following code finds overlap events using a case statement:
SELECT
CASE WHEN
(v1.entry_time BETWEEN v2.entry_time AND v2.exit_time)
THEN 'yes'
ELSE 'no'
END as overlap
FROM visits v1
JOIN visits v2
ON v1.id=v2.id

---The above is a good start but this problem is more challenging as we also need the EXACT time of overlap. 
--This can be found by taking the min value of the end time and the max value of start thime.
---This is where the overlap is in which we can then count the days of overlap:
