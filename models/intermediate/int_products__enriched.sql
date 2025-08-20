with

product as (
    select *
    from {{ ref('stg_erp__product') }}
),

subcategory as (
    select *
    from {{ ref('stg_erp__productsubcategory') }}
),

category as (
    select *
    from {{ ref('stg_erp__productcategory') }}
),

joined as (
    select
        p.product_pk
        , p.product_name
        , coalesce(c.category_name, 'No category') as category_name
        , coalesce(s.subcategory_name, 'No subcategory') as subcategory_name
    from product p
    left join subcategory s
        on p.product_subcategory_fk = s.subcategory_pk
    left join category c
        on s.category_fk = c.category_pk
    order by p.product_pk
)

select *
from joined