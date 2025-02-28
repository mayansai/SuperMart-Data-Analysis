
-------------------Table 1: This table presents the status of category level view----------------------------
select
x.category,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customer as Yday_Customers,
round((x.t1_customer-x.t2_customer)/nullif(x.t2_customer,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomer as Yday_New_Customers,
round((x.t1_newcustomer-x.t2_newcustomer)/nullif(x.t2_newcustomer,0)*100,1) as Yday_New_Customers_Growth,
x.t1_live_product as Yday_Live_Products,
x.t1_live_store as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customer as MTD_Customers,
round((x.mtd_customer-x.lmtd_customer)/nullif(x.lmtd_customer,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomer as MTD_New_Customers,
round((x.mtd_newcustomer-x.lmtd_newcustomer)/nullif(x.lmtd_newcustomer,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_live_product as MTD_Live_Products,
x.lmtd_live_store as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customer as LM_Customers,
x.lm_newcustomer as LM_New_Customers,
x.lm_live_product as LM_Live_Products,
x.lm_live_store as LM_Live_Stores
from
(select 
x.category,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.order_id end),0) as t1_orders,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.order_id end),0) as t2_orders,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price end),0) as t1_gmv,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price end),0) as t2_gmv,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price/1.18 end),0) as t1_revenue,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price/1.18 end),0) as t2_revenue,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.customer_id end),0) as t1_customer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.customer_id end),0) as t2_customer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.new_customer_id end),0) as t1_newcustomer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.new_customer_id end),0) as t2_newcustomer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.product_id end),0) as t1_live_product,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.store_id end),0) as t1_live_store,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.order_id end),0) as mtd_orders,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.order_id end),0) as lmtd_orders,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price end),0) as mtd_gmv,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14'then x.selling_price end),0) as lmtd_gmv,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price/1.18 end),0)as mtd_revenue,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14' then x.selling_price/1.18 end),0) as lmtd_revenue,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.customer_id end),0) as mtd_customer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.customer_id end),0) as lmtd_customer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.new_customer_id end),0) as mtd_newcustomer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.new_customer_id end),0) as lmtd_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.product_id end),0) as mtd_live_product,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.store_id end),0) as lmtd_live_store,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0) as lm_live_product,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_live_store

from
(select
od.product_id,
od.customer_id,
od.order_date,
od.selling_price,
od.store_id,
od.order_id,
ph.brand,
ph.category,
ph.sub_category,
ph.product,
nc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph
on od.product_id= ph.product_id
left join (select *
from (select 
od.order_id,
od.order_date,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) RN
from project7sept.super_mart1.order_details as od) as nc
where rn = 1)nc
on od.order_id=nc.order_id) x 
group by 1) x;

------Table 2: This table presents the status of Sub Category and Category Level View-------
select
x.sub_category,
x.category,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customer as Yday_Customers,
round((x.t1_customer-x.t2_customer)/nullif(x.t2_customer,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomer as Yday_New_Customers,
round((x.t1_newcustomer-x.t2_newcustomer)/nullif(x.t2_newcustomer,0)*100,1) as Yday_New_Customers_Growth,
x.t1_live_product as Yday_Live_Products,
x.t1_live_store as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customer as MTD_Customers,
round((x.mtd_customer-x.lmtd_customer)/nullif(x.lmtd_customer,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomer as MTD_New_Customers,
round((x.mtd_newcustomer-x.lmtd_newcustomer)/nullif(x.lmtd_newcustomer,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_live_product as MTD_Live_Products,
x.lmtd_live_store as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customer as LM_Customers,
x.lm_newcustomer as LM_New_Customers,
x.lm_live_product as LM_Live_Products,
x.lm_live_store as LM_Live_Stores
from
(select 
X.sub_category,
x.category,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.order_id end),0) as t1_orders,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.order_id end),0) as t2_orders,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price end),0) as t1_gmv,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price end),0) as t2_gmv,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price/1.18 end),0) as t1_revenue,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price/1.18 end),0) as t2_revenue,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.customer_id end),0) as t1_customer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.customer_id end),0) as t2_customer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.new_customer_id end),0) as t1_newcustomer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.new_customer_id end),0) as t2_newcustomer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.product_id end),0) as t1_live_product,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.store_id end),0) as t1_live_store,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.order_id end),0) as mtd_orders,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.order_id end),0) as lmtd_orders,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price end),0) as mtd_gmv,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14'then x.selling_price end),0) as lmtd_gmv,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price/1.18 end),0)as mtd_revenue,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14' then x.selling_price/1.18 end),0) as lmtd_revenue,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.customer_id end),0) as mtd_customer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.customer_id end),0) as lmtd_customer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.new_customer_id end),0) as mtd_newcustomer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.new_customer_id end),0) as lmtd_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.product_id end),0) as mtd_live_product,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.store_id end),0) as lmtd_live_store,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0) as lm_live_product,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_live_store

