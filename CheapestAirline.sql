/*
The Cheapest Airline Connection, Delta Airlines:
https://platform.stratascratch.com/coding/2008-the-cheapest-airline-connection?code_type=5

COMPANY X employees are trying to find the cheapest flights to upcoming conferences. 
When people fly long distances, a direct city-to-city flight is often more expensive than taking two flights with a stop in a hub city. Travelers might save even more money by breaking the trip into three flights with two stops. But for the purposes of this challenge, let's assume that no one is willing to stop three times! You have a table with individual airport-to-airport flights, which contains the following columns:

• id - the unique ID of the flight;
• origin - the origin city of the current flight;
• destination - the destination city of the current flight;
• cost - the cost of current flight.

Your task is to produce a trips table that lists all the cheapest possible trips that can be done in two or fewer stops.
This table should have the columns origin, destination and total_cost (cheapest one). 
Sort the output table by origin, then by destination. 
The cities are all represented by an abbreviation composed of three uppercase English letters. 
Note: A flight from SFO to JFK is considered to be different than a flight from JFK to SFO.

Example of the output:
origin | destination | total_cost
DFW | JFK | 200
*/

--SQL Server and MySQL Solution:
with one_stop as (
SELECT 	a.origin as first_origin,
a.destination as first_dest, 
a.cost as cost1, 
b.origin as second_origin, 
b.destination as second_dest, 
b.cost as cost2,
a.cost+b.cost as total_cost,
concat(a.origin, ' -> ', b.destination) as route
FROM da_flights a, da_flights b
WHERE a.destination = b.origin
),

two_stop as (
SELECT 	a.origin as first_origin,
a.destination as first_dest, 
a.cost as cost1, 
b.origin as second_origin, 
b.destination as second_dest, 
b.cost as cost2,
c.origin as third_origin, 
c.destination as third_dest,
c.cost,
a.cost+b.cost+c.cost as total_cost,
concat(a.origin, ' -> ', b.destination, ' -> ', c.destination)  as route
FROM da_flights a, da_flights b, da_flights c
WHERE a.destination = b.origin
AND b.origin = c.destination
),

final_flights as (
SELECT origin, destination, cost as total_cost, concat(origin, ' -> ' , destination) as route
FROM da_flights
UNION ALL
SELECT first_origin, second_dest, total_cost, route
FROM one_stop
UNION ALL
SELECT first_origin, third_dest, total_cost, route
FROM two_stop)

SELECT origin, destination, min(total_cost) as cheapest_flight, min(route) as route
FROM final_flights
GROUP BY origin, destination
ORDER BY cheapest_flight

/*
FINAL OUTPUT with the arrows so route can be clearly seen:
origin	destination	cheapest_flight	route
DFW	JFK	200	DFW -> JFK
DFW	LHR	1200	DFW -> LHR
DFW	MCO	100	DFW -> MCO
JFK	LHR	1000	JFK -> LHR
SFO	DFW	200	SFO -> DFW
SFO	JFK	400	SFO -> JFK
SFO	LHR	1500	SFO -> LHR
*/

    

---My original incorrect solution only accounts for one stop but not 0 or 2. 
WITH FlightPairs AS (
    SELECT
        f1.id AS first_flight_id,
        f1.origin AS first_origin,
        f1.destination AS first_destination,
        f1.cost AS first_cost,
        f2.id AS second_flight_id,
        f2.origin AS second_origin,
        f2.destination AS second_destination,
        f2.cost AS second_cost,
        f1.cost + f2.cost AS total_cost,
        ROW_NUMBER() OVER (PARTITION BY f1.destination, f2.destination ORDER BY f1.cost + f2.cost ASC) AS row_num
    FROM
        da_flights f1
    JOIN
        da_flights f2 ON f1.destination = f2.origin
)
SELECT
    first_flight_id,
    first_origin,
    first_destination,
    first_cost,
    second_flight_id,
    second_origin,
    second_destination,
    second_cost,
    total_cost
FROM
    FlightPairs
WHERE
    row_num = 1;
