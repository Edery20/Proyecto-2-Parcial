--¿Que impida que se le pague el seguro a una persona que a fallecido si debe?
create or replace function pagoSeguro() returns trigger
as $pagoSeguro$
    declare
		ncuotas int;
		naportaciones int;
		fallecido varchar(50);
begin
		select naportes into ncuotas from contrto where idcliente = new.idcliente;		
		select  count( a1.idapotaciones) into naportaciones from contrto  as c1 
											inner join aportaciones as a1 on c1.idcontrato = a1.idcontrato
											inner join cliente as c2 on c1.idcliente = c2.idcliente
											where c2.idcliente = new.idcliente;		
		select motivodefallecimiento into fallecido from fallecimiento where idcliente = new.idcliente;		
        if(ncuotas > naportaciones and fallecido <> '') then
            raise exception 'El cliente aun no ha pagado todos los aportes por ende no se puede pagar el seguro';
        end if;
        return new;
end;
$pagoSeguro$
language plpgsql;

create trigger pagoSeguroTrigger before update
on contrto for each row
execute procedure pagoSeguro();


--pruebas

select * from contrto

update contrto set pagado='si'  where idcliente=36383;