from
(select
od.product_id,
od.customer_id,
od.order_date,
od.selling_price,
od.store_id,
od.order_id,
ph.brand,
ph.category,
ph.sub_category,
ph.product,
nc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph
on od.product_id= ph.product_id
left join (select *
from (select 
od.order_id,
od.order_date,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) RN
from project7sept.super_mart1.order_details as od) as nc
where rn = 1)nc
on od.order_id=nc.order_id) x 
group by 1,2) x;

-------------Table 3: This table presents the status of Top 30 Brand Level View by MTD Orders------------------------
select
x.brand,
x.category,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customer as Yday_Customers,
round((x.t1_customer-x.t2_customer)/nullif(x.t2_customer,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomer as Yday_New_Customers,
round((x.t1_newcustomer-x.t2_newcustomer)/nullif(x.t2_newcustomer,0)*100,1) as Yday_New_Customers_Growth,
x.t1_live_product as Yday_Live_Products,
x.t1_live_store as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customer as MTD_Customers,
round((x.mtd_customer-x.lmtd_customer)/nullif(x.lmtd_customer,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomer as MTD_New_Customers,
round((x.mtd_newcustomer-x.lmtd_newcustomer)/nullif(x.lmtd_newcustomer,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_live_product as MTD_Live_Products,
x.lmtd_live_store as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customer as LM_Customers,
x.lm_newcustomer as LM_New_Customers,
x.lm_live_product as LM_Live_Products,
x.lm_live_store as LM_Live_Stores
from
(select 
x.brand,
x.category,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.order_id end),0) as t1_orders,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.order_id end),0) as t2_orders,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price end),0) as t1_gmv,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price end),0) as t2_gmv,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price/1.18 end),0) as t1_revenue,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price/1.18 end),0) as t2_revenue,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.customer_id end),0) as t1_customer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.customer_id end),0) as t2_customer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.new_customer_id end),0) as t1_newcustomer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.new_customer_id end),0) as t2_newcustomer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.product_id end),0) as t1_live_product,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.store_id end),0) as t1_live_store,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.order_id end),0) as mtd_orders,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.order_id end),0) as lmtd_orders,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price end),0) as mtd_gmv,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14'then x.selling_price end),0) as lmtd_gmv,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price/1.18 end),0)as mtd_revenue,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14' then x.selling_price/1.18 end),0) as lmtd_revenue,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.customer_id end),0) as mtd_customer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.customer_id end),0) as lmtd_customer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.new_customer_id end),0) as mtd_newcustomer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.new_customer_id end),0) as lmtd_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.product_id end),0) as mtd_live_product,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.store_id end),0) as lmtd_live_store,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0) as lm_live_product,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_live_store

from
(select
od.product_id,
od.customer_id,
od.order_date,
od.selling_price,
od.store_id,
od.order_id,
ph.brand,
ph.category,
ph.sub_category,
ph.product,
nc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph
on od.product_id= ph.product_id
left join (select *
from (select 
od.order_id,
od.order_date,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) RN
from project7sept.super_mart1.order_details as od) as nc
where rn = 1)nc
on od.order_id=nc.order_id) x 
group by 1) x
order by MTD_Orders asc
limit 30;

--------------Table 4: This table presents the status of Top 50 Product Level View by MTD Orders-------------

select
x.product_id,
x.product,
x.brand,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customer as Yday_Customers,
round((x.t1_customer-x.t2_customer)/nullif(x.t2_customer,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomer as Yday_New_Customers,
round((x.t1_newcustomer-x.t2_newcustomer)/nullif(x.t2_newcustomer,0)*100,1) as Yday_New_Customers_Growth,
x.t1_live_product as Yday_Live_Products,
x.t1_live_store as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customer as MTD_Customers,
round((x.mtd_customer-x.lmtd_customer)/nullif(x.lmtd_customer,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomer as MTD_New_Customers,
round((x.mtd_newcustomer-x.lmtd_newcustomer)/nullif(x.lmtd_newcustomer,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_live_product as MTD_Live_Products,
x.lmtd_live_store as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customer as LM_Customers,
x.lm_newcustomer as LM_New_Customers,
x.lm_live_product as LM_Live_Products,
x.lm_live_store as LM_Live_Stores
from
(select 
x.product_id,
x.product,
x.brand,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.order_id end),0) as t1_orders,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.order_id end),0) as t2_orders,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price end),0) as t1_gmv,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price end),0) as t2_gmv,

