with annual_income_statement as (
    select * from {{ ref('annual_income_statement') }}
),

ttm_income as (
    select * from {{ ref('ttm_income_statement') }}
),

final as (
    select * from annual_income_statement
    union
    select * from ttm_income
)

select distinct * from final