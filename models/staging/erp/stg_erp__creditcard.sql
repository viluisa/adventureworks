with

source as (
    select * from {{ source('erp', 'sales_creditcard') }}
),
renamed as (
    select
        cast(creditcardid as int) as creditcard_pk
        , cast(cardtype as string) as creditcard_type
    from source
)
select * from renamed