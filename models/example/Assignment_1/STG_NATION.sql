{{ config(
    materialized='table',
    schema='staging'
) }}

WITH NATION_CTE AS (
    SELECT * FROM {{ ref('NATION') }}
),
CUSTOMER_CTE AS (
    SELECT * FROM {{ref('CUSTOMER') }}
)

SELECT 
    *
FROM NATION_CTE n
JOIN CUSTOMER_CTE c ON  n.n_nationkey=c.c_nationkey
where c_acctbal > 0