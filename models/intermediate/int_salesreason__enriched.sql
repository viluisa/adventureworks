with

salesreason as (
    select *
    from {{ ref('stg_erp__salesreason') }}
),

cleaned as (
    select
        salesreason_pk
        , salesreason_name
        , salesreason_type
    from salesreason
)

select *
from cleaned