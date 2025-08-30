{{ config(
    materialized='view',
    schema='RAW'
) }}

SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.SUPPLIER
