-- The Ephemeral model desn't create drectly in to databse or dataware house , but you can access this ephemeral model in to other models as CTE function.
{{
    config(
        materialized = 'ephemeral' 
    )
}}

with BASE_ORDERS as 
(
    Select
    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    case when CUSTOMER_NAME is null then 'NA' else upper(CUSTOMER_NAME) end as CUSTOMER_NAME,
    CREATED_AT
    from {{source('XYZ','BASE_ORDERS')}}
    where ORDER_DATE is not null 
)
select * from BASE_ORDERS

-- Notes: Since it is an Ephemeral model it will not get created on the database so we create another model called 'final_orders' and get the reference of ephemeral model 'clean_orders' to 'final_orders'