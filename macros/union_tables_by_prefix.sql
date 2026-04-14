{%- macro union_tables_by_prefix(database, schema, prefix) -%}

  {%- set tables = dbt_utils.get_relations_by_prefix(database=database, schema=schema, prefix=prefix) -%}

  {% for table in tables %}

      {%- if not loop.first -%}
      union all 
      {%- endif %}
        
      select * from {{ table.database }}.{{ table.schema }}.{{ table.name }}

      {{ log('We used this' ~table.name~ 'to union')}}
      
  {% endfor -%}
  
{%- endmacro -%}
union_tables_by_orders_prefix model code:
