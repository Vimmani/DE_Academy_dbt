{% macro grant_select (schema=target.schema,role=target.role) %}

   {% set sqlquery %}
    grant usage on schema {{ schema }} to role {{ role }};
    grant select on all tables in schema {{ schema }} to role {{ role }};
    grant select on all views in schema {{ schema }} to role {{ role }};
   {% endset %}
   -- This is how you add custom logs which you can verify in the debug after execution
   {{ log('Granting select on all tables and views in schema '~ target.schema ~ ' to role '~ role, info=true)}}
   {% do run_query(sqlquery) %}
   {{ log('Privs granted', info = ture)}}
    
{% endmacro %}