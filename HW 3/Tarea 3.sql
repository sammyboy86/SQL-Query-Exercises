--Usando la BD de Sakila, y en un script de SQL separado, y en su propio repo de Github, escribir los queries necesarios y suficientes para dar respuesta a las siguientes preguntas:

--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
--Qué cliente ha rentado más de nuestra sección de adultos?
--Qué películas son las más rentadas en todas nuestras stores?
--Cuál es nuestro revenue por store?

--Timestamp límite de entrega: Lunes 16 de Mayo, a las 12:59:59 del medio día.

--1.
select c.customer_id , concat(c.first_name,' ', c.last_name), c.email, co.country 
from customer c join address a using(address_id)
join city ci using(city_id) join country co using(country_id)
where country = 'Canada';

--2. 

select  c.customer_id, concat(c.first_name,' ', c.last_name), f.rating, count(*)
from customer c join rental r using(customer_id)
join inventory i using(inventory_id) join film f using(film_id)
where f.rating in ('NC-17', 'R') 
group by concat(c.first_name,' ', c.last_name),c.customer_id, f.rating
order by 4 desc limit 5;

--3 Qué películas son las más rentadas en todas nuestras stores? (se resuelve aqui como en cada tienda x separado)

select distinct on(store_id) store_id, f.title , count(*)
from store s join inventory i using(store_id) join rental r using(inventory_id)
join film f using(film_id)
group by store_id, f.title
order by 1, 3 desc;

--4 Cuál es nuestro revenue por store?

select s.store_id, c.city,  sum(p.amount)
from city c join address a using (city_id)
join store s using (address_id) join inventory i using(store_id) join rental r using(inventory_id) join payment p using(rental_id)
group by s.store_id, c.city;







