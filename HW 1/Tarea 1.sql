--1. contactos de proveedores con posicion de sales representative

select s
from suppliers s where s.contact_title = 'Sales Representative';

--2. contactos de proveedores no son marketing managers

select s
from suppliers s where not s.contact_title = 'Marketing Manager';

--3. ordenes no vienen de clientes en Estados Unidos

select o
from customers c join orders o using (customer_id) 
where not c.country = 'USA';

--4. productos de los que transportamos son quesos

select distinct p
from category c join products p using (category_id) 
join order_details od using (product_id) 
inner join orders o using (order_id)
where o.shipped_date is not null and c.category_id = 4;

--5. ordenes van a Belgica o Francia

select o
from orders o where ship_country = 'Belgium' or ship_country = 'France';

--6. ordenes van a LATAM
-- Venezuela, Mexico, Argentina

select o
from orders o where ship_country in ('Mexico', 'Venezuela', 'Argentina', 'Brazil');


--7. ordenes que no van a LATAM

select o
from orders o where ship_country not in ('Mexico', 'Venezuela', 'Argentina', 'Brazil');

--8. nombres completos de los empleados, nombres y apellidos unidos en un mismo registro

select e.first_name , e.last_name 
from employees e;

--9.  lana tenemos en inventario


select sum(p.units_in_stock*p.unit_price) from products p ;

--10. cuantos clientes por pais

select c.country , count(c.country)
from customers c
group by country;

--CONTINUACION

--11. reporte de edades de los empleados para checar su elegibilidad para seguro de gastos médicos menores


select e.first_name , e.last_name , age(e.birth_date)
from employees e;

--12 orden mas reciente

select c.contact_name , max(o.order_date) 
from orders o join customers c using (customer_id)
group by c.contact_name ;

--13 

select c.contact_title, count(c.contact_title)
from customers c
group by c.contact_title;

--14 productos categoria

select c.category_name , count(c.category_name)
from products p join categories c using (category_id)
group by category_name;

--15 reporte de reorder 
--Use Inventory Reorder Report to list current on hand, purchase order, sales order, and back order quantity information for each selected item. In addition, the report prints a recommended reorder quantity, which is based on the reorder information entered in Item Maintenance. You can print reorder information or actual period-to-date, year-to-date, and prior-year quantities sold.

select o.order_id, p.product_name, p.units_in_stock, od.quantity, p.reorder_level
from products p join order_details od using (product_id) join orders o using (order_id);


--16  a donde mas voluminoso

select od.quantity , o.ship_country 
from orders o join order_details od using(order_id)
order by od.quantity desc limit 1;

--17 


alter table customers
drop column quality;

alter table customers
add column quality varchar(10) default 'medium';

alter table customers
add constraint CK_customer_quality check (quality in ('good', 'medium', 'bad'));

--18 navidad

select e.first_name , e.last_name 
from employees e join orders o using(employee_id)
where extract(month from shipped_date) = 12 and extract(day from shipped_date) in (24,25);

--19

select p.product_name 
from products p join order_details od using (product_id)
join orders o using (order_id)
where extract(month from o.shipped_date) = 12 and extract(day from o.shipped_date) = 25;

--20

select o.ship_country, sum(od.quantity)
from orders o join order_details od using(order_id)
group by ship_country
order by sum(od.quantity) desc limit 1;


