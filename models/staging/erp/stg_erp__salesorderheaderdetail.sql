with source as (
    select * from {{ source('erp', 'sales_salesorderdetail') }}
)
, renamed as (
    select
        cast(salesorderdetailid as int)            as orderdetail_pk
        , cast(salesorderid as int)                as order_fk
        , cast(carriertrackingnumber as string)    as carrier_tracking_number
        , cast(orderqty as int)                    as order_quantity
        , cast(productid as int)                   as product_fk
        , cast(specialofferid as int)              as specialoffer_fk
        , cast(unitprice as numeric(19,4))         as unit_price
        , cast(unitpricediscount as numeric(19,4)) as unit_price_discount
        , cast(rowguid as string)                  as rowguid
        , cast(modifieddate as timestamp)          as modified_date
    from source
)

select *
from renamed