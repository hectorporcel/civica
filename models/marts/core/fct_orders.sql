{{ config(materialized='table') }}

with orders as (

    select *
    from {{ ref('dim_orders') }}

),

addresses as (

    select *
    from {{ ref('dim_addresses') }}

),

users as (

    select *
    from {{ ref('dim_users') }}

),

final as (

    select
        orders.order_id,
        orders.user_id,
        orders.address_id,

        cast(orders.created_at as timestamp_ntz) as order_date,
        
        orders.status,
        addresses.country as address_country,

        try_cast(replace(orders.order_total::string, ',', '.') as number(18, 2)) as order_total,
        try_cast(replace(orders.order_cost::string, ',', '.') as number(18, 2)) as order_cost,
        try_cast(replace(orders.shipping_cost::string, ',', '.') as number(18, 2)) as shipping_cost

    from orders

    inner join addresses
        on orders.address_id = addresses.address_id

    inner join users
        on orders.user_id = users.user_id

)

select *
from final