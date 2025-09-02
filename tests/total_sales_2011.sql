with
    sales_facts as (
        select * from {{ ref('fact_sales') }}
    )

    , sales_2011 as (
        select 
            round(sum(gross_amount), 2) as total_gross_sales_2011
        from sales_facts
        where extract(year from order_date) = 2011
    )

select *
from sales_2011
where total_gross_sales_2011 != 12646112.16