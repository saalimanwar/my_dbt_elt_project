WITH source AS (
    SELECT *
    FROM {{ source('raw', 'payments_raw') }}
),

renamed AS (
    SELECT
        id AS payment_id,
        order_id,
        amount AS payment_amount,
        method AS payment_method,
        paid_at
    FROM source
)

SELECT * FROM renamed