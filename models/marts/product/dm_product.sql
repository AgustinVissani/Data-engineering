
WITH events AS (
    SELECT * 
    FROM {{ref('fct_events')}}
),

users AS (
    SELECT * 
    FROM {{ref('dim_users')}}
),

product_event_user AS (
    SELECT
        e.session_id,
        u.user_id,
        u.first_name,
        u.last_name,
        u.email,
        MIN(e.created_at) AS first_event_time_utc,
        MAX(e.created_at) AS last_event_time_utc,
        DATEDIFF(minute, first_event_time_utc, last_event_time_utc) AS session_length_minutes,
        e.page_view_amount as page_view,
        e.add_to_cart_amount as add_to_cart,   
        e.checkout_amount as checkout,
        e.package_shipped_amount as package_shipped        
    FROM events e
    RIGHT JOIN users u ON e.user_id = u.user_id
    GROUP BY ALL
)

SELECT * FROM product_event_user