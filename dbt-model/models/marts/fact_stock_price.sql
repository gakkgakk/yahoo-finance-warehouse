with stock_price as (
    select * from {{ ref('parsed_raw_price') }}
)

select * from stock_price