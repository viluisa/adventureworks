with int_sales as (
    select *
    from {{ ref('int_sales__enriched') }}
),

reason as (
    select *
    from {{ ref('dim_salesreason') }}
),

creditcard as (
    select *
    from {{ ref('dim_creditcard') }}
),

product as (
    select *
    from {{ ref('dim_products') }}
),

address as (
    select *
    from {{ ref('dim_address') }}
),

customer as (
    select *
    from {{ ref('dim_customers') }}
)

select
    -- surrogate key da fato
    s.orderdetail_pk              as sales_order_detail_sk

    -- chaves de negócio
    , s.order_pk                  as sales_order_id

    -- dimensões (FKs)
    , s.customer_fk               as customer_sk
    , s.product_fk                as product_sk
    , s.shiptoaddress_fk          as address_sk
    , coalesce(s.creditcard_fk, '-1')    as creditcard_sk
    , coalesce(c.creditcard_type, 'Not informed')  as creditcard_type
    , coalesce(r.sales_order_id, '-1')   as sales_reason_sk
    , coalesce(r.sales_reason_names, 'Not informed') as sales_reason_name

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
left join creditcard c
    on s.creditcard_fk = c.creditcard_pk
left join product p
    on s.product_fk = p.product_pk
left join address a
    on s.shiptoaddress_fk = a.address_pk
left join customer cu
    on s.customer_fk = cu.customer_pk
