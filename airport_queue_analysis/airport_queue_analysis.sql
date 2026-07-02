/*
Project: Airport Queue Analysis

Domain: Ride-hailing

Database: SkyTaxi

Description:
This project analyzes driver behavior in airport queues using SQL.
The analysis focuses on identifying experienced airport drivers, evaluating airport queue efficiency, and determining the optimal arrival time at Domodedovo Airport to maximize the probability of receiving an order while minimizing waiting time.
*/

-- ============================================================================
-- Driver Performance Analysis
--
-- Business Goal:
-- Identify the most experienced airport drivers with the longest average
-- waiting time and compare how often they leave the airport with and without
-- a passenger.
--
-- Approach:
-- 1. Select drivers who visited airports more than once.
-- 2. Rank them by average waiting time.
-- 3. Keep the top 10 drivers.
-- 4. Calculate successful and unsuccessful departures.
-- ============================================================================

SELECT
    segm.id_driver,
    SUM(left_w_order) AS with_order,
    SUM(CASE
            WHEN left_w_order = 0 THEN 1
            ELSE 0
        END) AS without_order

FROM (

    SELECT
        id_driver,
        AVG(time_left - time_came) AS length_wait

    FROM skytaxi.airport_visit

    GROUP BY id_driver

    HAVING COUNT(time_came) > 1

    ORDER BY length_wait DESC

    LIMIT 10

) AS segm

JOIN skytaxi.airport_visit AS av

    ON segm.id_driver = av.id_driver

GROUP BY segm.id_driver;

-- Insight:
-- The query identifies the airport drivers with the longest average waiting
-- time and compares how frequently they receive an order after waiting.

-- ============================================================================
-- Airport Queue Efficiency
--
-- Business Goal:
-- Calculate:
-- • average airport waiting time;
-- • share of successful departures.
--
-- Include only:
-- • airports with more than 100 airport visits;
-- • drivers whose total airport waiting time exceeds 12 hours.
-- ============================================================================

WITH airport AS (

    SELECT
        id_port

    FROM skytaxi.airport_visit

    GROUP BY id_port

    HAVING COUNT(time_came) > 100

),

drivers AS (

    SELECT
        id_driver

    FROM skytaxi.airport_visit

    GROUP BY id_driver

    HAVING SUM(time_left - time_came) > INTERVAL '12 hour'

)

SELECT

    AVG(time_left - time_came) AS avg_wait,

    SUM(left_w_order)::float
        / COUNT(time_came) AS success_rate

FROM skytaxi.airport_visit

WHERE id_driver IN (

    SELECT id_driver
    FROM drivers

)

AND id_port IN (

    SELECT id_port
    FROM airport

);

-- Insight:
-- The resulting metrics summarize queue efficiency for active airport drivers
-- and the busiest airports, showing both waiting time and the probability of
-- leaving the airport with an order.

-- ============================================================================
-- Optimal Arrival Time Analysis
--
-- Business Goal:
-- Determine the best time to arrive at Domodedovo Airport by comparing:
-- • average waiting time;
-- • probability of receiving an order.
--
-- Results are aggregated by arrival hour.
-- ============================================================================

SELECT

    EXTRACT(HOUR FROM time_came) AS arrival_hour,

    AVG(time_left - time_came) AS avg_wait,

    SUM(left_w_order)::float
        / COUNT(time_came) AS success_rate

FROM skytaxi.airport_visit

WHERE id_port = 'Домодедово'

GROUP BY arrival_hour

ORDER BY arrival_hour;

-- Insight:
-- Comparing waiting time and success rate by hour helps identify the periods
-- that provide the best balance between queue duration and the likelihood of
-- receiving an order.

-- ============================================================================
