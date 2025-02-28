select*from project7sept.super_mart1.order_details;
select*from project7sept.super_mart1.product_hierarchy;
select*from project7sept.super_mart1.store_cities;

-------Yesterday: order_date='2024-07-20'----------
---Table 1: This table presents the status of Category Level Yesterday Orders behaviour:
select 
PH.category,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date = '2024-07-20'
group by PH.category
order by 6 asc;

-------Table 2: This table presents the status of Sub Category Level Yesterday Orders behaviour:
select 
PH.sub_category,
PH.category,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date = '2024-07-20'
group by 1,2
order by 7 asc;

------Table 3: This table presents the status of Sub Category Level Yesterday Orders behaviour:

select 
PH.brand,
PH.category,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date = '2024-07-20'
group by 1,2
order by 7 asc;

------Table 4: This table presents the status of Yesterday Top 20 Orders behaviour:

select 
PH.product_id,
PH.brand,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date = '2024-07-20'
group by 1,2
order by 1 asc
LIMIT 20;

---Table 5: This table presents the status of StoreType Level Behaviour

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date = '2024-07-20'
group by 1
order by 1 asc;

------Table 6: This table presents the status of Store Id Level Behaviour

select 
SC.store_id,
SC.storetype_id as storetype,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date = '2024-07-20'
group by 1,2
order by 1 asc;

-----Table 7: This table presents the status of State Level Behaviour

select 
SC.state,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date = '2024-07-20'
group by 1
order by 7 asc;

-----Table 8: This table presents the status of City and State Level Behaviour

select 
SC.city,
SC.state,
count(Distinct OD.order_id) as yday_orders,
sum(OD.selling_price) as yday_gmv,
sum(OD.selling_price)/1.18 as yday_revenue,
count(distinct OD.customer_id) as yday_customer,
count(distinct OD.product_id) as yday_live_product,
count(distinct OD.store_id) as yday_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date = '2024-07-20'
group by 1,2
order by 7 asc;

------MTD (Month to date): where order_date between '2024-07-01' and '2024-07-20'--

---Table 1: This table presents the status of Category Level Yesterday Orders behaviour:
select 
PH.category,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by PH.category
order by 6 asc;

-------Table 2: This table presents the status of Sub Category Level Yesterday Orders behaviour:
select 
PH.sub_category,
PH.category,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by 1,2
order by 7 asc;

------Table 3: This table presents the status of Sub Category Level Yesterday Orders behaviour:

select 
PH.brand,
PH.category,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by 1,2
order by 7 asc;

------Table 4: This table presents the status of Yesterday Top 20 Orders behaviour:

select 
PH.product_id,
PH.brand,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by 1,2
order by 1 asc
LIMIT 20;

---Table 5: This table presents the status of StoreType Level Behaviour

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by 1
order by 1 asc;

------Table 6: This table presents the status of Store Id Level Behaviour

select 
SC.store_id,
SC.storetype_id as storetype,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by 1,2
order by 1 asc;

-----Table 7: This table presents the status of State Level Behaviour

select 
SC.state,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by 1
order by 7 asc;

-----Table 8: This table presents the status of City and State Level Behaviour

select 
SC.city,
SC.state,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-07-01' and '2024-07-20'
group by 1,2
order by 7 asc;

-------LMTD (Last Month to date): where order_date between '2024-06-01' and '2024-06-20'----
---Table 1: This table presents the status of Category Level Yesterday Orders behaviour:
select 
PH.category,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by PH.category
order by 6 asc;

-------Table 2: This table presents the status of Sub Category Level Yesterday Orders behaviour:
select 
PH.sub_category,
PH.category,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by 1,2
order by 7 asc;

------Table 3: This table presents the status of Sub Category Level Yesterday Orders behaviour:

select 
PH.brand,
PH.category,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by 1,2
order by 7 asc;

------Table 4: This table presents the status of Yesterday Top 20 Orders behaviour:

select 
PH.product_id,
PH.brand,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by 1,2
order by 1 asc
LIMIT 20;

---Table 5: This table presents the status of StoreType Level Behaviour

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by 1
order by 1 asc;

------Table 6: This table presents the status of Store Id Level Behaviour

select 
SC.store_id,
SC.storetype_id as storetype,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by 1,2
order by 1 asc;

-----Table 7: This table presents the status of State Level Behaviour

select 
SC.state,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by 1
order by 7 asc;

-----Table 8: This table presents the status of City and State Level Behaviour

select 
SC.city,
SC.state,
count(Distinct OD.order_id) as LMTD_orders,
sum(OD.selling_price) as LMTD_gmv,
sum(OD.selling_price)/1.18 as LMTD_revenue,
count(distinct OD.customer_id) as LMTD_customer,
count(distinct OD.product_id) as LMTD_live_product,
count(distinct OD.store_id) as LMTD_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-20'
group by 1,2
order by 7 asc;

------LM (Last Month): where order_date between '2024-06-01' and '2024-06-30'---
---Table 1: This table presents the status of Category Level Yesterday Orders behaviour:
select 
PH.category,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1
order by 6 asc;

-------Table 2: This table presents the status of Sub Category Level Yesterday Orders behaviour:
select 
PH.sub_category,
PH.category,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2
order by 7 asc;

------Table 3: This table presents the status of Sub Category Level Yesterday Orders behaviour:

select 
PH.brand,
PH.category,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2
order by 7 asc;

------Table 4: This table presents the status of Yesterday Top 20 Orders behaviour:

select 
PH.product_id,
PH.brand,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2
order by 1 asc
LIMIT 20;

---Table 5: This table presents the status of StoreType Level Behaviour

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1
order by 1 asc;

------Table 6: This table presents the status of Store Id Level Behaviour

select 
SC.store_id,
SC.storetype_id as storetype,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2
order by 1 asc;

-----Table 7: This table presents the status of State Level Behaviour

select 
SC.state,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1
order by 7 asc;

-----Table 8: This table presents the status of City and State Level Behaviour

select 
SC.city,
SC.state,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2
order by 7 asc;







