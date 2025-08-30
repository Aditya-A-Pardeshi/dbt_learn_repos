{{ config(
    materialized='table',
    schema='staging'
) }}

WITH ranked_customers AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY c_nationkey ORDER BY c_custkey) AS rn
  FROM {{ref('CUSTOMER')}}
)
SELECT *
FROM ranked_customers
WHERE rn < 150