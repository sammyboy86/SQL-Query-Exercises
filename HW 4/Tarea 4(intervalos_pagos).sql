



--1. promedio (human-readable) tiempo entre cada pago por cliente de Sakila
--funcion q calcula promedio en dias 
create or replace function average_days_between_payments(id int)
	returns float
	language plpgsql as
	$func$
	declare
	first_date date;
	last_date date;
	total_count float;
	begin
	
		select count(*) 
		into total_count
		from payment p
		where customer_id = id
		group by customer_id;
	
		select payment_date
		into first_date
		from payment p
		where p.customer_id = id
		order by 1 asc limit 1;
	
		select payment_date
		into last_date
		from payment p
		where p.customer_id = id
		order by 1 desc limit 1;
		
		return ((last_date::date-first_date::date )/(total_count-1));

	end
	$func$;

--tabla customer - promedio en dias
create table promedio as
	select customer_id, concat(c.first_name, ' ', c.last_name), average_days_between_payments(c.customer_id)
	from customer c;

select * from promedio;

--histograma
drop table histogram;
create table histogram as 
select floor(average_days_between_payments) as average_days, count(*) as number_of_clients
     from promedio
     group by 1
     order by 1;

select * from histogram;
--podemos ver que tiene dos cimas, por lo tanto no sigue una sola distribucion normal.

--3. Qué tanto difiere ese promedio del tiempo entre rentas por cliente?

create or replace function average_days_between_rents(id int)
	returns float
	language plpgsql as
	$func$
	declare
	first_date date;
	last_date date;
	total_count float;
	begin
	
		select count(*) 
		into total_count
		from rental r
		where customer_id = id
		group by customer_id;
	
		select rental_date
		into first_date
		from rental r
		where r.customer_id = id
		order by 1 asc limit 1;
	
		select rental_date
		into last_date
		from rental r
		where r.customer_id = id
		order by 1 desc limit 1;
		
		return ((last_date::date-first_date::date )/(total_count-1));

	end
	$func$;

--tabla customer - promedio en dias
drop table promedio_rents;

create table promedio_rents as
	select customer_id, concat(c.first_name, ' ', c.last_name), average_days_between_rents(c.customer_id)
	from customer c;

select * from promedio_rents;
select * from promedio;


create table histogram_rents as 
select floor(average_days_between_rents) as average_days, count(*) as number_of_clients
     from promedio_rents
     group by 1
     order by 1;
    
select * from histogram_rents;

    
create or replace function average_days_from_histogram()
	returns float
	language plpgsql as
	
	$func$
	declare
	total_days_sum float;
	total_clients float;
	begin
	
		select sum(average_days*number_of_clients)
		into total_days_sum
		from histogram h;
	
		select sum(number_of_clients)
		into total_clients
		from histogram h;
		
		return (total_days_sum/total_clients);

	end
	$func$;

select * from average_days_from_histogram();

create or replace function varianza_from_histogram()
	returns float
	language plpgsql as
	$func$
	declare
	second_centered_moment float;
	average float;
	total_clients float;

	begin
		
		select * 
		into average
		from average_days_from_histogram();
	
		select sum(number_of_clients)
		into total_clients
		from histogram h;
			
		select sum((average_days-average)*(average_days-average))
		into second_centered_moment
		from histogram h;
	
		return second_centered_moment/total_clients;

	end
	$func$;

select * from varianza_from_histogram();

--las rentas y los pagos se hacen los mismos días, el inciso 3 es trivial.

select * from rental;
select * from payment;

	
	

