
with base as (

    select * 
    from {{ ref('stg_qualtrics__survey_embedded_data_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_qualtrics__survey_embedded_data_tmp')),
                staging_columns=get_survey_embedded_data_columns()
            )
        }}
    from base
),

final as (
    
    select 
        import_id,
        key,
        response_id,
        value,
        _fivetran_synced
    from fields
)

select *
from final
