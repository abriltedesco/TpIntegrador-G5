
					-- --------------------	/* EVENTOS */  -- --------------------

/*
Crear un evento que se ejecute una vez por semana y elimine todas las publicaciones
que estén pausadas y hayan sido creadas hace más de 90 días
*/

delimiter //
create event eliminarPublicacionesPausadas on schedule EVERY 1 week starts now() do
begin  
	delete from publicacion
	where idEstado = 12
	and fechaPublicacion > subdate(fechaPublicacion, interval 90 day);
end//
delimiter ;

select * from publicacion;
select * from estado;

select * from publicacion
join estado on publicacion.idEstado = estado.idEstado
where estado.nombre = "Pausada"
and fechaPublicacion > subdate(fechaPublicacion, interval 90 day);

select * from publicacion
where idEstado = 12
and fechaPublicacion > subdate(fechaPublicacion, interval 90 day);

select * from publicacion
where fechaPublicacion > subdate(fechaPublicacion, interval 90 day);

-- ----------------------------------------------------------------------------------------------------------------

/*
Crear un evento que se ejecute diariamente y marque como “observadas” las
publicaciones activas de tipo venta directa que no tienen configurado un medio de
pago.
*/

delimiter //
create event marcarObservada on schedule EVERY 1 day starts now() do
begin
	update publicacion
	join compra on publicacion.idPublicacion = compra.idPublicacion
	join ventaDirecta on ventaDirecta.idVentaDirecta = compra.idVentaDirecta
	set publicacion.idEstado = 1
	where ventaDirecta.idMetodoPago IS NULL;
end//
delimiter ;


select * from publicacion
join compra on publicacion.idPublicacion = compra.idPublicacion
join ventaDirecta on ventaDirecta.idVentaDirecta = compra.idVentaDirecta
where ventaDirecta.idMetodoPago IS NULL;

update publicacion
join compra on publicacion.idPublicacion = compra.idPublicacion
join ventaDirecta on ventaDirecta.idVentaDirecta = compra.idVentaDirecta
set publicacion.idEstado = 1
where ventaDirecta.idMetodoPago IS NULL;

select * from ventaDirecta
where ventaDirecta.idMetodoPago IS NULL;

select * from estado
;