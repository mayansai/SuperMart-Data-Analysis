Part 1: Daily Insights
Generate daily reports to evaluate SuperMart's performance at different levels of granularity:

Question:- Category Level Report: Analyze metrics such as Orders, GMV, Revenue, Customers, Live Products, and Live Stores for yesterday's data, with growth percentages for each metric.

select 
x.category,

coalesce(x.t1_orders,0) as YTD_orders,
coalesce(round(((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100),1),0) as YTD_ORDERS_GROWTH,

coalesce(x.t1_GMV,0) as YTD_GMV,
coalesce(round(((x.t1_GMV-x.t2_GMV)/nullif(x.t2_GMV,0)*100),1),0) as YTD_GMV_GROWTH,

coalesce(round(x.t1_Revenue,2),0) as YTD_Revenue,
coalesce(round(((x.t1_Revenue-x.t2_Revenue)/nullif(x.t2_Revenue,0)*100),1),0) as YTD_Revenue_GROWTH,

coalesce(x.t1_customers,0) as YTD_Customers,
coalesce(round(((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100),1),0) as YTD_Customers_GROWTH,

coalesce(x.t1_Live_products,0) as YTD_Live_Products,
coalesce(round(((x.t1_Live_products-x.t2_Live_products)/nullif(x.t2_Live_products,0)*100),1),0) as YTD_Live_products_GROWTH,

coalesce(x.t1_Live_stores,0) as YTD_Live_stores,
coalesce(round(((x.t1_Live_stores-x.t2_Live_stores)/nullif(x.t2_Live_stores,0)*100),1),0) as YTD_Live_stores_GROWTH

from (select
ph.category,

count(distinct case when od.order_date = '2024-12-24' then od.order_id end) as t2_orders,
count(distinct case when od.order_date = '2024-12-25' then od.order_id end) as t1_orders,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price end) as t2_GMV,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price end) as t1_GMV,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price/1.18 end) as t2_Revenue,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price/1.18 end) as t1_Revenue,

count(distinct case when od.order_date = '2024-12-24' then od.customer_id end) as t2_customers,
count(distinct case when od.order_date = '2024-12-25' then od.customer_id end) as t1_customers,

count(distinct case when od.order_date = '2024-12-24' then ph.product_id end) as t2_Live_products,
count(distinct case when od.order_date = '2024-12-25' then ph.product_id end) as t1_Live_products,

count(distinct case when od.order_date = '2024-12-24' then sc.store_id end) as t2_Live_stores,
count(distinct case when od.order_date = '2024-12-25' then sc.store_id end) as t1_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x

Question2:- Top 20 Brands Report: Identify the top-performing brands (based on GMV) and evaluate key metrics for yesterday's data, including growth trends.

select 
x.brand ,

coalesce(x.t1_orders,0) as YTD_orders,
coalesce(round(((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100),2),0) as YTD_ORDERS_GROWTH,

coalesce(x.t1_GMV,0) as YTD_GMV,
coalesce(round(((x.t1_GMV-x.t1_GMV)/nullif(x.t2_GMV,0)*100),2),0) as YTD_GMV_GROWTH,

coalesce(x.t1_Revenue,0) as YTD_Revenue,
coalesce(round(((x.t1_Revenue-x.t2_Revenue)/nullif(x.t2_Revenue,0)*100),2),0) as YTD_Revenue_GROWTH,

coalesce(x.t1_customers,0) as YTD_Customers,
coalesce(round(((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100),2),0) as YTD_Customers_GROWTH,

coalesce(x.t1_Live_products,0) as YTD_Live_Products,
coalesce(round(((x.t1_Live_products-x.t2_Live_products)/nullif(x.t2_Live_products,0)*100),2),0) as YTD_Live_products_GROWTH,

coalesce(x.t1_Live_stores,0) as YTD_Live_stores,
coalesce(round(((x.t1_Live_stores-x.t2_Live_stores)/nullif(x.t2_Live_stores,0)*100),2),0) as YTD_Live_stores_GROWTH

from (select
ph.brand,

count(distinct case when od.order_date = '2024-12-24' then od.order_id end) as t2_orders,
count(distinct case when od.order_date = '2024-12-25' then od.order_id end) as t1_orders,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price end) as t2_GMV,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price end)as t1_GMV,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price/1.18 end) as t2_Revenue,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price/1.18 end) as t1_Revenue,