COALESCE (sum(case when x.order_date = '2024-09-14' then x.selling_price/1.18 end),0) as t1_revenue,
COALESCE (sum(case when x.order_date = '2024-09-13' then x.selling_price/1.18 end),0) as t2_revenue,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.customer_id end),0) as t1_customer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.customer_id end),0) as t2_customer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.new_customer_id end),0) as t1_newcustomer,
COALESCE (count(distinct case when x.order_date = '2024-09-13' then x.new_customer_id end),0) as t2_newcustomer,

COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.product_id end),0) as t1_live_product,
COALESCE (count(distinct case when x.order_date = '2024-09-14' then x.store_id end),0) as t1_live_store,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.order_id end),0) as mtd_orders,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.order_id end),0) as lmtd_orders,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price end),0) as mtd_gmv,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14'then x.selling_price end),0) as lmtd_gmv,

COALESCE (sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price/1.18 end),0)as mtd_revenue,
COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-14' then x.selling_price/1.18 end),0) as lmtd_revenue,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.customer_id end),0) as mtd_customer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.customer_id end),0) as lmtd_customer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.new_customer_id end),0) as mtd_newcustomer,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.new_customer_id end),0) as lmtd_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.product_id end),0) as mtd_live_product,
COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.store_id end),0) as lmtd_live_store,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,

COALESCE (sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomer,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0) as lm_live_product,

COALESCE (count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_live_store

from
(select
od.product_id,
od.customer_id,
od.order_date,
od.selling_price,
od.store_id,
od.order_id,
ph.brand,
ph.category,
ph.sub_category,
ph.product,
nc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.product_hierarchy as ph
on od.product_id= ph.product_id
left join (select *
from (select 
od.order_id,
od.order_date,
od.customer_id,
rank() over (partition by od.customer_id order by od.order_date asc) RN
from project7sept.super_mart1.order_details as od) as nc
where rn = 1)nc
on od.order_id=nc.order_id) x 
group by 1,2) x
order by MTD_Orders asc
limit 50;

---------------Table 5: This table presents the status of StoreType Level View-----------------------

select
x.storetype_id,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customers as Yday_Customers,
round((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomers as Yday_New_Customers,
round((x.t1_newcustomers-x.t2_newcustomers)/nullif(x.t2_newcustomers,0)*100,1) as Yday_New_Customers_Growth,
x.t1_liveproducts as Yday_Live_Products,
x.t2_livestores as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customers as MTD_Customers,
round((x.mtd_customers-x.lmtd_customers)/nullif(x.lmtd_customers,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomers as MTD_New_Customers,
round((x.mtd_newcustomers-x.lmtd_newcustomers)/nullif(x.lmtd_newcustomers,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_liveproducts as MTD_Live_Products,
x.lmtd_livestores as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customers as LM_Customers,
x.lm_newcustomers as LM_New_Customers,
x.lm_products as LM_Live_Products,
x.lm_stores as LM_Live_Stores
from
(select 
x.storetype_id,
coalesce(count(case when x.order_date= '2024-09-16' then x.order_id end),0) as t1_orders,
coalesce(count(case when x.order_date= '2024-09-15' then x.order_id end),0) as t2_orders,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price end),0) as t1_gmv,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price end),0) as t2_gmv,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price/1.18 end),0) as t1_revenue,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price/1.18 end),0) as t2_revenue,
coalesce(count(case when x.order_date= '2024-09-16' then x.customer_id end),0) as t1_customers,
coalesce(count(case when x.order_date= '2024-09-15' then x.customer_id end),0) as t2_customers,
coalesce(count(case when x.order_date= '2024-09-16' then x.new_customer_id end),0)  as t1_newcustomers,
coalesce(count(case when x.order_date= '2024-09-15' then x.new_customer_id end),0)  as t2_newcustomers,
coalesce(count(case when x.order_date= '2024-09-16' then x.product_id end),0) as t1_liveproducts,
coalesce(count(case when x.order_date= '2024-09-15' then x.store_id end),0) as t2_livestores,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.order_id end),0) as mtd_orders,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.order_id end),0) as lmtd_orders,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price end),0) as mtd_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price end),0) as lmtd_gmv,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price/1.18 end),0) as mtd_revenue,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price/1.18 end),0) as lmtd_revenue,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.customer_id end),0) as mtd_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.customer_id end),0) as lmtd_customers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.new_customer_id end),0) as mtd_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.new_customer_id end),0) as lmtd_newcustomers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.product_id end),0) as mtd_liveproducts,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.store_id end),0) as lmtd_livestores,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0)  as lm_products,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_stores
from (select
od.order_id,
od.customer_id,
od.order_date,
od.product_id,
od.store_id,
od.selling_price,
sc.storetype_id,
sc.store_szie,
sc.state,
sc.city,
newc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.store_cities as sc
on od.store_id = sc.store_id
left join(select
od.order_id,
od.customer_id,
od.order_date,
rank() over (partition by od.customer_id order by od.order_date) as rnk
from project7sept.super_mart1.order_details as od) newc
on newc.order_id = od.order_id
where rnk=1) as x
group by 1) as x;

