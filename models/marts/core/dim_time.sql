
with base_dates as (

    {{
        dbt.date_spine(
            datepart="day",
            start_date="cast('2020-01-01' as date)",
            end_date="current_date()"
        )
    }}

)

select date_day from base_dates