count(distinct case when od.order_date = '2024-12-24' then od.customer_id end) as t2_customers,
count(distinct case when od.order_date = '2024-12-25' then od.customer_id end) as t1_customers,

count(distinct case when od.order_date = '2024-12-24' then ph.product_id end) as t2_Live_products,
count(distinct case when od.order_date = '2024-12-25' then ph.product_id end) as t1_Live_products,

count(distinct case when od.order_date = '2024-12-24' then sc.store_id end) as t2_Live_stores,
count(distinct case when od.order_date = '2024-12-25' then sc.store_id end) as t1_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 4 desc
limit 20

Question 3:-Top 50 Products Report: Examine the performance of the top products (based on GMV), including their associated brands, to uncover sales and growth patterns for yesterday's data.

select 
x.product,
x.brand ,

coalesce(x.t1_orders,0) as YTD_orders,
coalesce(round(((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100),2),0) as YTD_ORDERS_GROWTH,

coalesce(x.t1_GMV,0) as YTD_GMV,
coalesce(round(((x.t1_GMV-x.t1_GMV)/nullif(x.t2_GMV,0)*100),2),0) as YTD_GMV_GROWTH,

coalesce(round(x.t1_Revenue,2),0) as YTD_Revenue,
coalesce(round(((x.t1_Revenue-x.t2_Revenue)/nullif(x.t2_Revenue,0)*100),2),0) as YTD_Revenue_GROWTH,

coalesce(x.t1_customers,0) as YTD_Customers,
coalesce(round(((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100),2),0) as YTD_Customers_GROWTH,

coalesce(x.t1_Live_products,0) as YTD_Live_Products,
coalesce(round(((x.t1_Live_products-x.t2_Live_products)/nullif(x.t2_Live_products,0)*100),2),0) as YTD_Live_products_GROWTH,

coalesce(x.t1_Live_stores,0) as YTD_Live_stores,
coalesce(round(((x.t1_Live_stores-x.t2_Live_stores)/nullif(x.t2_Live_stores,0)*100),2),0) as YTD_Live_stores_GROWTH

from (select
ph.product,
ph.brand,

count(distinct case when od.order_date = '2024-12-24' then od.order_id end) as t2_orders,
count(distinct case when od.order_date = '2024-12-25' then od.order_id end) as t1_orders,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price end) as t2_GMV,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price end)as t1_GMV,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price/1.18 end) as t2_Revenue,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price/1.18 end) as t1_Revenue,

count(distinct case when od.order_date = '2024-12-24' then od.customer_id end) as t2_customers,
count(distinct case when od.order_date = '2024-12-25' then od.customer_id end) as t1_customers,

count(distinct case when od.order_date = '2024-12-24' then ph.product_id end) as t2_Live_products,
count(distinct case when od.order_date = '2024-12-25' then ph.product_id end) as t1_Live_products,

count(distinct case when od.order_date = '2024-12-24' then sc.store_id end) as t2_Live_stores,
count(distinct case when od.order_date = '2024-12-25' then sc.store_id end) as t1_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1,2) as x
order by 5 desc
limit 50

Question:-StoreType_Id Report: Assess store-type performance based on Orders, GMV, Revenue, Customers, Live Products, and Live Stores for yesterday's data, including growth comparisons.

select 
x.storetype_id,

coalesce(x.t1_orders,0) as YTD_orders,
coalesce(round(((x.t1_orders-x.t2_orders)/nullif(x.t2_orders,0)*100),2),0) as YTD_ORDERS_GROWTH,

coalesce(x.t1_GMV,0) as YTD_GMV,
coalesce(round(((x.t1_GMV-x.t1_GMV)/nullif(x.t2_GMV,0)*100),2),0) as YTD_GMV_GROWTH,

coalesce(round(x.t1_Revenue,2),0) as YTD_Revenue,
coalesce(round(((x.t1_Revenue-x.t2_Revenue)/nullif(x.t2_Revenue,0)*100),2),0) as YTD_Revenue_GROWTH,