--------Table 6: This table presents the status of Top 50 Store_Id Level View by MTD Orders-------

select
x.store_id,
x.storetype_id,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customers as Yday_Customers,
round((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomers as Yday_New_Customers,
round((x.t1_newcustomers-x.t2_newcustomers)/nullif(x.t2_newcustomers,0)*100,1) as Yday_New_Customers_Growth,
x.t1_liveproducts as Yday_Live_Products,
x.t2_livestores as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customers as MTD_Customers,
round((x.mtd_customers-x.lmtd_customers)/nullif(x.lmtd_customers,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomers as MTD_New_Customers,
round((x.mtd_newcustomers-x.lmtd_newcustomers)/nullif(x.lmtd_newcustomers,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_liveproducts as MTD_Live_Products,
x.lmtd_livestores as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customers as LM_Customers,
x.lm_newcustomers as LM_New_Customers,
x.lm_products as LM_Live_Products,
x.lm_stores as LM_Live_Stores
from
(select 
x.store_id,
x.storetype_id,
coalesce(count(case when x.order_date= '2024-09-16' then x.order_id end),0) as t1_orders,
coalesce(count(case when x.order_date= '2024-09-15' then x.order_id end),0) as t2_orders,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price end),0) as t1_gmv,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price end),0) as t2_gmv,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price/1.18 end),0) as t1_revenue,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price/1.18 end),0) as t2_revenue,
coalesce(count(case when x.order_date= '2024-09-16' then x.customer_id end),0) as t1_customers,
coalesce(count(case when x.order_date= '2024-09-15' then x.customer_id end),0) as t2_customers,
coalesce(count(case when x.order_date= '2024-09-16' then x.new_customer_id end),0)  as t1_newcustomers,
coalesce(count(case when x.order_date= '2024-09-15' then x.new_customer_id end),0)  as t2_newcustomers,
coalesce(count(case when x.order_date= '2024-09-16' then x.product_id end),0) as t1_liveproducts,
coalesce(count(case when x.order_date= '2024-09-15' then x.store_id end),0) as t2_livestores,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.order_id end),0) as mtd_orders,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.order_id end),0) as lmtd_orders,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price end),0) as mtd_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price end),0) as lmtd_gmv,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price/1.18 end),0) as mtd_revenue,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price/1.18 end),0) as lmtd_revenue,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.customer_id end),0) as mtd_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.customer_id end),0) as lmtd_customers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.new_customer_id end),0) as mtd_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.new_customer_id end),0) as lmtd_newcustomers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.product_id end),0) as mtd_liveproducts,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.store_id end),0) as lmtd_livestores,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0)  as lm_products,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_stores
from (select
od.order_id,
od.customer_id,
od.order_date,
od.product_id,
od.store_id,
od.selling_price,
sc.storetype_id,
sc.store_szie,
sc.state,
sc.city,
newc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.store_cities as sc
on od.store_id = sc.store_id
left join(select
od.order_id,
od.customer_id,
od.order_date,
rank() over (partition by od.customer_id order by od.order_date) as rnk
from project7sept.super_mart1.order_details as od) newc
on newc.order_id = od.order_id
where rnk=1) as x
group by 1,2) as x
order by x.mtd_orders asc
limit 50;

