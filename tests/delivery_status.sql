SELECT *
FROM {{ ref('stg_sqlserver__orders') }}
WHERE status IN ('preparing', 'shipped')
  AND estimated_delivery_at_date IS NOT NULL
  AND estimated_delivery_at_time_utc IS NOT NULL
  AND delivered_at_date IS NOT NULL
  AND delivered_at_time_utc IS NOT NULL
  AND tracking_id IS NOT NULL
  AND shipping_service_name != ''
