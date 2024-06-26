with

users AS (
    SELECT * 
    FROM {{ref('dim_users')}}
),

address AS (
    SELECT *
    FROM {{ref('dim_addresses')}}
),

products AS (
    SELECT * 
    FROM {{ref('dim_products')}}
),

promos AS (
    SELECT * 
    FROM {{ref('dim_promos')}}
),

orders AS (
    SELECT * 
    FROM {{ref('fct_orders')}}
),

promo_order as (
    SELECT
        o.order_id, 
        sum(pr.discount_usd) as total_discount_usd
    FROM orders o
    left JOIN promos pr ON o.promo_id = pr.promo_id
    group by all
),

orders_by_user AS (
    SELECT 
        u.user_id,
        o.order_id,
        o.order_total_usd,
        o.shipping_cost_amount_usd,
        count(distinct o.product_id) as total_different_product,
        sum(o.quantity) as quantity
    FROM users u
    inner JOIN orders o ON u.user_id = o.user_id
    group by all
),

dm_marketing as (
    SELECT DISTINCT
        u.user_id,
        u.first_name,
        u.last_name,
        u.email,
        u.phone_number,
        u.created_at_date,
        u.created_at_time_utc,
        u.updated_at_date,
        u.updated_at_time_utc,
        a.address,
        a.zipcode,
        a.state,
        a.country,
        count(distinct ou.order_id) as total_number_orders,
        sum(ou.order_total_usd) as total_order_cost_usd,
        sum(ou.shipping_cost_amount_usd) as total_shipping_cost_usd,
        pr.total_discount_usd,
        sum(ou.total_different_product) as total_different_product,
        sum(ou.quantity) as total_quantity_product
    FROM users u
    RIGHT JOIN orders_by_user ou ON u.user_id = ou.user_id
    inner JOIN address a ON u.address_id = a.address_id
    inner join promo_order pr ON ou.order_id = pr.order_id
    group by all
)

select * from dm_marketing