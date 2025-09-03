{{ config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key='id',
    database='RAW',
    schema='ECOMMERCE'
) }}


SELECT
    TXN_DATE,
    ID,
    STATUS,
    AMOUNT
FROM RAW.ECOMMERCE.DAILY_TRANSACTIONS

{% if is_incremental() %}
    -- IMPORTANT: filter uses MAX(txn_date) from the TARGET ({{ this }})
    WHERE TXN_DATE = (SELECT MAX(TXN_DATE) FROM {{ this }})
--WHERE TXN_DATE >= DATEADD(day, -3, (SELECT MAX(TXN_DATE) FROM {{ this }}))
{% endif %}