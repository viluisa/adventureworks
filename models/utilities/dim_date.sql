with bounds as (

    select
        min(order_date) as date_start
        , max(order_date) as date_end
    from {{ ref('fact_sales') }}

),

calendar as (

    select
        dateadd(
            day
            , row_number() over(order by seq4()) - 1
            , date_start
        ) as date_day
        , date_start
        , date_end
    from bounds, table(generator(rowcount => 20000)) 
    qualify date_day <= date_end

),

final as (

    select
        to_char(date_day, 'YYYYMMDD')::int as date_key
        , date_day as full_date
        , year(date_day) as year
        , month(date_day) as month
        , lpad(month(date_day), 2, '0') as month_padded
        , to_char(date_day, 'Month') as month_name
        , day(date_day) as day
        , quarter(date_day) as quarter
        , dayofweek(date_day) as day_of_week
        , to_char(date_day, 'Day') as day_name
        , case when dayofweek(date_day) in (1,7) then true else false end as is_weekend
    from calendar

)

select *
from final
