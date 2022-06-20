--30*21*8 -> medidas de arnes

--5040 cm cubicos, 500g por peli

--Cilindro> peso max: 50kg


--verifiquemos que se cuenten igual los que estan siendo rentados con este query
--no hay saltos en el inventory_id, podemos asumir que son todos los blurays

select *
from inventory i
order by inventory_id asc;

--total de blurays

select count(*)
from inventory i;

--4581

select 50000/500;

-- 100 pelis por cilindro (peso max 50kg)



--asumiendo que los cilindros tendran las peliculas
--acomodadas una a una, para facilitar el movimiento de
--los brazos roboticos

select 8*100 
--nos da largo (800 cm)

--consideremos un cuadrado(30*30) ya que el cilindro debe
--ser lo suficientemente grande como para que quepa
--el lado mas alto del arnes

select sqrt(30*30 + 30*30)/2

--nos da el radio del cilindro (21.2132 cm)

select (3.14159*21.2132*21.2132)*800

--nos da el volumen del cilindro (1,130,972.033 cm cubicos)

--En conclusion las medidas son las siguientes:
--radio: 21.2132 cm
--largo: 800 cm
--volumen: 1,130,972.033 cm cubicos

--veamos cuantas pelis hay por tienda:

select store_id,count(*)
from inventory i
group by store_id ;

--store 1: 2270
--store 2: 2311

select 2270/100;

--necesitamos 23 cilindros para tienda 1


select 2311/100;

--necesitamos 24 cilindros para tienda 2