coalesce(x.t1_customers,0) as YTD_Customers,
coalesce(round(((x.t1_customers-x.t2_customers)/nullif(x.t2_customers,0)*100),2),0) as YTD_Customers_GROWTH,

coalesce(x.t1_Live_products,0) as YTD_Live_Products,
coalesce(round(((x.t1_Live_products-x.t2_Live_products)/nullif(x.t2_Live_products,0)*100),2),0) as YTD_Live_products_GROWTH,

coalesce(x.t1_Live_stores,0) as YTD_Live_stores,
coalesce(round(((x.t1_Live_stores-x.t2_Live_stores)/nullif(x.t2_Live_stores,0)*100),2),0) as YTD_Live_stores_GROWTH

from (select
sc.storetype_id,

count(distinct case when od.order_date = '2024-12-24' then od.order_id end) as t2_orders,
count(distinct case when od.order_date = '2024-12-25' then od.order_id end) as t1_orders,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price end) as t2_GMV,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price end)as t1_GMV,

sum(distinct case when od.order_date = '2024-12-24' then od.selling_price/1.18 end) as t2_Revenue,
sum(distinct case when od.order_date = '2024-12-25' then od.selling_price/1.18 end) as t1_Revenue,

count(distinct case when od.order_date = '2024-12-24' then od.customer_id end) as t2_customers,
count(distinct case when od.order_date = '2024-12-25' then od.customer_id end) as t1_customers,

count(distinct case when od.order_date = '2024-12-24' then ph.product_id end) as t2_Live_products,
count(distinct case when od.order_date = '2024-12-25' then ph.product_id end) as t1_Live_products,

count(distinct case when od.order_date = '2024-12-24' then sc.store_id end) as t2_Live_stores,
count(distinct case when od.order_date = '2024-12-25' then sc.store_id end) as t1_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 1

Part 2: Month-To-Date (MTD) Insights
Track cumulative monthly performance for deeper trend analysis:

Question 1:-Category Level Report: Provide an MTD summary of Orders, GMV, Revenue, Customers, Live Products, and Live Stores, along with growth percentages.

select 
x.category,

coalesce(x.MTD_orders,0) as MTD_orders,
coalesce(round(((x.MTD_orders-x.LMTD_orders)/nullif(x.LMTD_orders,0)*100),1),0) as MTD_ORDERS_GROWTH,

coalesce(x.MTD_GMV,0) as MTD_GMV,
coalesce(round(((x.MTD_GMV-x.LMTD_GMV)/nullif(x.LMTD_GMV,0)*100),1),0) as MTD_GMV_GROWTH,

coalesce(round(x.MTD_Revenue,2),0) as MTD_Revenue,
coalesce(round(((x.MTD_Revenue-x.LMTD_Revenue)/nullif(x.LMTD_Revenue,0)*100),1),0) as MTD_Revenue_GROWTH,

coalesce(x.MTD_customers,0) as MTD_Customers,
coalesce(round(((x.MTD_customers-x.LMTD_customers)/nullif(x.LMTD_customers,0)*100),1),0) as MTD_Customers_GROWTH,

coalesce(x.MTD_Live_products,0) as MTD_Live_Products,
coalesce(round(((x.MTD_Live_products-x.LMTD_Live_products)/nullif(x.LMTD_Live_products,0)*100),1),0) as MTD_Live_products_GROWTH,

coalesce(x.MTD_Live_stores,0) as MTD_Live_stores,
coalesce(round(((x.MTD_Live_stores-x.LMTD_Live_stores)/nullif(x.LMTD_Live_stores,0)*100),1),0) as MTD_Live_stores_GROWTH

