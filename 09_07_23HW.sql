
-- 1) найдите имя и фамилию пользователей, у которых нет заказов

select name,lastname
from customers
where id not in (
	select distinct customerid
	from orders
);

-- 2) найдите название товаров, которые ни разу не заказывали


select title 
from products
where id not in (
	select distinct productid
	from orders
);

-- 3) найдите название товаров, которые ни разу не заказывали онлайн

select title 
from products
where id not in (
	select distinct productid
	from orders
    where ordertype <> 'online'
);

-- 4) найдите имя и фамилию покупателя, который сделал самый дорогой заказ
-- запрос найдет одного покупателя - т к в задании стоит покупатель в единственном числе 


select name,lastname
from customers t1
join (select customerid, max(t1.product_count*t2.price) as sum
from orders t1
left join products t2
on t1.productid=t2.id
group by customerid
order by sum desc
limit 1) t2
on t1.id=t2.customerid
; 

-- 4) найдите имя и фамилию покупателя, который сделал самый дорогой заказ
--  найдет много покупателей имеющих максимальній заказ 
select name,lastname
from customers
where id in (
	select customerid
	from(
		select customerid, t1.product_count*t2.price as sum
		from orders t1
		left join products t2
		on t1.productid=t2.id
		having sum in (
			select max(tt1.product_count*tt2.price)
			from orders tt1
			left join products tt2
			on tt1.productid=tt2.id
		) 
	) c1
);

