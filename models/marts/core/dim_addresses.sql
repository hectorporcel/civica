with addresses as (select
    *
from {{ ref('stg_POSTGRES__ADDRESSES') }}
)

select * from addresses