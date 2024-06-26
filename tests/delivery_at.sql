SELECT *
FROM {{ ref('stg_sqlserver__orders') }}
WHERE delivered_at_date < created_at_date AND delivered_at_time_utc < created_at_time_utc
-- checks if there is any case where the delivery date is earlier than the date the order was placed, which would not make logical sense and would indicate some kind of problem with the data 