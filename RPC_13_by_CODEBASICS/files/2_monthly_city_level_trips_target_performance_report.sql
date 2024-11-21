SELECT 
    trips_db.dim_city.city_name AS city_name, -- Retrieves the city name
    trips_db.dim_date.month_name AS month_name, -- Retrieves the month name
    COUNT(trips_db.fact_trips.trip_id) AS actual_trips, -- Counts the actual number of trips
    targets_db.monthly_target_trips.total_target_trips AS target_trips, -- Retrieves the target trips
    CASE 
        WHEN COUNT(trips_db.fact_trips.trip_id) >= targets_db.monthly_target_trips.total_target_trips THEN 'Above Target'
        ELSE 'Below Target'
    END AS performance_status, -- Determines performance status
    ROUND(
        ((COUNT(trips_db.fact_trips.trip_id) - targets_db.monthly_target_trips.total_target_trips) * 100.0 / 
        NULLIF(targets_db.monthly_target_trips.total_target_trips, 0)), 2
    ) AS percentage_difference -- Calculates percentage difference
FROM 
    trips_db.dim_city
JOIN 
    trips_db.fact_trips
ON 
    trips_db.dim_city.city_id = trips_db.fact_trips.city_id -- Join city and trips
JOIN 
    trips_db.dim_date
ON 
    trips_db.fact_trips.date = trips_db.dim_date.date -- Join trips and dates
JOIN 
    targets_db.monthly_target_trips
ON 
    trips_db.dim_city.city_id = targets_db.monthly_target_trips.city_id 
    AND trips_db.dim_date.month_name = MONTHNAME(STR_TO_DATE(targets_db.monthly_target_trips.month, '%Y-%m-%d')) -- Extract month name for comparison
WHERE 
    targets_db.monthly_target_trips.total_target_trips IS NOT NULL -- Ensure targets exist
GROUP BY 
    trips_db.dim_city.city_name, trips_db.dim_date.month_name, targets_db.monthly_target_trips.total_target_trips
ORDER BY 
    trips_db.dim_city.city_name, trips_db.dim_date.month_name;