----------Table 7: This table presents the status of State Level View----
select
x.state,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customers as Yday_Customers,
round((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomers as Yday_New_Customers,
round((x.t1_newcustomers-x.t2_newcustomers)/nullif(x.t2_newcustomers,0)*100,1) as Yday_New_Customers_Growth,
x.t1_liveproducts as Yday_Live_Products,
x.t2_livestores as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customers as MTD_Customers,
round((x.mtd_customers-x.lmtd_customers)/nullif(x.lmtd_customers,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomers as MTD_New_Customers,
round((x.mtd_newcustomers-x.lmtd_newcustomers)/nullif(x.lmtd_newcustomers,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_liveproducts as MTD_Live_Products,
x.lmtd_livestores as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customers as LM_Customers,
x.lm_newcustomers as LM_New_Customers,
x.lm_products as LM_Live_Products,
x.lm_stores as LM_Live_Stores
from
(select 
x.state,
coalesce(count(case when x.order_date= '2024-09-16' then x.order_id end),0) as t1_orders,
coalesce(count(case when x.order_date= '2024-09-15' then x.order_id end),0) as t2_orders,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price end),0) as t1_gmv,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price end),0) as t2_gmv,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price/1.18 end),0) as t1_revenue,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price/1.18 end),0) as t2_revenue,
coalesce(count(case when x.order_date= '2024-09-16' then x.customer_id end),0) as t1_customers,
coalesce(count(case when x.order_date= '2024-09-15' then x.customer_id end),0) as t2_customers,
coalesce(count(case when x.order_date= '2024-09-16' then x.new_customer_id end),0)  as t1_newcustomers,
coalesce(count(case when x.order_date= '2024-09-15' then x.new_customer_id end),0)  as t2_newcustomers,
coalesce(count(case when x.order_date= '2024-09-16' then x.product_id end),0) as t1_liveproducts,
coalesce(count(case when x.order_date= '2024-09-15' then x.store_id end),0) as t2_livestores,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.order_id end),0) as mtd_orders,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.order_id end),0) as lmtd_orders,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price end),0) as mtd_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price end),0) as lmtd_gmv,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price/1.18 end),0) as mtd_revenue,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price/1.18 end),0) as lmtd_revenue,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.customer_id end),0) as mtd_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.customer_id end),0) as lmtd_customers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.new_customer_id end),0) as mtd_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.new_customer_id end),0) as lmtd_newcustomers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.product_id end),0) as mtd_liveproducts,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.store_id end),0) as lmtd_livestores,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0)  as lm_products,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_stores
from (select
od.order_id,
od.customer_id,
od.order_date,
od.product_id,
od.store_id,
od.selling_price,
sc.storetype_id,
sc.store_szie,
sc.state,
sc.city,
newc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.store_cities as sc
on od.store_id = sc.store_id
left join(select
od.order_id,
od.customer_id,
od.order_date,
rank() over (partition by od.customer_id order by od.order_date) as rnk
from project7sept.super_mart1.order_details as od) newc
on newc.order_id = od.order_id
where rnk=1) as x
group by 1) as x;

--------Table 8: This table presents the status of Top 50 City Level View by MTD Orders-----

