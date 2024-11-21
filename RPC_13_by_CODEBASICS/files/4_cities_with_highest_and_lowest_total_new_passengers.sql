WITH CityNewPassengers AS (
    -- Step 1: Aggregate total new passengers for each city
    SELECT 
        trips_db.dim_city.city_name, 
        SUM(trips_db.fact_passenger_summary.new_passengers) AS total_new_passengers
    FROM 
        trips_db.fact_passenger_summary
    JOIN 
        trips_db.dim_city
    ON 
        trips_db.fact_passenger_summary.city_id = trips_db.dim_city.city_id
    GROUP BY 
        trips_db.dim_city.city_name
),
RankedCities AS (
    -- Step 2: Rank cities by total new passengers
    SELECT 
        city_name, 
        total_new_passengers,
        RANK() OVER (ORDER BY total_new_passengers DESC) AS rank_top, -- Ranking for top 3
        RANK() OVER (ORDER BY total_new_passengers ASC) AS rank_bottom -- Ranking for bottom 3
    FROM 
        CityNewPassengers
)
-- Step 3: Assign categories based on ranks
SELECT 
    city_name,
    total_new_passengers,
    CASE 
        WHEN rank_top <= 3 THEN 'Top3'
        WHEN rank_bottom <= 3 THEN 'Bottom3'
        ELSE 'Others'
    END AS city_category
FROM 
    RankedCities
ORDER BY 
    city_category, total_new_passengers DESC;
