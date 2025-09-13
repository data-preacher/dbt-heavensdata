SELECT  orderid AS order_id, 
        amount AS order_amount

FROM dbt-tutorial.stripe.payment
WHERE status = 'success'
