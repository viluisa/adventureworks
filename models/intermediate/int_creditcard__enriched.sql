with

creditcard as (
    select *
    from {{ ref('stg_erp__creditcard') }}
),

cleaned as (
    select
        creditcard_pk
        , creditcard_type
    from creditcard
)

select *
from cleaned