SELECT 
    dim_city.city_name, -- City name
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 2 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "2-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 3 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "3-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 4 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "4-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 5 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "5-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 6 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "6-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 7 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "7-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 8 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "8-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 9 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "9-trips",
    ROUND(SUM(CASE WHEN dim_repeat_trip_distribution.trip_count = 10 THEN repeat_passenger_count END) * 100.0 / NULLIF(total_repeat_passengers.total, 0), 2) AS "10-trips"
FROM 
    trips_db.dim_repeat_trip_distribution
JOIN 
    trips_db.dim_city
ON 
    dim_repeat_trip_distribution.city_id = dim_city.city_id -- Join to get city names
JOIN 
    (
        -- Subquery to calculate total repeat passengers per city
        SELECT 
            city_id, 
            SUM(repeat_passenger_count) AS total 
        FROM 
            trips_db.dim_repeat_trip_distribution
        GROUP BY 
            city_id
    ) AS total_repeat_passengers
ON 
    dim_repeat_trip_distribution.city_id = total_repeat_passengers.city_id
GROUP BY 
    dim_city.city_name, total_repeat_passengers.total
ORDER BY 
    dim_city.city_name;
