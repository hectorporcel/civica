with ORDERS as (select
    *
from {{ ref('stg_POSTGRES__ORDERS') }}
)

select * from ORDERS