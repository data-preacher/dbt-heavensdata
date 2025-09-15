with
    customer_orders AS (

        select
            customer_id,
            min(order_date) AS first_order_date,
            max(order_date) AS most_recent_order_date,
            count(order_id) AS number_of_orders

        from {{ ref("stg_jaffle_shop__orders") }} AS orders
        group BY customer_id

    ),

    customer_payments AS (
        select customer_id,
        sum(order_amount) as customer_lifetime_value
        
        from {{ ref("fct_orders") }} AS fct_orders
        group by customer_id
    )

select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.number_of_orders, 0) AS number_of_orders,
    coalesce(customer_lifetime_value, 0) AS lifetime_value

from {{ ref("stg_jaffle_shop__customers") }} as customers

LEFT JOIN customer_orders ON customers.customer_id = customer_orders.customer_id
LEFT JOIN customer_payments ON customers.customer_id = customer_payments.customer_id
