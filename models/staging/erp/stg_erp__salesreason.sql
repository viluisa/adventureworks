with

source as (
    select * from {{ source('erp', 'sales_salesreason') }}
),
renamed as (
    select
        cast(salesreasonid as int) as salesreason_pk
        , cast(name as string) as salesreason_name
        , cast(reasontype as string) as salesreason_type
    from source
)
select * from renamed