{% set event_types = ["checkout", "package_shipped", "add_to_cart","page_view"] %}
WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sqlserver__events') }}
),

events_count_per_user AS (
    SELECT
        session_id,
        user_id,
        {%- for event_type in event_types   %}
        sum(case when event_type = '{{event_type}}' then 1 end) as {{event_type}}_amount
        {%- if not loop.last %},{% endif -%}
        {% endfor %}
    FROM stg_events
    GROUP BY all
),

events AS (
    SELECT
        e.session_id,
        e.user_id,
        e.event_id,
        e.page_url,
        e.event_type_id,
        e.product_id,
        e.created_at,
        e.order_id,
        e._fivetran_synced_utc,
        eu.checkout_amount,
        eu.package_shipped_amount,
        eu.add_to_cart_amount,
        eu.page_view_amount
    FROM stg_events e
    inner join events_count_per_user eu ON e.session_id = eu.session_id
)

SELECT * FROM events