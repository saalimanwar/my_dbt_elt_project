{{ config(materialized='table') }}

with customer_sales as (
    select
        customer_id,
        sum(amount) as total_amount,
        lag(sum(amount)) over (order by customer_id) as prev_amount
    from {{ ref('fct_orders') }}
    group by customer_id
)

select
    customer_id,
    total_amount,
    prev_amount,
    {{ calc_growth('total_amount', 'prev_amount') }} as growth_pct
from customer_sales
