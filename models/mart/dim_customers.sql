-- Use CTEs for easy reading and debugging
-- {{ config(materialized='table') }}

with customer as (
select
*
from {{ ref('stg_cust') }}
),

nation as (
select
*
from
{{ ref('stg_nation') }}
),

region as (
select
*
from
{{ ref('stg_region') }}
),
final as (
select
        customer.customer_id,
        customer.name,
        customer.address,
        nation.nation_id as nation_id,
        nation.name as nation,
        region.region_id as region_id,
        region.name as region,
        customer.phone_number,
        customer.account_balance,
        customer.market_segment 
        from customer
        inner join nation
            on customer.nation_id = nation.nation_id
        inner join region
            on nation.region_id = region.region_id

)
select * from final

    