from (select
ph.category,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x

Question2:- Top 20 Brands Report: Highlight the top-performing brands for the MTD period, showcasing key metrics and their growth trends.

select 
x.brand,

coalesce(x.MTD_orders,0) as MTD_orders,
coalesce(round(((x.MTD_orders-x.LMTD_orders)/nullif(x.LMTD_orders,0)*100),1),0) as MTD_ORDERS_GROWTH,

coalesce(x.MTD_GMV,0) as MTD_GMV,
coalesce(round(((x.MTD_GMV-x.LMTD_GMV)/nullif(x.LMTD_GMV,0)*100),1),0) as MTD_GMV_GROWTH,

coalesce(round(x.MTD_Revenue,2),0) as MTD_Revenue,
coalesce(round(((x.MTD_Revenue-x.LMTD_Revenue)/nullif(x.LMTD_Revenue,0)*100),1),0) as MTD_Revenue_GROWTH,

coalesce(x.MTD_customers,0) as MTD_Customers,
coalesce(round(((x.MTD_customers-x.LMTD_customers)/nullif(x.LMTD_customers,0)*100),1),0) as MTD_Customers_GROWTH,

coalesce(x.MTD_Live_products,0) as MTD_Live_Products,
coalesce(round(((x.MTD_Live_products-x.LMTD_Live_products)/nullif(x.LMTD_Live_products,0)*100),1),0) as MTD_Live_products_GROWTH,

coalesce(x.MTD_Live_stores,0) as MTD_Live_stores,
coalesce(round(((x.MTD_Live_stores-x.LMTD_Live_stores)/nullif(x.LMTD_Live_stores,0)*100),1),0) as MTD_Live_stores_GROWTH

from (select
ph.brand,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 4 desc
limit 20

Question3:-Top 50 Products Report: Focus on top product-level performance for the MTD period, including product and brand details.

select 
x.product,
x.brand,

coalesce(x.MTD_orders,0) as MTD_orders,
coalesce(round(((x.MTD_orders-x.LMTD_orders)/nullif(x.LMTD_orders,0)*100),1),0) as MTD_ORDERS_GROWTH,

coalesce(x.MTD_GMV,0) as MTD_GMV,
coalesce(round(((x.MTD_GMV-x.LMTD_GMV)/nullif(x.LMTD_GMV,0)*100),1),0) as MTD_GMV_GROWTH,

coalesce(round(x.MTD_Revenue,2),0) as MTD_Revenue,
coalesce(round(((x.MTD_Revenue-x.LMTD_Revenue)/nullif(x.LMTD_Revenue,0)*100),1),0) as MTD_Revenue_GROWTH,

coalesce(x.MTD_customers,0) as MTD_Customers,
coalesce(round(((x.MTD_customers-x.LMTD_customers)/nullif(x.LMTD_customers,0)*100),1),0) as MTD_Customers_GROWTH,

coalesce(x.MTD_Live_products,0) as MTD_Live_Products,
coalesce(round(((x.MTD_Live_products-x.LMTD_Live_products)/nullif(x.LMTD_Live_products,0)*100),1),0) as MTD_Live_products_GROWTH,

coalesce(x.MTD_Live_stores,0) as MTD_Live_stores,
coalesce(round(((x.MTD_Live_stores-x.LMTD_Live_stores)/nullif(x.LMTD_Live_stores,0)*100),1),0) as MTD_Live_stores_GROWTH

from (select
ph.product,
ph.brand,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1,2) as x
order by 5 desc
limit 50

Question4:-StoreType_Id Report: Analyze store-type performance metrics for the MTD period, identifying growth trends.

select 
x.storetype_id,

coalesce(x.MTD_orders,0) as MTD_orders,
coalesce(round(((x.MTD_orders-x.LMTD_orders)/nullif(x.LMTD_orders,0)*100),1),0) as MTD_ORDERS_GROWTH,

coalesce(x.MTD_GMV,0) as MTD_GMV,
coalesce(round(((x.MTD_GMV-x.LMTD_GMV)/nullif(x.LMTD_GMV,0)*100),1),0) as MTD_GMV_GROWTH,

coalesce(round(x.MTD_Revenue,2),0) as MTD_Revenue,
coalesce(round(((x.MTD_Revenue-x.LMTD_Revenue)/nullif(x.LMTD_Revenue,0)*100),1),0) as MTD_Revenue_GROWTH,

coalesce(x.MTD_customers,0) as MTD_Customers,
coalesce(round(((x.MTD_customers-x.LMTD_customers)/nullif(x.LMTD_customers,0)*100),1),0) as MTD_Customers_GROWTH,

coalesce(x.MTD_Live_products,0) as MTD_Live_Products,
coalesce(round(((x.MTD_Live_products-x.LMTD_Live_products)/nullif(x.LMTD_Live_products,0)*100),1),0) as MTD_Live_products_GROWTH,

coalesce(x.MTD_Live_stores,0) as MTD_Live_stores,
coalesce(round(((x.MTD_Live_stores-x.LMTD_Live_stores)/nullif(x.LMTD_Live_stores,0)*100),1),0) as MTD_Live_stores_GROWTH

from (select
sc.storetype_id,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 1

Part 3: Last Month-To-Date (LMTD) Insights
Compare performance trends by analyzing last month's data until the same day as the current period:

Question1:-Category Level Report: Generate LMTD metrics such as Orders, GMV, Revenue, Customers, Live Products, and Live Stores, with growth percentages.

select 
x.category,

coalesce(x.LMTD_orders,0) as LMTD_orders,
coalesce(round(((x.LMTD_orders-x.MTD_orders)/nullif(x.MTD_orders,0)*100),1),0) as LMTD_ORDERS_GROWTH,

coalesce(x.LMTD_GMV,0) as LMTD_GMV,
coalesce(round(((x.LMTD_GMV-x.MTD_GMV)/nullif(x.MTD_GMV,0)*100),1),0) as LMTD_GMV_GROWTH,

coalesce(round(x.LMTD_Revenue,2),0) as LMTD_Revenue,
coalesce(round(((x.LMTD_Revenue-x.MTD_Revenue)/nullif(x.MTD_Revenue,0)*100),1),0) as LMTD_Revenue_GROWTH,

coalesce(x.LMTD_customers,0) as LMTD_Customers,
coalesce(round(((x.LMTD_customers-x.MTD_customers)/nullif(x.MTD_customers,0)*100),1),0) as LMTD_Customers_GROWTH,

coalesce(x.LMTD_Live_products,0) as LMTD_Live_Products,
coalesce(round(((x.LMTD_Live_products-x.MTD_Live_products)/nullif(x.MTD_Live_products,0)*100),1),0) as LMTD_Live_products_GROWTH,

coalesce(x.LMTD_Live_stores,0) as LMTD_Live_stores,
coalesce(round(((x.LMTD_Live_stores-x.MTD_Live_stores)/nullif(x.MTD_Live_stores,0)*100),1),0) as LMTD_Live_stores_GROWTH

from (select
ph.category,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x

Question2:-Top 20 Brands Report: Evaluate top-performing brands during the LMTD period, highlighting growth trends and sales contributions.

select 
x.brand,

coalesce(x.LMTD_orders,0) as LMTD_orders,
coalesce(round(((x.LMTD_orders-x.MTD_orders)/nullif(x.MTD_orders,0)*100),1),0) as LMTD_ORDERS_GROWTH,

coalesce(x.LMTD_GMV,0) as LMTD_GMV,
coalesce(round(((x.LMTD_GMV-x.MTD_GMV)/nullif(x.MTD_GMV,0)*100),1),0) as LMTD_GMV_GROWTH,

coalesce(round(x.LMTD_Revenue,2),0) as LMTD_Revenue,
coalesce(round(((x.LMTD_Revenue-x.MTD_Revenue)/nullif(x.MTD_Revenue,0)*100),1),0) as LMTD_Revenue_GROWTH,

coalesce(x.LMTD_customers,0) as LMTD_Customers,
coalesce(round(((x.LMTD_customers-x.MTD_customers)/nullif(x.MTD_customers,0)*100),1),0) as LMTD_Customers_GROWTH,

coalesce(x.LMTD_Live_products,0) as LMTD_Live_Products,
coalesce(round(((x.LMTD_Live_products-x.MTD_Live_products)/nullif(x.MTD_Live_products,0)*100),1),0) as LMTD_Live_products_GROWTH,

coalesce(x.LMTD_Live_stores,0) as LMTD_Live_stores,
coalesce(round(((x.LMTD_Live_stores-x.MTD_Live_stores)/nullif(x.MTD_Live_stores,0)*100),1),0) as LMTD_Live_stores_GROWTH

from (select
ph.brand,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 4 desc
limit 20

Question3:-Top 50 Products Report: Identify leading products based on GMV for the LMTD period, including brand and product details.

select 
x.product,
x.brand,

coalesce(x.LMTD_orders,0) as LMTD_orders,
coalesce(round(((x.LMTD_orders-x.MTD_orders)/nullif(x.MTD_orders,0)*100),1),0) as LMTD_ORDERS_GROWTH,

coalesce(x.LMTD_GMV,0) as LMTD_GMV,
coalesce(round(((x.LMTD_GMV-x.MTD_GMV)/nullif(x.MTD_GMV,0)*100),1),0) as LMTD_GMV_GROWTH,

coalesce(round(x.LMTD_Revenue,2),0) as LMTD_Revenue,
coalesce(round(((x.LMTD_Revenue-x.MTD_Revenue)/nullif(x.MTD_Revenue,0)*100),1),0) as LMTD_Revenue_GROWTH,

coalesce(x.LMTD_customers,0) as LMTD_Customers,
coalesce(round(((x.LMTD_customers-x.MTD_customers)/nullif(x.MTD_customers,0)*100),1),0) as LMTD_Customers_GROWTH,

coalesce(x.LMTD_Live_products,0) as LMTD_Live_Products,
coalesce(round(((x.LMTD_Live_products-x.MTD_Live_products)/nullif(x.MTD_Live_products,0)*100),1),0) as LMTD_Live_products_GROWTH,

coalesce(x.LMTD_Live_stores,0) as LMTD_Live_stores,
coalesce(round(((x.LMTD_Live_stores-x.MTD_Live_stores)/nullif(x.MTD_Live_stores,0)*100),1),0) as LMTD_Live_stores_GROWTH

from (select
ph.product,
ph.brand,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1,2) as x
order by 5 desc
limit 50

Question4:- StoreType_Id Report: Assess LMTD store-type performance with key metrics and growth rates.

select 
x.storetype_id,

coalesce(x.LMTD_orders,0) as LMTD_orders,
coalesce(round(((x.LMTD_orders-x.MTD_orders)/nullif(x.MTD_orders,0)*100),1),0) as LMTD_ORDERS_GROWTH,

coalesce(x.LMTD_GMV,0) as LMTD_GMV,
coalesce(round(((x.LMTD_GMV-x.MTD_GMV)/nullif(x.MTD_GMV,0)*100),1),0) as LMTD_GMV_GROWTH,

coalesce(round(x.LMTD_Revenue,2),0) as LMTD_Revenue,
coalesce(round(((x.LMTD_Revenue-x.MTD_Revenue)/nullif(x.MTD_Revenue,0)*100),1),0) as LMTD_Revenue_GROWTH,

coalesce(x.LMTD_customers,0) as LMTD_Customers,
coalesce(round(((x.LMTD_customers-x.MTD_customers)/nullif(x.MTD_customers,0)*100),1),0) as LMTD_Customers_GROWTH,

coalesce(x.LMTD_Live_products,0) as LMTD_Live_Products,
coalesce(round(((x.LMTD_Live_products-x.MTD_Live_products)/nullif(x.MTD_Live_products,0)*100),1),0) as LMTD_Live_products_GROWTH,

coalesce(x.LMTD_Live_stores,0) as LMTD_Live_stores,
coalesce(round(((x.LMTD_Live_stores-x.MTD_Live_stores)/nullif(x.MTD_Live_stores,0)*100),1),0) as LMTD_Live_stores_GROWTH

from (select
sc.storetype_id,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.order_id end) as LMTD_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.order_id end) as MTD_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price end) as LMTD_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price end) as MTD_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.selling_price/1.18 end) as LMTD_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.selling_price/1.18 end) as MTD_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then od.customer_id end) as LMTD_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then od.customer_id end) as MTD_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then ph.product_id end) as LMTD_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then ph.product_id end) as MTD_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-24' then sc.store_id end) as LMTD_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-24' then sc.store_id end) as MTD_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 1

