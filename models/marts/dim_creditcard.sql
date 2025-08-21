with
    int_creditcard as (
        select *
        from {{ ref("int_creditcard__enriched")}}
    )
select *
from int_creditcard