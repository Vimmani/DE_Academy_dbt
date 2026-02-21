{{ 
    config(
        materialized = 'table'
    )
 }}

-- Select Concat('123Street','Chicago') as address - This is concating with the model 
Select {{ concat_macro('123Street','Chicago') }} as address -- This is concating by calling a macro with in model