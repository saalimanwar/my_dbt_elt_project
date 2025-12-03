{{ config(materialized='view') }}

select
  id as order_id,
  customer_id,
  amount,
  date_trunc('day', order_ts) as order_date
from {{ source('raw', 'orders_raw') }}
