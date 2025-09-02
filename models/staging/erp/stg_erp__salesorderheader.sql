with 

source as (
    select * from {{ source('erp', 'sales_salesorderheader') }}
)
, renamed as (
    select
        cast(salesorderid as int)               as order_pk
        , cast(orderdate as date)               as order_date
        , cast(customerid as int)               as customer_fk
        , cast(billtoaddressid as int)          as billtoaddress_fk
        , cast(shiptoaddressid as int)          as shiptoaddress_fk
        , cast(shipmethodid as int)             as shipmethod_fk
        , cast(creditcardid as int)             as creditcard_fk
        , cast(creditcardapprovalcode as string) as creditcard_approval_code
        , cast(currencyrateid as int)           as currencyrate_fk
        , cast(status as int)                   as status_order
        , cast(subtotal as numeric)             as subtotal_amount
        , cast(taxamt as numeric)               as tax_amount
        , cast(freight as numeric)              as freight_amount
        , cast(totaldue as numeric)             as total_due
        , cast(comment as string)               as order_comment
        , cast(rowguid as string)               as rowguid
        , cast(modifieddate as timestamp)       as modified_date
    from source
)

select *
from renamed