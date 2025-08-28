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
        r.reason_pk,
        r.reason_name,
        r.reason_type
    from order_reason orr
    left join reason r
        on orr.reason_fk = r.reason_pk
)

select *
from joined