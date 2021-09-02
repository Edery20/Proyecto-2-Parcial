CREATE or replace  FUNCTION clientes(varchar)	RETURNS varchar
AS $BODY$
DECLARE
	agente alias for $1;
	datos RECORD;
	lis_datos cursor FOR select c2.nombrecli ||' '||c2.apellidocli as cliente 
							from agente  as a1
							inner join contrto  as c1 on a1.idagente = c1.idagente
							inner join cliente as c2 on c1.idcliente = c2.idcliente
							where a1.apellidocli = $1;		
begin
	for datos in lis_datos loop
	Raise notice 'Cliente: %', datos.cliente;
	end loop;
end; $BODY$
language 'plpgsql';


--selects de comprobacion del prodecimiento almacenado

select clientes('Zambrano');

select clientes('Pincay');

select apellidocli from agente;