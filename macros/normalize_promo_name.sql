{% macro normalize_promo_name(promo_id) %}
    replace(lower(promo_id), ' ', '-') 
{% endmacro %}