Part 4: Last Month (LM) Insights
Provide a comprehensive analysis of last month's performance to identify recurring trends:

Question1:-Category Level Report: Summarize LM metrics, including Orders, GMV, Revenue, Customers, Live Products, and Live Stores, with growth comparisons.

select 
x.category,

coalesce(x.LM2_orders,0) as LM_orders,
coalesce(round(((x.LM2_orders-x.LM1_orders)/nullif(x.LM1_orders,0)*100),1),0) as LM_ORDERS_GROWTH,

coalesce(x.LM2_GMV,0) as LM_GMV,
coalesce(round(((x.LM2_GMV-x.LM1_GMV)/nullif(x.LM1_GMV,0)*100),1),0) as LM_GMV_GROWTH,

coalesce(round(x.LM2_Revenue,2),0) as LM2_Revenue,
coalesce(round(((x.LM2_Revenue-x.LM1_Revenue)/nullif(x.LM1_Revenue,0)*100),1),0) as LM_Revenue_GROWTH,

coalesce(x.LM2_customers,0) as LM_Customers,
coalesce(round(((x.LM2_customers-x.LM1_customers)/nullif(x.LM1_customers,0)*100),1),0) as LM_Customers_GROWTH,

coalesce(x.LM2_Live_products,0) as LM_Live_Products,
coalesce(round(((x.LM2_Live_products-x.LM1_Live_products)/nullif(x.LM1_Live_products,0)*100),1),0) as LM_Live_products_GROWTH,

