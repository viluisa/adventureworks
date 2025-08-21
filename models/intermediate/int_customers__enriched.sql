with

customer as (
    select *
    from {{ ref('stg_erp__customer') }}
),

person as (
    select *
    from {{ ref('stg_erp__person') }}
),

store as (
    select *
    from {{ ref('stg_erp__store') }}
),

joined as (
    select
        c.customer_pk,
        case
            when p.first_name is not null or p.last_name is not null
                then p.first_name || ' ' || p.last_name
            else s.store_name
        end as customer_name,
        case
            when p.person_pk is not null then 'PF'
            when s.store_pk is not null then 'PJ'
            else 'Desconhecido'
        end as customer_type
    from customer c
    left join person p on c.person_fk = p.person_pk
    left join store s on c.store_fk = s.store_pk
)

select *
from joined