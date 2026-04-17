{% snapshot walmart_snapshot %}
    {{
        config(
            target_schema="MART_DATA",
            target_database="WALMART_DB",
            unique_key="DATE_ID",
            strategy="timestamp",
            invalidate_hard_deletes=False,
            updated_at="UPDATE_DATE",
        )
    }}

    select *
    from {{ source("walmart_mart_source", "WALMART_FACT_TABLE") }}
{% endsnapshot %}

-- invalidate_hard_deletes: True: If a record is missing from the source during the
-- next snapshot run, dbt will "close" that record in your snapshot table. It sets the
-- dbt_valid_to timestamp to the current run time, marking the record as no longer
-- active.

-- invalidate_hard_deletes: False (Default): dbt ignores the deletion. The record
-- stays in your snapshot table with dbt_valid_to as NULL, making it look like the
-- record still exists in the source.

-- Important Note:invalidate_hard_deletes: 
-- This requires dbt to perform a "set difference" (scanning the snapshot against the
-- source), which can be performance-heavy on very large datasets.
-- Do you have a specific case where data is being purged from your RAW_DATA tables
-- and you need to track those deletions?

