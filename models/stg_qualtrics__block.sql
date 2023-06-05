
with base as (

    select * 
    from {{ ref('stg_qualtrics__block_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_qualtrics__block_tmp')),
                staging_columns=get_block_columns()
            )
        }}
    from base
),

final as (
    
    select 
        block_locking as is_block_locked,
        block_visibility,
        description,
        id as block_id,
        randomize_questions,
        survey_id,
        type,
        _fivetran_deleted as is_deleted,
        _fivetran_synced

    from fields
)

select *
from final
