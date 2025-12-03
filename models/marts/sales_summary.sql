{{ config(materialized='view') }}

select
  customer_id,
  sum(amount) as total_spent,
  count(order_id) as orders_count
from {{ ref('fct_orders') }}
group by customer_id
