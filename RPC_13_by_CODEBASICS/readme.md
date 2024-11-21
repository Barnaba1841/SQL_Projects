# Codebasics Resume Project Challenge 13: Adhoc Requests

This repository showcases solutions to **Adhoc Requests** tasks as part of the Codebasics Resume Project Challenge 13. These tasks involve SQL queries to analyze data from two databases: `trips_db` and `targets_db`.

---

## 🔍 Adhoc Requests Overview

### Business Request -1. **City Level Fare and Trip Summary Report**
- **Objective**: Calculate each city's percentage contribution to the total number of trips.
- **Output**: `city_name, total_trips, avg_fare_per_km, avg_fare_per_trip, percent_contribution`
- **SQL Script**: [1_city_level_fare_and_trip_summary_report.sql](files/1_city_level_fare_and_trip_summary_report.sql)  
- **Output**: [AdHoc-1](files/adhoc1.png)

---

### Business Request -2. **Monthly City-Level Trips Target Performance Report**
- **Objective**: Compare actual trips and target trips by city and month, determine performance status, and compute the percentage difference.
- **Output**: `city_name, month, actual_trips, target_trips, performance_status, percentage_difference`
- **SQL Script**: [2_monthly_city_level_trips_target_performance_report.sql](files/2_monthly_city_level_trips_target_performance_report.sql)
- - **Output**: [AdHoc-2](files/adhoc2.csv)

---

### Business Request -3. **City-Level Repeat Passenger Trip Frequency Report**
- **Objective**: Calculate the percentage distribution of repeat passengers based on the number of trips they have taken in each city.
- **Output**: `city_name, 2-trips, 3-trips, ... 10-trips`
- **SQL Script**: [3_city_level_repeat_passenger_trip_frequency_report.sql](files/3_city_level_repeat_passenger_trip_frequency_report.sql)
- - **Output**: [AdHoc-3](files/adhoc3.png)

---

### Business Request -4. **Cities with Highest and Lowest Total New Passengers**
- **Objective**: Categorize cities into "Top 3" or "Bottom 3" based on the number of new passengers.
- **Output**: `city_name, total_new_passengers, city_category`
- **SQL Script**: [4_cities_with_highest_and_lowest_total_new_passengers.sql](files/4_cities_with_highest_and_lowest_total_new_passengers.sql)
- - **Output**: [AdHoc-4](files/adhoc4.png)

---

### Business Request -5. **Month with Highest Revenue for Each City**
- **Objective**: For each city, find the month with the highest revenue, its value, and the percentage contribution to the city’s total revenue.
- **Output**: `city_name, highest_revenue_month, revenue, percent_contribution`
- **SQL Script**: [5_month_with_highest_revenue_for_each_city.sql](files/5_month_with_highest_revenue_for_each_city.sql)
- - **Output**: [Adhoc-5](files/adhoc5.png)

---

### Business Request -6. **Repeat Passenger Rate Analysis**
- **Objective**: Compute repeat passenger rates for each city and its months.
- **Output**: `city_name, month, total_passengers, repeat_passengers, monthly_repeat_passenger_rate, city_repeat_passenger_rate`
- **SQL Script**: [6_repeat_passenger_rate_analysis.sql](files/6_repeat_passenger_rate_analysis.sql)
- - **Output**: [AdHoc-6](files/adhoc6.csv)

---


## Supporting Information : 
- **Sample Data Description** :

## Trips Database : 
`trips.db`

dim_city: Contains city information.  
Fields: `city_id, city_name`

dim_date: Holds date-related details, such as month and type of day.  
Fields: `date, start_of_month, month_name, day_type`

dim_repeat_trip_distribution: Stores data on repeat trips by month and city.  
Fields: `month, city_id, trip_count, repeat_passenger_count`

fact_passenger_summary: Summarizes passenger data by month and city.  
Fields: `month, city_id, total_passengers, new_passengers, repeat_passengers`

fact_trips: Contains detailed trip records, including passenger and driver ratings.  
Fields: `trip_id, date, city_id, passenger_type, distance_travelled_km, fare_amount, passenger_rating, driver_rating`

## Targets Database :
`targets_db`

city_target_passenger_rating: Contains the target average passenger rating for each city.  
Fields: `city_id, target_average_passenger_rating`

monthly_target_new_passengers: Provides the target number of new passengers per month for each city.  
Fields: `month, city_id, target_new_passengers`

monthly_target_trips: Specifies the total target trips for each city by month.  
Fields: `month, city_id, total_target_trips`


---

## 💡 About the Challenge
This work is part of the **Codebasics Resume Project Challenge 13** and demonstrates SQL proficiency through a series of business-related data analysis tasks.

