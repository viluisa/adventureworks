with

source as (
    select * from {{ source('erp', 'person_person')}}
)

, renamed as (
        select
            cast(businessentityid as int) as person_pk
            , cast(firstname as string) as first_name
            , cast(lastname as string) as last_name
            , cast(persontype as string ) as person_type
        from source
    )

select *
from renamed