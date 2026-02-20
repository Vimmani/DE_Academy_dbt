{{ config(materialized = 'view') }}

-- creating 'customer_vw' view by filtering the data from 'customer' table. so you can take the reference'ref(customer)' of customer model in to this customer_vw model as belwo

    Select * FROM {{ ref('customer') }} 
    Where COUNTRY = 'USA'
