with
    int_address as (
        select *
        from {{ ref("int_address__enriched")}}
    )
select *
from int_address