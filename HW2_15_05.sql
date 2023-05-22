select 
   id
   ,service_class
   ,price
   ,case
		when price>=10000 and price <=11000
			then 'Economy'
		when price>=20000 and price<=30000
			then 'PremiumEconomy'
		when price > 100000
			then 'Business'
		else 'not category'
		end as category
from tickets;


select 
	side_number
    -- ,production_year
    ,case
		when production_year<2000
			then 'Old'
		when production_year>=2000 and production_year<=2010
			then 'Mid'
		else 'New'
    end as age
from airliners
where range1<10000
order by production_year desc;


select 
	id
    ,trip_id
    ,case 
		when price>=10000 and price <=11000
			then price*0.85
		when price>=20000 and price<=30000
			then price*0.8
		when price > 100000
			then price*0.9
		else price
    end as new_pricee
from tickets
where trip_id IN ("LL4S1G8PQW", "0SE4S0HRRU", "JQF04Q8I9G");