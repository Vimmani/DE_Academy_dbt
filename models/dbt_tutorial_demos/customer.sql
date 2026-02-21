-- Configuration for materilization (View or table or incrementa table etc..)
--ex: {{ config(materialized='table', sort='timestamp', dist='user_id') }}
{{ config(materialized = 'table') }}

with customer_src as 
(
    select
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE,
    COUNTRY,
    CREATED_AT,
    CURRENT_TIMESTAMP AS INSERT_DTS
    FROM {{source('customer','CUSTOMER_SRC')}} 
)
select * from customer_src