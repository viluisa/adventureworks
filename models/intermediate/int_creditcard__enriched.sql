with creditcard as (
    select *
    from {{ ref('stg_erp__creditcard') }}
),

cleaned as (
    select
        creditcard_pk
        , creditcard_type
    from creditcard
),

default_row as (
    select
        -1 as creditcard_pk,
        'Not informed' as creditcard_type
)

select *
from cleaned

union all

select *
from default_row