coalesce(x.LM2_Live_stores,0) as LM_Live_stores,
coalesce(round(((x.LM2_Live_stores-x.LM1_Live_stores)/nullif(x.LM1_Live_stores,0)*100),1),0) as LM_Live_stores_GROWTH

from (select
ph.category,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.order_id end) as LM1_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.order_id end) as LM2_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price end) as LM1_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price end) as LM2_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price/1.18 end) as LM1_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price/1.18 end) as LM2_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.customer_id end) as LM1_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.customer_id end) as LM2_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then ph.product_id end) as LM1_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then ph.product_id end) as LM2_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then sc.store_id end) as LM1_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then sc.store_id end) as LM2_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x

Question2:-Top 20 Brands Report: Identify the best-performing brands for LM, highlighting their contributions and growth trends.

select 
x.brand,

coalesce(x.LM2_orders,0) as LM_orders,
coalesce(round(((x.LM2_orders-x.LM1_orders)/nullif(x.LM1_orders,0)*100),1),0) as LM_ORDERS_GROWTH,

coalesce(x.LM2_GMV,0) as LM_GMV,
coalesce(round(((x.LM2_GMV-x.LM1_GMV)/nullif(x.LM1_GMV,0)*100),1),0) as LM_GMV_GROWTH,

coalesce(round(x.LM2_Revenue,2),0) as LM2_Revenue,
coalesce(round(((x.LM2_Revenue-x.LM1_Revenue)/nullif(x.LM1_Revenue,0)*100),1),0) as LM_Revenue_GROWTH,

