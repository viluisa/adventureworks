with reasons as (
    select *
    from {{ ref('int_salesreason__enriched') }}
)

, bridge as (
    select
        dense_rank() over(order by order_fk) as sales_order_reason_sk
        , order_fk
        , listagg(salesreason_name, ', ') within group (order by salesreason_name) as salesreason_names
        , listagg(salesreason_type, ', ') within group (order by salesreason_type) as salesreason_types
    from reasons
    group by order_fk
)

select *
from bridge
