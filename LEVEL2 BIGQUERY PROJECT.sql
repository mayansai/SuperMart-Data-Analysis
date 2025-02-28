

------------LEVEL 2 bigquery project----with new customer-------------------------------------------------

----YDT- category based

select 
ph.category,
COUNT(DISTINCT od.order_id) as yday_orders,
sum(od.selling_price) as yday_GMV,
sum(od.selling_price)/1.18 as yday_revenue,
count(distinct od.product_id) as Yday_Live_Products,
count(distinct od.store_id) as yday_live_stores,
count(distinct new_table.customer_id) as Ynew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
Group by ph.category;

-----MTD category based- MTD (Month to date): where order_date between '2024-07-01' and '2024-07-20'

select 
ph.category,
COUNT(DISTINCT od.order_id) as MTD_orders,
sum(od.selling_price) as MTD_GMV,
sum(od.selling_price)/1.18 as MTD_revenue,
count(distinct od.product_id) as MTD_Live_Products,
count(distinct od.store_id) as MTD_live_stores,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
Group by ph.category;

-------- LM with new customer- LM (Last Month): where order_date between '2024-06-01' and '2024-06-30'
select 
PH.category,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1;


-----subcategory based- YTD--------------


select
ph.sub_category, 
ph.category,
COUNT(DISTINCT od.order_id) as yday_orders,
sum(od.selling_price) as yday_GMV,
sum(od.selling_price)/1.18 as yday_revenue,
count(distinct od.product_id) as Yday_Live_Products,
count(distinct od.store_id) as yday_live_stores,
count(distinct new_table.customer_id) as Ynew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
Group by 1,2;

-----subcategory based- MTD--------------


select 
ph.sub_category,
ph.category,
COUNT(DISTINCT od.order_id) as MTD_orders,
sum(od.selling_price) as MTD_GMV,
sum(od.selling_price)/1.18 as MTD_revenue,
count(distinct od.product_id) as MTD_Live_Products,
count(distinct od.store_id) as MTD_live_stores,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
Group by 1,2;

-----subcategory based- LM--------------

select 
ph.sub_category,
ph.category,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2;

-----------BRAND LEVEL- YTD--------------
select
ph.brand, 
ph.category,
COUNT(DISTINCT od.order_id) as yday_orders,
sum(od.selling_price) as yday_GMV,
sum(od.selling_price)/1.18 as yday_revenue,
count(distinct od.product_id) as Yday_Live_Products,
count(distinct od.store_id) as yday_live_stores,
count(distinct new_table.customer_id) as Ynew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
Group by 1,2;

------------BRAND LEVEL- MTD--------------


select 
ph.brand,
ph.category,
COUNT(DISTINCT od.order_id) as MTD_orders,
sum(od.selling_price) as MTD_GMV,
sum(od.selling_price)/1.18 as MTD_revenue,
count(distinct od.product_id) as MTD_Live_Products,
count(distinct od.store_id) as MTD_live_stores,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
Group by 1,2;

-------------------BRAND LEVEL- LM--------------

select 
ph.brand,
ph.category,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2;

----------product level------YTD--------------

select
ph.Product_id,
ph.product,
ph.brand, 
COUNT(DISTINCT od.order_id) as yday_orders,
sum(od.selling_price) as yday_GMV,
sum(od.selling_price)/1.18 as yday_revenue,
count(distinct od.product_id) as Yday_Live_Products,
count(distinct od.store_id) as yday_live_stores,
count(distinct new_table.customer_id) as Ynew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
Group by 1,2,3;

----------product level------MTD--------------

select 
ph.product_id,
ph.product,
ph.brand,
COUNT(DISTINCT od.order_id) as MTD_orders,
sum(od.selling_price) as MTD_GMV,
sum(od.selling_price)/1.18 as MTD_revenue,
count(distinct od.product_id) as MTD_Live_Products,
count(distinct od.store_id) as MTD_live_stores,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph on od.Product_id=ph.product_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
Group by 1,2,3;

----------product level------LM--------------

select 
ph.product_id,
ph.product,
ph.brand,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.product_hierarchy as PH on OD.product_id = PH.product_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2,3;