coalesce(x.LM2_customers,0) as LM_Customers,
coalesce(round(((x.LM2_customers-x.LM1_customers)/nullif(x.LM1_customers,0)*100),1),0) as LM_Customers_GROWTH,

coalesce(x.LM2_Live_products,0) as LM_Live_Products,
coalesce(round(((x.LM2_Live_products-x.LM1_Live_products)/nullif(x.LM1_Live_products,0)*100),1),0) as LM_Live_products_GROWTH,

coalesce(x.LM2_Live_stores,0) as LM_Live_stores,
coalesce(round(((x.LM2_Live_stores-x.LM1_Live_stores)/nullif(x.LM1_Live_stores,0)*100),1),0) as LM_Live_stores_GROWTH

from (select
ph.brand,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.order_id end) as LM1_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.order_id end) as LM2_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price end) as LM1_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price end) as LM2_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price/1.18 end) as LM1_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price/1.18 end) as LM2_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.customer_id end) as LM1_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.customer_id end) as LM2_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then ph.product_id end) as LM1_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then ph.product_id end) as LM2_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then sc.store_id end) as LM1_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then sc.store_id end) as LM2_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 4 desc
limit 20

Question3:-Top 50 Products Report: Explore LM performance at the product level, including GMV contributions and associated brand insights.

select 
x.product,
x.brand,

coalesce(x.LM2_orders,0) as LM_orders,
coalesce(round(((x.LM2_orders-x.LM1_orders)/nullif(x.LM1_orders,0)*100),1),0) as LM_ORDERS_GROWTH,

