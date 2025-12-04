{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='id',
        strategy='check',
        check_cols=['name', 'email']
    )
}}

select
    id,
    name,
    email,
    created_at
from {{ source('raw', 'customers_raw') }}

{% endsnapshot %}
