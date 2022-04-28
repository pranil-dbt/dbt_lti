{{
    config(
        materialized='incremental'
    )
}}
with supplier as (
    select * from {{ ref('stg_suppliers') }}
    {% if is_incremental() %} 
    where updated_time > (select max(updated_time) from {{this}})
    {% endif %} 
),
nation as (
    select * from {{ ref('stg_nation') }}
),
region as (
    select * from {{ ref('stg_region') }}
),
final as (
    select 
        supplier.S_SUPPKEY,
        supplier.S_NAME,
        supplier.S_ADDRESS,
        nation.name as nation,
        region.name as region,
        supplier.S_PHONE,
        supplier.S_ACCTBAL,
        supplier.updated_time
    from
        supplier
    left join nation
            on supplier.S_NATIONKEY = nation.nation_id
    inner join region 
            on nation.region_id = region.region_id
)
select * from final