{{
    config(
        materialized='view',
        database='WALMART_DB',
        schema='MART_DATA'
    )
}}

SELECT 
    DATE_ID,
    STORE_ID,
    DEPT_ID,
    STORE_SIZE,
    STORE_TYPE,
    DATE,
    ISHOLIDAY,
    WEEKLY_SALES,
    FUEL_PRICE,
    TEMPERATURE,
    UNEMPLOYMENT,
    CPI,
    MARKDOWN1,
    MARKDOWN2,
    MARKDOWN3,
    MARKDOWN4,
    MARKDOWN5,
    INSERT_DATE,
    UPDATE_DATE

FROM {{ ref('walmart_snapshot') }}