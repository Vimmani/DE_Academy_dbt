-- In dbt frame work there is default macro 'generate_schema_name'(google this macro for more info) that run when you specify the custom schema in dbt_project.yml file but when 
--assigning a name to schema it will assign someting like 'PUBLIC_CustomSchemaName' if you do not want that then we need to rewrite the same macro in our project ans below
{% macro generate_schema_name(custom_schema_name, node) -%}


    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}


        {{ default_schema }}


    {%- else -%}

        
        {{ custom_schema_name | trim }} 


    {%- endif -%}


{%- endmacro %} 