select
x.city,
x.store_id,
x.t1_orders as Yday_Orders,
round((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100,1) as Yday_Orders_Growth,
x.t1_gmv as Yday_GMV,
round((x.t1_gmv-x.t2_gmv)/nullif(x.t2_gmv,0)*100,1) as Yday_GMV_Growth,
x.t1_revenue as Yday_Revenue,
round((x.t1_revenue-x.t2_revenue)/nullif(x.t2_revenue,0)*100,1) as Yday_Revenue_Growth,
x.t1_customers as Yday_Customers,
round((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100,1) as Yday_Customers_Growth,
x.t1_newcustomers as Yday_New_Customers,
round((x.t1_newcustomers-x.t2_newcustomers)/nullif(x.t2_newcustomers,0)*100,1) as Yday_New_Customers_Growth,
x.t1_liveproducts as Yday_Live_Products,
x.t2_livestores as Yday_Live_Stores,
x.mtd_orders as MTD_Orders,
round((x.mtd_orders-x.lmtd_orders)/nullif(x.lmtd_orders,0)*100,1) as MTD_Orders_Growth,
x.mtd_gmv as MTD_GMV,
round((x.mtd_gmv-x.lmtd_gmv)/nullif(x.lmtd_gmv,0)*100,1) as MTD_GMV_Growth,
x.mtd_revenue as MTD_Revenue,
round((x.mtd_revenue-x.lmtd_revenue)/nullif(x.lmtd_revenue,0)*100,1) as MTD_Revenue_Growth,
x.mtd_customers as MTD_Customers,
round((x.mtd_customers-x.lmtd_customers)/nullif(x.lmtd_customers,0)*100,1) as MTD_Customers_Growth,
x.mtd_newcustomers as MTD_New_Customers,
round((x.mtd_newcustomers-x.lmtd_newcustomers)/nullif(x.lmtd_newcustomers,0)*100,1) as MTD_New_Customers_Growth,
x.mtd_liveproducts as MTD_Live_Products,
x.lmtd_livestores as MTD_Live_Stores,
x.lm_orders as LM_Orders,
x.lm_gmv as LM_GMV,
x.lm_revenue as LM_Revenue,
x.lm_customers as LM_Customers,
x.lm_newcustomers as LM_New_Customers,
x.lm_products as LM_Live_Products,
x.lm_stores as LM_Live_Stores
from
(select 
x.city,
x.store_id,
coalesce(count(case when x.order_date= '2024-09-16' then x.order_id end),0) as t1_orders,
coalesce(count(case when x.order_date= '2024-09-15' then x.order_id end),0) as t2_orders,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price end),0) as t1_gmv,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price end),0) as t2_gmv,
coalesce(sum(case when x.order_date= '2024-09-16' then x.selling_price/1.18 end),0) as t1_revenue,
coalesce(sum(case when x.order_date= '2024-09-15' then x.selling_price/1.18 end),0) as t2_revenue,
coalesce(count(case when x.order_date= '2024-09-16' then x.customer_id end),0) as t1_customers,
coalesce(count(case when x.order_date= '2024-09-15' then x.customer_id end),0) as t2_customers,
coalesce(count(case when x.order_date= '2024-09-16' then x.new_customer_id end),0)  as t1_newcustomers,
coalesce(count(case when x.order_date= '2024-09-15' then x.new_customer_id end),0)  as t2_newcustomers,
coalesce(count(case when x.order_date= '2024-09-16' then x.product_id end),0) as t1_liveproducts,
coalesce(count(case when x.order_date= '2024-09-15' then x.store_id end),0) as t2_livestores,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.order_id end),0) as mtd_orders,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.order_id end),0) as lmtd_orders,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price end),0) as mtd_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price end),0) as lmtd_gmv,
coalesce(sum(case when x.order_date between '2024-09-01' and '2024-09-16' then x.selling_price/1.18 end),0) as mtd_revenue,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-16' then x.selling_price/1.18 end),0) as lmtd_revenue,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.customer_id end),0) as mtd_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.customer_id end),0) as lmtd_customers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.new_customer_id end),0) as mtd_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.new_customer_id end),0) as lmtd_newcustomers,
coalesce(count(case when x.order_date between '2024-09-01' and '2024-09-16' then x.product_id end),0) as mtd_liveproducts,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-16' then x.store_id end),0) as lmtd_livestores,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end),0) as lm_orders,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end),0) as lm_gmv,
coalesce(sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price/1.18 end),0) as lm_revenue,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end),0) as lm_customers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.new_customer_id end),0) as lm_newcustomers,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.product_id end),0)  as lm_products,
coalesce(count(case when x.order_date between '2024-08-01' and '2024-08-31' then x.store_id end),0) as lm_stores
from (select
od.order_id,
od.customer_id,
od.order_date,
od.product_id,
od.store_id,
od.selling_price,
sc.storetype_id,
sc.store_szie,
sc.state,
sc.city,
newc.customer_id as new_customer_id
from project7sept.super_mart1.order_details as od
join project7sept.super_mart1.store_cities as sc
on od.store_id = sc.store_id
left join(select
od.order_id,
od.customer_id,
od.order_date,
rank() over (partition by od.customer_id order by od.order_date) as rnk
from project7sept.super_mart1.order_details as od) newc
on newc.order_id = od.order_id
where rnk=1) as x
group by 1,2) as x
order by x.mtd_orders asc
limit 50;

--------Table 9: This table present the status on Order Range Level View------

