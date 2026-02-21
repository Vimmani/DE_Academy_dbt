
{{
    config(
        materialized = 'table'
    )
}}

with clean_orders as 
(
    Select
    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CREATED_AT,
    current_timestamp() As INSERT_DTS
    from {{ ref('clean_orders') }}
)
select * from clean_orders

--  How to get the ref('clean_orders'): Right click on the file that you want to get the reference from and select 'Copy AS Ref' and paste it at the from tag as above.