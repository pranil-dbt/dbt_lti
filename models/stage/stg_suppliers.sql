{{
    config(
        materialized='table'
    )
}}

select * from 
{{ source('src', 'suppliers') }} a inner join
{{ ref('supplier') }} b
on
a.S_SUPPKEY = b.SKEY