coalesce(x.LM2_GMV,0) as LM_GMV,
coalesce(round(((x.LM2_GMV-x.LM1_GMV)/nullif(x.LM1_GMV,0)*100),1),0) as LM_GMV_GROWTH,

coalesce(round(x.LM2_Revenue,2),0) as LM2_Revenue,
coalesce(round(((x.LM2_Revenue-x.LM1_Revenue)/nullif(x.LM1_Revenue,0)*100),1),0) as LM_Revenue_GROWTH,

coalesce(x.LM2_customers,0) as LM_Customers,
coalesce(round(((x.LM2_customers-x.LM1_customers)/nullif(x.LM1_customers,0)*100),1),0) as LM_Customers_GROWTH,

coalesce(x.LM2_Live_products,0) as LM_Live_Products,
coalesce(round(((x.LM2_Live_products-x.LM1_Live_products)/nullif(x.LM1_Live_products,0)*100),1),0) as LM_Live_products_GROWTH,

coalesce(x.LM2_Live_stores,0) as LM_Live_stores,
coalesce(round(((x.LM2_Live_stores-x.LM1_Live_stores)/nullif(x.LM1_Live_stores,0)*100),1),0) as LM_Live_stores_GROWTH

from (select
ph.product,
ph.brand,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.order_id end) as LM1_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.order_id end) as LM2_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price end) as LM1_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price end) as LM2_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price/1.18 end) as LM1_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price/1.18 end) as LM2_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.customer_id end) as LM1_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.customer_id end) as LM2_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then ph.product_id end) as LM1_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then ph.product_id end) as LM2_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then sc.store_id end) as LM1_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then sc.store_id end) as LM2_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1,2) as x
order by 5 desc
limit 50

Question4:-

select 
x.storetype_id,

coalesce(x.LM2_orders,0) as LM_orders,
coalesce(round(((x.LM2_orders-x.LM1_orders)/nullif(x.LM1_orders,0)*100),1),0) as LM_ORDERS_GROWTH,

coalesce(x.LM2_GMV,0) as LM_GMV,
coalesce(round(((x.LM2_GMV-x.LM1_GMV)/nullif(x.LM1_GMV,0)*100),1),0) as LM_GMV_GROWTH,

coalesce(round(x.LM2_Revenue,2),0) as LM2_Revenue,
coalesce(round(((x.LM2_Revenue-x.LM1_Revenue)/nullif(x.LM1_Revenue,0)*100),1),0) as LM_Revenue_GROWTH,

coalesce(x.LM2_customers,0) as LM_Customers,
coalesce(round(((x.LM2_customers-x.LM1_customers)/nullif(x.LM1_customers,0)*100),1),0) as LM_Customers_GROWTH,

coalesce(x.LM2_Live_products,0) as LM_Live_Products,
coalesce(round(((x.LM2_Live_products-x.LM1_Live_products)/nullif(x.LM1_Live_products,0)*100),1),0) as LM_Live_products_GROWTH,

coalesce(x.LM2_Live_stores,0) as LM_Live_stores,
coalesce(round(((x.LM2_Live_stores-x.LM1_Live_stores)/nullif(x.LM1_Live_stores,0)*100),1),0) as LM_Live_stores_GROWTH

from (select
sc.storetype_id,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.order_id end) as LM1_orders,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.order_id end) as LM2_orders,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price end) as LM1_GMV,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price end) as LM2_GMV,

sum(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.selling_price/1.18 end) as LM1_Revenue,
sum(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.selling_price/1.18 end) as LM2_Revenue,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then od.customer_id end) as LM1_customers,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then od.customer_id end) as LM2_customers,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then ph.product_id end) as LM1_Live_products,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then ph.product_id end) as LM2_Live_products,

count(distinct case when od.order_date between '2024-11-01' and '2024-11-30' then sc.store_id end) as LM1_Live_stores,
count(distinct case when od.order_date between '2024-12-01' and '2024-12-31' then sc.store_id end) as LM2_Live_stores

from projectsupermart.supermart.order_details as od
join projectsupermart.supermart.product_hierarchy as ph on od.product_id=ph.product_id
join projectsupermart.supermart.store_cities as sc on od.store_id = sc.store_id
group by 1) as x
order by 1
