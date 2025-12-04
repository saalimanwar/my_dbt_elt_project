my_dbt_elt_project
==================
A complete end-to-end dbt ELT project built on Snowflake, covering data ingestion, staging, dimensional modeling, fact modeling, marts, custom macros, tests, snapshots (SCD-2), and historical tracking.

This project was created as part of a multi-assignment learning workflow.

Project Structure:

my_dbt_elt_project/
│
├── models/
│   ├── staging/ (stg_ models)
│   ├── marts/
│   │   ├── dim_customers.sql
│   │   ├── fct_orders.sql
│   │   ├── sales_summary.sql
│   └── schema.yml
│
├── snapshots/
│   └── customer_snapshot.sql
│
├── macros/
│   └── calc_growth.sql
│
├── seeds/
├── tests/
├── dbt_project.yml
└── README.md

Assignment Breakdown
=====================

Below is a summary of all tasks completed across the 4 assignments.

Assignment 1 — Build Staging Layer
Completed Tasks

Created staging models under models/staging/

Cleaned and transformed raw source tables

Applied column renaming + basic validations

Added source definitions (sources.yml)

Validated staging models with data tests

Files:
models/staging/stg_customers.sql
models/staging/stg_orders.sql
models/staging/stg_order_items.sql
models/staging/stg_products.sql
models/staging/stg_payments.sql

Assignment 2 — Fact & Dimension Models
Completed Tasks

Created dim_customers (dimension)

Created fct_orders (fact table)

Implemented joins, cleaning, ordering

Added not_null & unique tests in schema.yml

Files:
models/marts/dim_customers.sql
models/marts/fct_orders.sql
models/marts/schema.yml

Assignment 3 — Build Metrics & Aggregations
Completed Tasks

Built aggregated model: sales_summary

Implemented daily totals + customer level totals

Introduced a custom macro for % growth calculation
(daily amount vs previous day)

Files:
models/marts/sales_summary.sql
macros/calc_growth.sql

Assignment 4 — Snapshots + SCD Type-2 + Historical Tracking
Completed Tasks

Implemented dbt snapshot to track customer history

Used strategy = 'check' and check_cols = ['name', 'email']

Enabled SCD-2 changes with dbt snapshot

Demonstrated historical record tracking inside Snowflake warehouse

Files:
snapshots/customer_snapshot.sql

Custom Macro — % Growth Calculation

macros/calc_growth.sql

{% macro calc_growth(current, previous) %}
    case 
        when {{ previous }} = 0 or {{ previous }} is null then null
        else round((( {{ current }} - {{ previous }} ) / {{ previous }} ) * 100, 2)
    end
{% endmacro %}


Used inside sales_summary.sql:

{{ calc_growth('daily_amount', 'prev_day_amount') }} as daily_growth_pct

Testing
Included Tests

- not_null
- unique
- dbt_expectations tests
- source freshness tests
- integrity checks on all staging + fact + dimension models

Run tests using:

dbt test

Final output: PASS = 25/25

Snapshots (SCD-2)

Snapshot logic:

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


Run snapshot:

dbt snapshot

How to Run This Project

1) Install packages
dbt deps

2) Run models
dbt run

3) Run tests
dbt test

4) Run snapshots
dbt snapshot

Repository

GitHub Link:
https://github.com/saalimanwar/my_dbt_elt_project