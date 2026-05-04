with users as (select
    *
from {{ ref('stg_POSTGRES__USER') }}
)

select * from users