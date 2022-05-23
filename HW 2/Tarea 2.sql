



create table contactos (
	contacto_id numeric(4,0) constraint pk_contactos primary key,
	nombre varchar(50) not null,
	email varchar(100) not null

);

create sequence contactos_id_contacto_seq start 1 increment 1;
alter table contactos alter column contacto_id set default nextval('contactos_id_contacto_seq');

INSERT INTO contactos(nombre,email) VALUES
 ('Wanda Maximoff','wanda.maximoff@avengers.org')
,('Pietro Maximoff','pietro@mail.sokovia.ru')
,('Erik Lensherr','fuck_you_charles@brotherhood.of.evil.mutants.space')
,('Charles Xavier','i.am.secretely.filled.with.hubris@xavier-school-4-gifted-youngste.')
,('Anthony Edward Stark','iamironman@avengers.gov')
,('Steve Rogers','americas_ass@anti_avengers')
,('The Vision','vis@westview.sword.gov')
,('Clint Bartonthunder-^_^@royalty.asgard.gov')
,('Logan','wolverine@cyclops_is_a_jerk.com')
,('Ororo Monroe','ororo@weather.co')
,('Scott Summers','o@x')
,('Nathan Summers','cable@xfact.or')
,('Groot','iamgroot@asgardiansofthegalaxyledbythor.quillsux')
,('Nebula','idonthaveelektras@complex.thanos')
,('Gamora','thefiercestwomaninthegalaxy@thanos.')
,('Rocket','shhhhhhhh@darknet.ru');


--No hay 1 sola forma de validar email, pero de las q investigue esta me parece las mas prudente y directa

SELECT * FROM contactos WHERE email NOT LIKE '%_@__%.__%';



