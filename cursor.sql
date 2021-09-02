do $$
declare
        tabla record;
        listado cursor for 	select seguro, sum( aportacion) total
							from tiposeguros as t1 
							inner join contrto as c1 on t1.idseguros = c1.idseguros
							inner join aportaciones as a1 on c1.idcontrato = a1.idcontrato
							group by seguro;							
begin
for tabla in listado loop
Raise notice 'Tipo de seguro: % => Valor recaudado: % $', tabla.seguro, tabla.total;
end loop;
end $$
language 'plpgsql';