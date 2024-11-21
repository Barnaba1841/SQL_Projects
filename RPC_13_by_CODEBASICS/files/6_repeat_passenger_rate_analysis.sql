WITH MonthlyPassengerStats AS (
    -- Step 1: Aggregate total passengers and repeat passengers for each city and month
    SELECT 
        dim_city.city_name,
        dim_date.month_name,
        SUM(fact_passenger_summary.total_passengers) AS total_passengers,
        SUM(fact_passenger_summary.repeat_passengers) AS repeat_passengers
    FROM 
        trips_db.fact_passenger_summary
    JOIN 
        trips_db.dim_city
    ON 
        fact_passenger_summary.city_id = dim_city.city_id
    JOIN 
        trips_db.dim_date
    ON 
        fact_passenger_summary.month = dim_date.start_of_month -- Ensure correct column matching
    GROUP BY 
        dim_city.city_name, dim_date.month_name
),
CityPassengerStats AS (
    -- Step 2: Calculate city-wide aggregated totals
    SELECT 
        city_name,
        SUM(total_passengers) AS total_city_passengers,
        SUM(repeat_passengers) AS total_city_repeat_passengers
    FROM 
        MonthlyPassengerStats
    GROUP BY 
        city_name
),
FinalStats AS (
    -- Step 3: Combine data to calculate rates
    SELECT 
        mps.city_name,
        mps.month_name AS month,
        mps.total_passengers,
        mps.repeat_passengers,
        ROUND((mps.repeat_passengers * 100.0) / NULLIF(mps.total_passengers, 0), 2) AS monthly_repeat_passenger_rate,
        ROUND((cps.total_city_repeat_passengers * 100.0) / NULLIF(cps.total_city_passengers, 0), 2) AS city_repeat_passenger_rate
    FROM 
        MonthlyPassengerStats mps
    JOIN 
        CityPassengerStats cps
    ON 
        mps.city_name = cps.city_name
)
-- Step 4: Select and order final results
SELECT 
    city_name,
    month,
    total_passengers,
    repeat_passengers,
    monthly_repeat_passenger_rate,
    city_repeat_passenger_rate
FROM 
    FinalStats
ORDER BY 
    city_name, month;
