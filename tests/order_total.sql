SELECT
    order_id,
    promo_id,
    order_cost_usd,
    shipping_cost_amount_usd,
    discount_usd,
    order_total_usd
FROM {{ ref('stg_sqlserver__orders') }}
JOIN {{ ref('stg_sqlserver__promos') }}
USING(promo_id)
WHERE ABS((order_cost_usd + shipping_cost_amount_usd) - discount_usd - order_total_usd) > 0.01
-- Check if the difference between the calculated value and the actual value of order_total_usd is greater than 0.01.