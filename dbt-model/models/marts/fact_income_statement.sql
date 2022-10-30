with annual_income_statement as (
    select * from {{ ref('annual_income_statement') }}
),

ttm_income as (
    select * from {{ ref('ttm_income_statement') }}
),

final as (
    select
        *,
        EXTRACT(YEAR FROM date) as year
    from annual_income_statement
    union
    select
        * ,
        EXTRACT(YEAR FROM date) as year
    from ttm_income
)

select distinct * from final