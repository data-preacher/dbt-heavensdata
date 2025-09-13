select  orders.order_id,
        orders.customer_id,
        payments.order_amount


FROM {{ ref("stg_jaffle_shop__orders") }} AS orders
    LEFT JOIN {{ ref("stg_stripe__payments") }} AS payments 
        ON orders.order_id = payments.order_id