select
  case when x.t1_orders=1 or x.mtd_orders=1 or x.lmtd_orders=1 or x.lm_orders=1 then '1' 
     when x.t1_orders=2 or x.mtd_orders=2 or x.lmtd_orders=2 or x.lm_orders=2 then '2'
     when x.t1_orders=3 or x.mtd_orders=3 or x.lmtd_orders=3 or x.lm_orders=3 then '3'
	   when x.t1_orders=4 or x.mtd_orders=4 or x.lmtd_orders=4 or x.lm_orders=4 then '4'
	   when x.t1_orders=5 or x.mtd_orders=5 or x.lmtd_orders=5 or x.lm_orders=5 then '5'
	   when x.t1_orders>5 and x.t1_orders<=7 or x.mtd_orders>5 and x.mtd_orders<=7 or x.lmtd_orders>5 and 
     x.lmtd_orders<=7 or x.lm_orders>5 and x.lm_orders<=7 then '6 to 7'
	   when x.t1_orders>7 and x.t1_orders<=10 or x.mtd_orders>7 and x.mtd_orders<=10 or x.lmtd_orders>7 and 
     x.lmtd_orders<=10 or x.lm_orders>7 and x.lm_orders<=10 then '8 to 10'
     when x.t1_orders>10 or x.mtd_orders>10 or x.lmtd_orders>10 or x.lm_orders>10 then 'gtr10' end as order_range,

count(distinct x.t1_customer) as Yday_Customers,
sum(x.t1_orders) as Yday_Orders,

count(distinct x.mtd_customer) as MTD_Customers,
sum (x.mtd_orders) as MTD_Orders,

count(distinct x.lmtd_customer) as LMTD_Customers,
sum (x.lmtd_orders) as LMTD_Orders,

count(distinct x.lm_customer) as LM_Customers,
sum (x.lm_orders) as LM_Orders

from
(select
case when x.order_date = '2024-09-14' then x.customer_id end as t1_customer,
count(distinct case when x.order_date = '2024-09-14' then x.order_id end) as t1_orders,

case when x.order_date between '2024-09-01' and '2024-09-14' then x.customer_id end as mtd_customer,
count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.order_id end) as mtd_orders,

case when x.order_date between '2024-08-01' and '2024-08-14' then x.customer_id end as lmtd_customer,
count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.order_id end) lmtd_orders,

case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end as lm_customer,
count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end) as lm_orders

from
(select 
od.order_date,
od.customer_id,
od.order_id
from project7sept.super_mart1.order_details as od
where od.order_date >= '2024-08-01') as x
group by 1,3,5,7 )as x
group by 1

------------Table 10: This table present the status on Txn Range Level View-----

select
case when x.t1_gmv>=1 and x.t1_gmv<100  or x.mtd_gmv>=1 and x.mtd_gmv<100 or x.lmtd_gmv>=1 and x.lmtd_gmv<100 or x.lm_gmv>=1 and x.lm_gmv<100 then '1 to 100'
     when x.t1_gmv>=101 and x.t1_gmv<200 or x.mtd_gmv>=101 and x.mtd_gmv<200 or x.lmtd_gmv>=101 and x.lmtd_gmv<200 or x.lm_gmv>=101 and x.lm_gmv<200 then '101 to 200' 
     when x.t1_gmv>=201 and x.t1_gmv<300 or x.mtd_gmv>=201 and x.mtd_gmv<300 or x.lmtd_gmv>=201 and x.lmtd_gmv<300 or x.lm_gmv>=201 and x.lm_gmv<300 then '201 to 300'
     when x.t1_gmv>=301 and x.t1_gmv<400 or x.mtd_gmv>=301 and x.mtd_gmv<400 or x.lmtd_gmv>=301 and x.lmtd_gmv<400 or x.lm_gmv>=301 and x.lm_gmv<400 then '301 to 400'
     when x.t1_gmv>=401 and x.t1_gmv<500 or x.mtd_gmv>=401 and x.mtd_gmv<500 or x.lmtd_gmv>=401 and x.lmtd_gmv<500 or x.lm_gmv>=401 and x.lm_gmv<500 then '401 to 500'
     when x.t1_gmv>=501 and x.t1_gmv<700 or x.mtd_gmv>=501 and x.mtd_gmv<700 or x.lmtd_gmv>=501 and x.lmtd_gmv<700 or x.lm_gmv>=501 and x.lm_gmv<700 then '501 to 700'
     when x.t1_gmv>=701 and x.t1_gmv<1000 or x.mtd_gmv>=701 and x.mtd_gmv<1000 or x.lmtd_gmv>=701 and x.lmtd_gmv<1000 or x.lm_gmv>=701 and x.lm_gmv<1000 then '701 to 1000'
     when x.t1_gmv>=1001 and x.t1_gmv<1500 or x.mtd_gmv>=1001 and x.mtd_gmv<1500 or x.lmtd_gmv>=1001 and x.lmtd_gmv<1500 or x.lm_gmv>=1001 and x.lm_gmv<1500 then '1001 to 1500'
     when x.t1_gmv>=1501 and x.t1_gmv<2000 or x.mtd_gmv>=1501 and x.mtd_gmv<2000 or x.lmtd_gmv>=1501 and x.lmtd_gmv<2000 or x.lm_gmv>=1501 and x.lm_gmv<2000 then '1501 to 2000'
     when x.t1_gmv>=2001 and x.t1_gmv<2500 or x.mtd_gmv>=2001 and x.mtd_gmv<2500 or x.lmtd_gmv>=2001 and x.lmtd_gmv<2500 or x.lm_gmv>=2001 and x.lm_gmv<2500 then'2001 to 2500'
     WHEN x.t1_gmv>=2501 and x.t1_gmv<3000 or x.mtd_gmv>=2501 and x.mtd_gmv<3000 or x.lmtd_gmv>=2501 and x.lmtd_gmv<3000 or x.lm_gmv>=2501 and x.lm_gmv<3000 then'2501 to 3000'
     when x.t1_gmv>=3001 and x.t1_gmv<4000 or x.mtd_gmv>=3001 and x.mtd_gmv<4000 or x.lmtd_gmv>=3001 and x.lmtd_gmv<4000 or x.lm_gmv>=3001 and x.lm_gmv<4000 then'3001 to 4000'
     when x.t1_gmv>=4001 and x.t1_gmv<5000 or x.mtd_gmv>=4001 and x.mtd_gmv<5000 or x.lmtd_gmv>=4001 and x.lmtd_gmv<5000 or x.lm_gmv>=4001 and x.lm_gmv<5000 then'4001 to 5000'
     when x.t1_gmv>5000 or x.mtd_gmv>5000 or x.lmtd_gmv>5000 or x.lm_gmv>5000 then 'grt5000'end as Txn_Amount_Range,

