{{ config(
    materialized='incremental',
    unique_key='address_id',
    incremental_strategy='merge'
) }}

WITH source AS (

    SELECT * 
    FROM {{ source('POSTGRES','ADDRESSES') }}

    {% if is_incremental() %}
    WHERE _fivetran_synced > (SELECT MAX(_fivetran_synced) FROM {{ this }})
    {% endif %}

),

renamed_casted AS (

    SELECT
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        _fivetran_synced
    FROM source

)

SELECT * 
FROM renamed_casted