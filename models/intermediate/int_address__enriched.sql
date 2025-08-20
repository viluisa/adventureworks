with

address as (
    select *
    from {{ ref('stg_erp__address') }}
),

state as (
    select * 
    from {{ ref('stg_erp__stateprovince') }}
),

country as (
    select * 
    from {{ ref('stg_erp__countryregion') }}
),

joined as (
    select
        a.address_pk
        , a.address_name
        , a.city_name
        , sp.state_name
        , cr.country_pk
        , cr.country_name
    from address a
    left join state sp on a.state_fk = sp.state_pk
    left join country cr on sp.country_fk = cr.country_pk
)

select *
from joined