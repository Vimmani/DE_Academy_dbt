{% macro cents_to_dollars(column_name,decimials = 2) -%}

ROUND({{column_name}} / 100 ,{{decimials}})
    
{%- endmacro %}