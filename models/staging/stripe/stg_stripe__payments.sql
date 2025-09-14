SELECT  id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount / 100 AS order_amount

from {{ source('stripe', 'payment') }}
WHERE status = 'success'
