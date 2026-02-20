-- Creating a sales model as Incremental append table
{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'append'
    )
}}

with sales_src as 
(
    select
    SALE_ID,
    SALE_DATE,
    CUSTOMER_ID,
    PRODUCT_ID,
    QUANTITY,
    TOTAL_AMOUNT,
    CREATED_AT,
    CURRENT_TIMESTAMP AS INSERT_DTS
    from {{source('sales','SALES_SRC')}}

-- Specifying dbt that on what column and condition the incremental append of records should be happening
-- 'this' represents the current model that is 'sales'
    {% if is_incremental() %}
    where CREATED_AT > (Select MAX(INSERT_DTS) from {{this}})
    {% endif %}
)
select * from sales_src