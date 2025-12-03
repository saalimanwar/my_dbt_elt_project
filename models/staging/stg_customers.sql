{{ config(materialized='view') }}

select
  id as customer_id,
  initcap(name) as customer_name,
  lower(email) as email,
  date_trunc('day', created_at) as created_date
from {{ source('raw', 'customers_raw') }}
