{{ config(materialized='table') }}

select
  order_id,
  customer_id,
  amount,
  order_date
from {{ ref('stg_orders') }}
