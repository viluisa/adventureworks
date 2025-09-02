with

order_reason as (
    select *
    from {{ ref('stg_erp__salesorderheadersalesreason') }}
),

reason as (
    select *
    from {{ ref('stg_erp__salesreason') }}
),

joined as (
    select
        orr.order_fk,
        , r.salesreason_pk
        , r.salesreason_name
        , r.salesreason_type
    from order_reason orr
    left join reason r
        on orr.reason_fk = r.salesreason_pk
)

select *
from joined