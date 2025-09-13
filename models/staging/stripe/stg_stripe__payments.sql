SELECT  orderid AS order_id, 
        amount / 100 AS order_amount

FROM dbt-tutorial.stripe.payment
WHERE status = 'success'
