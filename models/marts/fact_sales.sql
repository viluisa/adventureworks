with int_sales as (
    select *
    from {{ ref('int_sales__enriched') }}
)

select
    orderdetail_pk          as sales_order_detail_sk
    , order_pk                as sales_order_id
    , customer_fk
    , product_fk
    , billtoaddress_fk        as billto_address_fk
    , shiptoaddress_fk        as shipto_address_fk
    , creditcard_fk
    , shipmethod_fk
    , order_date
    , status_order
    , case 
        when status_order = 1 then 'In Process'
        when status_order = 2 then 'Approved'
        when status_order = 3 then 'Backordered'
        when status_order = 4 then 'Rejected'
        when status_order = 5 then 'Shipped'
        when status_order = 6 then 'Cancelled'
        else 'Unknown'
    end as order_status_description
    , order_quantity          as order_qty
    , unit_price
    , gross_sales             as gross_amount
    , net_sales               as net_amount
    , gross_sales - net_sales as discount_amount
    , subtotal_amount
    , tax_amount
    , freight_amount
    , total_due
from int_sales