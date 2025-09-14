SELECT  order_id,
        sum(order_amount) as total_amount
FROM {{ ref('stg_stripe__payments') }}
GROUP BY 1
HAVING total_amount < 0