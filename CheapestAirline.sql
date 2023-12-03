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

---SQL Server:
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
