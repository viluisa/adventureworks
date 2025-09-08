with int_sales as (
    select *
    from {{ ref('int_sales__enriched') }}
)

, reason as (
    select *
    from {{ ref('int_salesreason__enriched') }}
)

select
    -- surrogate key da fato
    s.orderdetail_pk              as sales_order_detail_sk

    -- chaves de negócio
    , s.order_pk                  as sales_order_id

    -- dimensões
    , s.customer_fk                as customer_sk
    , s.product_fk                 as product_sk
    , s.shiptoaddress_fk           as address_sk
    , s.creditcard_fk              as creditcard_sk
    , s.shipmethod_fk              as shipmethod_sk
    , r.sales_order_id             as sales_reason_sk

    -- datas
    , s.order_date
    , to_char(s.order_date, 'YYYYMMDD')::int as order_date_key

    -- atributos do pedido
    , s.status_order
    , case 
        when s.status_order = 1 then 'In Process'
        when s.status_order = 2 then 'Approved'
        when s.status_order = 3 then 'Backordered'
        when s.status_order = 4 then 'Rejected'
        when s.status_order = 5 then 'Shipped'
        when s.status_order = 6 then 'Cancelled'
        else 'Unknown'
      end as order_status_description

    -- métricas
    , s.order_quantity             as order_qty
    , s.unit_price
    , s.gross_sales                as gross_amount
    , s.net_sales                  as net_amount
    , s.gross_sales - s.net_sales  as discount_amount
    , s.subtotal_amount
    , s.tax_amount
    , s.freight_amount
    , s.total_due

from int_sales s
left join reason r
    on s.order_pk = r.sales_order_id
