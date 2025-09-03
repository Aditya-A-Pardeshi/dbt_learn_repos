{{ config(
    materialized='incremental',
    incremental_strategy='append',
    database='SOURCE_RAW',
    schema='LANDING'
) }}

SELECT
    TXN_ID,
    ACCOUNT_ID,
    TXN_DATE,
    TXN_TYPE,
    AMOUNT,
    CREATED_AT
FROM SOURCE_RAW.LANDING.BANK_TRANSACTIONS_RAW