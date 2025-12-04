WITH source AS (
    SELECT *
    FROM {{ source('raw', 'order_items_raw') }}
),

renamed AS (
    SELECT
        id AS order_item_id,
        order_id,
        product_id,
        quantity,
        price AS item_price
    FROM source
)

SELECT * FROM renamed