------store type level- ytd-----new customer

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as YTD_orders,
sum(OD.selling_price) as YTD_gmv,
sum(OD.selling_price)/1.18 as YTD_revenue,
count(distinct OD.customer_id) as YTD_customer,
count(distinct OD.product_id) as YTD_live_product,
count(distinct OD.store_id) as YTD_live_store,
count(distinct new_table.customer_id) as YTDnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
group by 1
order by 1 asc;

----storelevel- MTD---new customer

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
group by 1
order by 1 asc;

=======storelevel LM new customer=====

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1
order by 1 asc;

---------store_id and storetype level- YTD-------------------

select 
sc.store_id,
SC.storetype_id as storetype,
COUNT(DISTINCT od.order_id) as yday_orders,
sum(od.selling_price) as yday_GMV,
sum(od.selling_price)/1.18 as yday_revenue,
count(distinct od.product_id) as Yday_Live_Products,
count(distinct od.store_id) as yday_live_stores,
count(distinct new_table.customer_id) as Ynew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
group by 1,2
order by 1 asc;

---------store_id and storetype level- MTD-------------------

select 
SC.storetype_id as storetype,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
group by 1
order by 1 asc;

---------store_id and storetype level- LM-------------------

select 
sc.store_id,
SC.storetype_id as storetype,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2
order by 1 asc;

---------------state level----ytd-------------------

select 
sc.state,
COUNT(DISTINCT od.order_id) as yday_orders,
sum(od.selling_price) as yday_GMV,
sum(od.selling_price)/1.18 as yday_revenue,
count(distinct od.product_id) as Yday_Live_Products,
count(distinct od.store_id) as yday_live_stores,
count(distinct new_table.customer_id) as Ynew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
group by 1
order by 1 asc;

--------------state level----LTD------------------

select 
SC.state,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
group by 1
order by 1 asc) as MTD
ON YTD_MTD.state = MTD.state
group by 1;

--------------state level----LM----------------------

select 
sc.state,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1
order by 1 asc;



------------city and store level-----ytd--------------------

select 
SC.city,
sc.store_id,
COUNT(DISTINCT od.order_id) as yday_orders,
sum(od.selling_price) as yday_GMV,
sum(od.selling_price)/1.18 as yday_revenue,
count(distinct od.product_id) as Yday_Live_Products,
count(distinct od.store_id) as yday_live_stores,
count(distinct new_table.customer_id) as Ynew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date='2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date='2024-07-20'
group by 1,2
order by 1 asc;

--------------city and store level-----Ltd--------------------

select 
SC.city,
sc.store_id,
count(Distinct OD.order_id) as MTD_orders,
sum(OD.selling_price) as MTD_gmv,
sum(OD.selling_price)/1.18 as MTD_revenue,
count(distinct OD.customer_id) as MTD_customer,
count(distinct OD.product_id) as MTD_live_product,
count(distinct OD.store_id) as MTD_live_store,
count(distinct new_table.customer_id) as MTDnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
left join (select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-07-01' and '2024-07-20') as new_table
ON OD.order_id = new_table.order_id
where od.order_date between '2024-07-01' and '2024-07-20'
group by 1,2
order by 1 asc) as MTD
ON YTD_MTD.store_id = MTD.store_id
group by 1,2;

--------------city and store level-----LM--------------------

select 
SC.city,
sc.store_id,
count(Distinct OD.order_id) as LM_orders,
sum(OD.selling_price) as LM_gmv,
sum(OD.selling_price)/1.18 as LM_revenue,
count(distinct OD.customer_id) as LM_customer,
count(distinct OD.product_id) as LM_live_product,
count(distinct OD.store_id) as LM_live_store,
count(distinct Ntable.customer_id) as LMnew_customer
from project7sept.super_mart1.order_details as OD
join project7sept.super_mart1.store_cities as SC on OD.store_id = SC.store_id
LEFT JOIN(select
order_date,
order_id,
customer_id,
from(select
od.order_date,
od.order_id,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) as rn
from project7sept.super_mart1.order_details as od
)newc
where rn=1 and newc.order_date between '2024-06-01' and '2024-06-30') as Ntable
ON Ntable.customer_id = od.customer_id
where OD.order_date between '2024-06-01' and '2024-06-30'
group by 1,2
order by 1 asc;


----------------------------------FINISHED===== LEVEL 2 WITH NEW CUSTOMER=====----------------------------------
