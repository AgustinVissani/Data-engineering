WITH budgets AS (
    SELECT * 
    FROM {{ref('stg_google_sheets__budget')}}
),

products AS (
    SELECT * 
    FROM {{ref('dim_products')}}
),

orders AS (
    SELECT * 
    FROM {{ref('fct_orders')}}
),

budget_details AS (
    SELECT 
        b.budget_id,
        b.product_id,
        p.product_name,
        b.month,
        p.price_usd,
        b.quantity_sold_expected,
        COALESCE(SUM(o.quantity), 0) AS quantity_sold_actual,
        (b.quantity_sold_expected - COALESCE(SUM(o.quantity), 0)) AS quantity_remaining,
        quantity_sold_actual *  p.price_usd AS total_sales_usd,
        total_sales_usd - (b.quantity_sold_expected * p.price_usd) AS earnings_over_estimates
    FROM budgets b
    LEFT JOIN products p ON b.product_id = p.product_id
    LEFT JOIN orders o ON b.product_id = o.product_id 
            AND MONTH(b.month) = MONTH(o.created_at_date)
            AND YEAR(b.month) = YEAR(o.created_at_date)
    GROUP BY b.month, b.budget_id, b.product_id,  p.product_name, p.price_usd, b.quantity_sold_expected
    ORDER BY b.month, b.budget_id, b.product_id
)

SELECT *
FROM budget_details
