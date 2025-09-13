SELECT  orderid AS order_id, 
        amount / 100 AS order_amount

from {{ source('stripe', 'payment') }}
WHERE status = 'success'
