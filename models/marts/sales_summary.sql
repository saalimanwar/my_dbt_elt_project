{{ config(materialized='view') }}

with summary as (
    select
        customer_id,
        sum(amount) as total_spent,
        count(order_id) as orders_count
    from {{ ref('fct_orders') }}
    group by customer_id
),

daily as (
    select
        order_date,
        sum(amount) as daily_amount,
        lag(sum(amount)) over(order by order_date) as prev_day_amount
    from {{ ref('fct_orders') }}
    group by order_date
)

select
    *,
    {{ calc_growth('daily_amount', 'prev_day_amount') }} as daily_growth_pct
from daily
