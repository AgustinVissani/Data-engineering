{{ config(
  materialized='table'
) }}

WITH dim_month AS (
    {{ dbt_date.get_date_dimension("2019-01-01", "2027-12-31") }}
)

SELECT
    date_day,
    day_of_week_name AS day_of_week,
    day_of_month,
    week_of_year,
    month_of_year,
    year_number,
    quarter_of_year AS quarter_of_the_year
FROM dim_month
