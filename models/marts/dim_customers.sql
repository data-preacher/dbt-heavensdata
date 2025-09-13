
{{ config(materialized='table') }}

with customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from {{ ref('stg_jaffle_shop__orders') }} AS orders
    
    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) AS number_of_orders

    from {{ ref('stg_jaffle_shop__customers') }} AS customers

    left join customer_orders 
        ON customers.customer_id = customer_orders.customer_id

)

select * from final