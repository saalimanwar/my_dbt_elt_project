# my_dbt_elt_project

A complete end-to-end **dbt ELT project** built on **Snowflake**, covering:

- Source ingestion  
- Staging models  
- Fact & dimension modeling  
- Data marts  
- Custom macros  
- Automated tests  
- Snapshots (SCD Type-2)  
- Historical tracking  

This project was developed as part of a multi-assignment learning workflow.

---

## 🚀 Project Structure

my_dbt_elt_project/
│
├── models/
│ ├── staging/
│ │ ├── stg_customers.sql
│ │ ├── stg_orders.sql
│ │ ├── stg_order_items.sql
│ │ ├── stg_products.sql
│ │ └── stg_payments.sql
│ │
│ ├── marts/
│ │ ├── dim_customers.sql
│ │ ├── fct_orders.sql
│ │ ├── sales_summary.sql
│ │ └── schema.yml
│
├── snapshots/
│ └── customer_snapshot.sql
│
├── macros/
│ └── calc_growth.sql
│
├── dbt_project.yml
└── README.md

yaml
Copy code

---

# 📚 **Assignment Breakdown**

## **Assignment 1 — Build Staging Layer**
### ✅ Completed Tasks
- Created staging models under `models/staging/`
- Cleaned & transformed raw source tables
- Applied column renaming and data type fixes
- Added `sources.yml` for raw sources
- Added tests: **not_null, unique, value checks**

### **Files**
models/staging/stg_customers.sql
models/staging/stg_orders.sql
models/staging/stg_order_items.sql
models/staging/stg_products.sql
models/staging/stg_payments.sql

yaml
Copy code

---

## **Assignment 2 — Dimension & Fact Models**
### ✅ Completed Tasks
- Built `dim_customers` (dimension)
- Built `fct_orders` (fact table)
- Implemented keys, cleaning, aggregations
- Added schema tests

### **Files**
models/marts/dim_customers.sql
models/marts/fct_orders.sql
models/marts/schema.yml

yaml
Copy code

---

## **Assignment 3 — Aggregations & Custom Macro**
### ✅ Completed Tasks
- Created aggregated model `sales_summary`
- Daily totals + customer-level metrics
- Window functions (LAG)
- Built & used custom macro for **% growth**

### **Macro**
macros/calc_growth.sql

markdown
Copy code

### **Used in**
models/marts/sales_summary.sql

yaml
Copy code

---

### 📌 **Custom Macro Example**
```sql
{% macro calc_growth(current, previous) %}
    case 
        when {{ previous }} = 0 or {{ previous }} is null then null
        else round((( {{ current }} - {{ previous }} ) / {{ previous }} ) * 100, 2)
    end
{% endmacro %}
Assignment 4 — Snapshots (SCD-2) & Historical Tracking
✅ Completed Tasks
Implemented SCD-2 snapshot on customers

Used check strategy for change detection

Tracks changes in:

name

email

Enabled historical tracking in Snowflake

Snapshot File
bash
Copy code
snapshots/customer_snapshot.sql
📌 Snapshot Definition
sql
Copy code
{% snapshot customer_snapshot %}

{{ config(
    target_schema='snapshots',
    unique_key='id',
    strategy='check',
    check_cols=['name', 'email']
) }}

select 
    id,
    name,
    email,
    created_at
from {{ source('raw', 'customers_raw') }}

{% endsnapshot %}
🧪 Testing Summary
Tests Implemented:
not_null

unique

dbt_expectations tests

Source freshness tests

Integrity checks across:

staging models

dimensions

fact tables

marts

Run Tests:
bash
Copy code
dbt test
Final Result:
ini
Copy code
PASS = 25 / 25 tests
▶️ How to Run This Project
1️⃣ Install dependencies
bash
Copy code
dbt deps
2️⃣ Run all models
bash
Copy code
dbt run
3️⃣ Run tests
bash
Copy code
dbt test
4️⃣ Run snapshots (SCD-2)
bash
Copy code
dbt snapshot
🗂️ Repository
GitHub: https://github.com/saalimanwar/my_dbt_elt_project