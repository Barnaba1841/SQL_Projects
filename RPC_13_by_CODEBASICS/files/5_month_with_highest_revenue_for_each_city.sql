WITH CityMonthlyRevenue AS (
    -- Step 1: Calculate total revenue for each city and month
    SELECT 
        dim_city.city_name,
        dim_date.month_name,
        SUM(fact_trips.fare_amount) AS monthly_revenue
    FROM 
        trips_db.fact_trips
    JOIN 
        trips_db.dim_city
    ON 
        fact_trips.city_id = dim_city.city_id
    JOIN 
        trips_db.dim_date
    ON 
        fact_trips.date = dim_date.date
    GROUP BY 
        dim_city.city_name, dim_date.month_name
),
CityTotalRevenue AS (
    -- Step 2: Calculate total revenue for each city
    SELECT 
        city_name,
        SUM(monthly_revenue) AS total_city_revenue
    FROM 
        CityMonthlyRevenue
    GROUP BY 
        city_name
),
CityHighestRevenueMonth AS (
    -- Step 3: Find the month with the highest revenue for each city
    SELECT 
        city_name,
        month_name AS highest_revenue_month,
        monthly_revenue AS highest_month_revenue
    FROM (
        SELECT 
            city_name,
            month_name,
            monthly_revenue,
            RANK() OVER (PARTITION BY city_name ORDER BY monthly_revenue DESC) AS revenue_rank
        FROM 
            CityMonthlyRevenue
    ) AS ranked_data
    WHERE 
        revenue_rank = 1
)
-- Step 4: Combine results and calculate percentage contribution
SELECT 
    CityHighestRevenueMonth.city_name,
    CityHighestRevenueMonth.highest_revenue_month,
    CityHighestRevenueMonth.highest_month_revenue AS revenue,
    ROUND((CityHighestRevenueMonth.highest_month_revenue * 100.0) / CityTotalRevenue.total_city_revenue, 2) AS percent_contribution
FROM 
    CityHighestRevenueMonth
JOIN 
    CityTotalRevenue
ON 
    CityHighestRevenueMonth.city_name = CityTotalRevenue.city_name
ORDER BY 
    percent_contribution DESC;
