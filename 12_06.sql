
select name, lastname FROM customers
WHERE id NOT IN(
  select distinct customerid FROM orders
);

select title from products
where id not in(
    select distinct productid from orders
);

--- в условии не сказано выводить товары ли которые воообще не заказывалисьб никакa


select title from products
where id not in(
    select distinct productid from orders
      where ordertype = 'online'
);

--- в условии сказано покупателя в единственном числе - первое решение если одного вывести 
--- да и номера заказа как такового нет(есть его id -) - получается все заказы состоят из одной строки 
--- обычно это две таблицы данные заказа и содержание заказа ---  но я  понял что заказы из одной строки

select name, lastname FROM customers
WHERE id = (
	select customerid from orders
		join products on products.id=orders.productid
		order by products.price*orders.product_count desc
	limit 1
);


--- тут решение если может надо вывести всех кто сделал заказ на максимальную сумму

select name, lastname FROM customers
WHERE id in (
	select customerid from orders
	  join products on products.id=orders.productid
	  where price*orders.product_count = (
		select MAX(price*orders.product_count) as maximum from orders
		join products on products.id=orders.productid
  )
);

--- у меня пару вопросов по MS SQL 
--- Добрый вечер
--- Я не могу на всех лекциях присутствовать(языковые курсы Немецкого ) - но просматриваю все в записи и делаю задания 

--- немного о себе т к очно не смог представиться 
 --- Закончил ВТ ДПИ в 1994 году - имел небольшой опыт программирования С++ 
 --- (все перечислять не буду - тк там и  Paskal и fortran  и assembler ). Потом своя 
 --- фирма по продаже компов и прокладке сетей , потом частный бизнесс продажа не 
 --- связанная с компьютерами . Но все время компьютера , сети ,
 --- MS SQL(тут только с помощь MS Access - делал визуальные запросы ) 
 --- и сейчас сервер в облаке - во Франции (что-то крутиться и сопровождается) - очень кратко , 
 --- чтобы не занимать много вашего времени .
 --- так вот я сейчас пыаюсь на JAVA писать конект со своей базой и на MS SQL делать то что было бы полезно по этой задаче 
 --- например - есть пару вопросов - если возможно ?
 
SELECT K1.COD_ARTIC, SELL_K1.SumProdPeriod,K1.MIN_TVRZAP, K1.MAX_TVRZAP
FROM dbo_SCL_ARTC AS K1
 LEFT JOIN [SELECT dbo_SCL_MOVE.NAME_PREDM AS SELL_ARTIC, Sum(dbo_SCL_MOVE.KOLTREB_PR) AS SumProdPeriod 
   FROM dbo_SCL_MOVE LEFT JOIN dbo_SCL_ARTC ON dbo_SCL_MOVE.NAME_PREDM = dbo_SCL_ARTC.COD_ARTIC
   WHERE (((dbo_SCL_MOVE.DATE_PREDM)>#5/14/2023#) AND ((dbo_SCL_MOVE.ID_SCLAD)=1) 
    AND ((dbo_SCL_MOVE.VID_DOC) Like "*РОЗНИЦА" Or (dbo_SCL_MOVE.VID_DOC) Like "МУЛЬТИСБОРКА" 
    Or (dbo_SCL_MOVE.VID_DOC) Like "МУЛЬТИСБОР" Or (dbo_SCL_MOVE.VID_DOC) Like  "РАСХОДНИКИ")
    AND ((dbo_SCL_ARTC.ID_SCLAD)=1))
    GROUP BY dbo_SCL_MOVE.NAME_PREDM, dbo_SCL_ARTC.DOP2_ARTIC, dbo_SCL_MOVE.TYPDOCM_PR
    HAVING (((dbo_SCL_ARTC.DOP2_ARTIC)="Kreul") AND ((dbo_SCL_MOVE.TYPDOCM_PR)="Р"))
]. AS SELL_K1 ON K1.COD_ARTIC = SELL_K1.SELL_ARTIC
WHERE K1.ID_SCLAD=1 AND K1.DOP2_ARTIC="Kreul";

