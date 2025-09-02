with
salesorderheaderdetail as (
    select *
    from {{ ref('stg_erp__salesorderheaderdetail') }}
),
salesorderheader as (
    select *
    from {{ ref('stg_erp__salesorderheader') }}
),
joined as (
    select
        sd.orderdetail_pk
        , sh.order_pk
        , sh.customer_fk
        , sh.creditcard_fk
        , sd.product_fk
        , sh.status_order
        , sh.order_date
        , sh.shipmethod_fk
        , sh.billtoaddress_fk
        , sh.shiptoaddress_fk
        , sd.order_quantity
        , sd.unit_price
        , (sd.unit_price * sd.order_quantity) as gross_sales
        , (sd.unit_price * sd.order_quantity * (1 - sd.unit_price_discount)) as net_sales
        , sh.subtotal_amount
        , sh.tax_amount
        , sh.freight_amount
        , sh.total_due
    from salesorderheaderdetail sd
    left join salesorderheader sh 
        on sd.order_fk = sh.order_pk
)
select *
from joined