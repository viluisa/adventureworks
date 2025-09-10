with
    order_reason as (
        select *
        from {{ ref('stg_erp__salesorderheadersalesreason') }}
    )

    , reason as (
        select *
        from {{ ref('stg_erp__salesreason') }}
    )

    , joined_data as (
        select
            order_reason.order_fk as sales_order_id
            , listagg(distinct reason.salesreason_pk, ', ') within group (order by reason.salesreason_pk) as sales_reason_id
            , listagg(distinct reason.salesreason_name, ', ') within group (order by reason.salesreason_name) as sales_reason_names
        from order_reason
        inner join reason
            on order_reason.reason_fk = reason.salesreason_pk
        group by order_reason.order_fk
    )

    , final_joined_data as (
        select 
            sales_order_id
            , sales_reason_id
            , sales_reason_names
        from joined_data
        group by all
    )

    , not_informed_line as (
        select 
            '-1' as sales_order_id
            , '-1' as sales_reason_id
            , 'Not informed' as sales_reason_names
    )

    , union_table as (
        select * from final_joined_data
        union all
        select * from not_informed_line
    )

select *
from union_table
