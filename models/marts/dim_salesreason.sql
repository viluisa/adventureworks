with
    int_salesreason as (
        select *
        from {{ ref("int_salesreason__enriched")}}
    )
select *
from int_salesreason