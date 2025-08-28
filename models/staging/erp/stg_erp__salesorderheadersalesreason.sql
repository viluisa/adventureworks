with 
source as (
    select * from {{ source('erp', 'sales_salesorderheadersalesreason') }}
)
, renamed as (
    select
        cast(salesorderid as int)    as order_fk
        , cast(salesreasonid as int) as reason_fk
    from source
)

select *
from renamed