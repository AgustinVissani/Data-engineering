WITH dim_sellers AS (
    SELECT
        seller_id,
        first_name,
        last_name,
        salary,
        commission,
        _fivetran_synced_utc
    FROM {{ ref("dim_sellers") }}
),

fct_order AS (
    SELECT
        order_id,
        order_total_usd,
        seller_id
    FROM {{ ref("fct_orders") }}
)

SELECT
    ds.seller_id,
    ds.first_name,
    ds.last_name,
    ds.commission AS commission_prc,
    ds._fivetran_synced_utc,
    COUNT(DISTINCT fo.order_id) AS total_order_seller,
    SUM(fo.order_total_usd) AS total_sales_seller_usd,
    (ds.commission / 100)
    * SUM(fo.order_total_usd)::decimal(7, 1) AS total_benefits_commission,
    ds.salary,
    ds.salary + ((ds.commission / 100) * SUM(fo.order_total_usd)::decimal(7, 1)) AS current_salary
FROM dim_sellers ds
INNER JOIN fct_order fo
    ON ds.seller_id = fo.seller_id
GROUP BY
    ds.seller_id,
    ds.first_name,
    ds.last_name,
    ds.commission,
    ds._fivetran_synced_utc,
    ds.salary
