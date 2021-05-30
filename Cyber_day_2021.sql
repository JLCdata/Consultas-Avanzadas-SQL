-- UNIQ_BUYER'S AND NEW_BUYER'S POR DÍA:

with tabla as (select cust_id, min(FIRST_BUY) as FIRST_BUY 
from 
((select ORD_BUYER.ID as cust_id,min(cast(ORD_CLOSED_DTTM as date)) as FIRST_BUY 
from `meli-bi-data.WHOWNER.BT_ORD_ORDERS`  
where sit_site_id = 'MLC' and ORD_GMV_FLG is true group by 1) union all 
(SELECT CUST_ID as cust_id, MIN_PURCHASE_DATE as FIRST_BUY  FROM `dev-mlc-546.BIA.MIN_PURCHASE_DATE_BEFORE_2017` where SITE_ID='MLC')) 
group by 1)

select case when CAST(ORD_CLOSED_DTTM AS DATE) BETWEEN '2020-08-31' and '2020-09-02' then 'CYBER_DAY_AGOST_2020'
 when CAST(ORD_CLOSED_DTTM AS DATE) BETWEEN '2020-11-02' and '2020-11-04'then 'CYBER_MONDAY_NOV_2020'
  when CAST(ORD_CLOSED_DTTM AS DATE) BETWEEN '2021-05-31' and '2021-06-02'then 'CYBER_2021' end as CYBER,
cast(ORD_CLOSED_DTTM as date) as FECHA, 
count(distinct(ORD_BUYER.ID)) as UNIQ_BUYERS,
count(distinct(case when tabla.FIRST_BUY=cast(ORD_CLOSED_DTTM as date)then O.ORD_BUYER.ID else null end)) as NEW_BUYERS 
from `meli-bi-data.WHOWNER.BT_ORD_ORDERS` as O left join tabla on tabla.cust_id=O.ORD_BUYER.ID

where ((cast(ORD_CLOSED_DTTM as date) between '2020-08-31' and '2020-09-02') or 
(cast(ORD_CLOSED_DTTM as date) between '2020-11-02' and '2020-11-04') or 
(cast(ORD_CLOSED_DTTM as date) between '2021-05-31' and '2021-06-02'))
and o.ORD_GMV_FLG is true and o.SIT_SITE_ID = 'MLC'  group by 1,2 order by FECHA;

-- UNIQ_BUYER'S AND NEW_BUYER'S TODO EL PERIODO:

with tabla as (select cust_id, min(FIRST_BUY) as FIRST_BUY 
from 
((select ORD_BUYER.ID as cust_id,min(cast(ORD_CLOSED_DTTM as date)) as FIRST_BUY 
from `meli-bi-data.WHOWNER.BT_ORD_ORDERS`  
where sit_site_id = 'MLC' and ORD_GMV_FLG is true group by 1) union all 
(SELECT CUST_ID as cust_id, MIN_PURCHASE_DATE as FIRST_BUY  FROM `dev-mlc-546.BIA.MIN_PURCHASE_DATE_BEFORE_2017` where SITE_ID='MLC')) 
group by 1)

select case when CAST(ORD_CLOSED_DTTM AS DATE) BETWEEN '2020-08-31' and '2020-09-02' then 'CYBER_DAY_AGOST_2020'
 when CAST(ORD_CLOSED_DTTM AS DATE) BETWEEN '2020-11-02' and '2020-11-04'then 'CYBER_MONDAY_NOV_2020'
  when CAST(ORD_CLOSED_DTTM AS DATE) BETWEEN '2021-05-31' and '2021-06-02'then 'CYBER_2021' end as CYBER, 
  count(distinct(ORD_BUYER.ID)) as UNIQ_BUYERS,
count(distinct(case when tabla.FIRST_BUY=cast(ORD_CLOSED_DTTM as date)then O.ORD_BUYER.ID else null end)) as NEW_BUYERS 
from `meli-bi-data.WHOWNER.BT_ORD_ORDERS` as O left join tabla on tabla.cust_id=O.ORD_BUYER.ID
where ((cast(ORD_CLOSED_DTTM as date) between '2020-08-31' and '2020-09-02') or 
(cast(ORD_CLOSED_DTTM as date) between '2020-11-02' and '2020-11-04') or 
(cast(ORD_CLOSED_DTTM as date) between '2021-05-31' and '2021-06-02')) and o.ORD_GMV_FLG is true and o.SIT_SITE_ID = 'MLC' group by 1
