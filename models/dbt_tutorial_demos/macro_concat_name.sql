{{ 
    config(
        materialized = 'table'
    )
 }}

-- Select Concat('John','Smith') as name - This is concating with the model 

select {{ concat_macro('John','Smith') }} as name -- This is concating by calling a macro with in model