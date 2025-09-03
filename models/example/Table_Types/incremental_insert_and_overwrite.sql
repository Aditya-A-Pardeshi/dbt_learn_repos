{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwrite',
    partition_by={'field': 'order_date', 'data_type': 'date'},
    database='RAW',
    schema='ECOMMERCE'
) }}

SELECT
  order_id,
  customer_id,
  total_amount,
  order_date
FROM {{ source('ecommerce', 'raw_orders') }}

{% if is_incremental() %}
  -- Filter only recent dates to limit what partitions are overwritten
  WHERE order_date >= dateadd(day, -3, current_date)
{% endif %}
