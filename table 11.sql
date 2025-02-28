--------Table 11-- overall==============================

select
x.month,
x.orders,
x.gmv,
x.Revenue,
x.customers,
x.new_customers,
avg(x.orders/x.customers) as Avg_Order_per_Customers,
avg(x.gmv/x.customers) as Avg_gmv_per_Customers,
x.repeat_customers
from(select
x.month,
count(x.order_id) as orders,
sum(x.selling_price) as gmv,
sum(x.selling_price/1.18) as Revenue,
count(x.customer_id) as customers,
count(x.new_customer) as new_customers,
count(rept.customer_id) as repeat_customers
from (select 
concat(EXTRACT(month from od.order_date),'-',EXTRACT(year from od.order_date)) as month,
od.order_id,
od.order_date,
od.customer_id,
od.selling_price,
od.order_date,
newc.customer_id as new_customer
from project7sept.super_mart1.order_details od
left join (select 
order_date,
customer_id,
order_id,
rank() over(partition by customer_id order by order_date) as rnk
from project7sept.super_mart1.order_details) newc
on od.customer_id= newc.customer_id
where rnk = 1) x
left join (select
customer_id
from(select 
order_date,
customer_id,
order_id,
rank() over(partition by customer_id order by order_date) as rnk
from project7sept.super_mart1.order_details) newc
where rnk>1) as rept
on rept.customer_id = x.customer_id
group by 1) x
group by 1,2,3,4,5,6,9

