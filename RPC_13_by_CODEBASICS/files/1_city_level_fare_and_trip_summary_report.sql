SELECT 
    dim_city.city_name AS city_name, -- Retrieves the name of each city
    COUNT(fact_trips.trip_id) AS total_trips, -- Counts the total number of trips for each city
    AVG(fact_trips.fare_amount / NULLIF(fact_trips.distance_travelled_km, 0)) AS avg_fare_per_km, -- Calculates the average fare per kilometer (avoids division by zero using NULLIF)
    AVG(fact_trips.fare_amount) AS avg_fare_per_trip, -- Calculates the average fare per trip
    ROUND(
        (COUNT(fact_trips.trip_id) * 100.0 / (SELECT COUNT(*) FROM fact_trips)), 
        2
    ) AS pct_contribution_to_total_trips -- Computes the percentage contribution of each city's trips to the total trips across all cities
FROM 
    dim_city
JOIN 
    fact_trips
ON 
    dim_city.city_id = fact_trips.city_id -- Joins the dim_city table with fact_trips based on city_id
GROUP BY 
    dim_city.city_name -- Groups the results by city name to calculate metrics for each city
ORDER BY 
    total_trips DESC; -- Orders the results in descending order of total trips