count(distinct x.t1_customer) as Yday_Customers,
sum(x.t1_orders) as Yday_Orders,
count(x.t1_gmv) as Yday_GMV,
round(count(x.t1_gmv/x.t1_orders),2) as Yday_GMV_By_orders,

count(distinct x.mtd_customer) as MTD_Customers,
sum(x.mtd_orders) as MTD_Orders,
count(x.mtd_gmv) as MTD_GMV,
round(count(x.mtd_gmv/x.mtd_orders),2) as MTD_GMV_By_orders,



count(distinct x.lmtd_customer) as LMTD_Customers,
sum(x.lmtd_orders) as LMTD_Orders,
count(x.lmtd_gmv) as LMTD_GMV,
round(count(x.lmtd_gmv/x.lmtd_orders),2) as LMTD_GMV_By_orders,



count(distinct x.lm_customer) as LM_Customers,
sum(x.lm_orders) as LM_Orders,
count(x.lm_gmv) as LM_GMV,
round(count(x.lm_gmv/x.lm_orders),2) as LM_GMV_By_orders

from 
(select

case when x.order_date = '2024-09-14' then x.customer_id end as t1_customer,
count(distinct case when x.order_date = '2024-09-14' then x.order_id end) as t1_orders,
sum(case when x.order_date = '2024-09-14' then x.selling_price end) as t1_gmv,

case when x.order_date between '2024-09-01' and '2024-09-14' then x.customer_id end as mtd_customer,
count(distinct case when x.order_date between '2024-09-01' and '2024-09-14' then x.order_id end) as mtd_orders,
sum(case when x.order_date between '2024-09-01' and '2024-09-14' then x.selling_price end) as mtd_gmv,

case when x.order_date between '2024-08-01' and '2024-08-14' then x.customer_id end as lmtd_customer,
count(distinct case when x.order_date between '2024-08-01' and '2024-08-14' then x.order_id end) lmtd_orders,
sum(case when x.order_date between '2024-08-01' and '2024-08-14'then x.selling_price end) as lmtd_gmv,

case when x.order_date between '2024-08-01' and '2024-08-31' then x.customer_id end as lm_customer,
count(distinct case when x.order_date between '2024-08-01' and '2024-08-31' then x.order_id end) as lm_orders,
sum(case when x.order_date between '2024-08-01' and '2024-08-31' then x.selling_price end) as lm_gmv


from 
(select
od.order_date,
od.order_id,
od.customer_id,
od.selling_price
from project7sept.super_mart1.order_details as od
where od.order_date>= '2014-08-01') as x
group by 1,4,7,10 ) as x
group by 1

-----------