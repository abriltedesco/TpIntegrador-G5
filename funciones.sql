							/* FUNCIONES */

/*
Crear la función comprarProducto que debe recibir un usuario comprador, una
publicación, un medio de pago y un tipo de envío. Tiene que verificar que la publicación
este activa, si no lo esta devuelve un mensaje ‘La publicación no está activa’. Si está
activa verifica que se trate de una compra y no de una subasta. Si es una subasta
devuelve el mensaje ‘Es una subasta’ y sino hace las modificaciones e inserts
correspondientes.
*/

delimiter //
create function comprarProducto(idUsuarioComprador int, idPublicacion int, idMetodoPago int, idMetodoEnvio int) returns text deterministic
begin
	declare mensaje text default " ";
    declare actividad boolean default 0;
    declare esVentaDirecta boolean default 1;
    
    set esVentaDirecta = (select subasta_idSubasta from publicacion
    where subasta_idSubasta IS NULL and publicacion.idPublicacion = idPublicacion);
    
    set actividad = (select estaActiva from publicacion
    where publicacion.idPublicacion = idPublicacion);
    
	if actividad = 1 AND esVentaDirecta = 1 then
		update publicacion set estaActiva = 0
		WHERE publicacion.idPublicacion = idPublicacion;
    
		update publicacion set estado = 11
		WHERE publicacion.idPublicacion = idPublicacion;
    
		set mensaje = "Se ha actualizado el estado de la publicación";
    
	end if;
    if actividad = 0 then
		set mensaje = "La publicación no está activa.";
	end if;
    
    if esVentaDirecta = 0 then
		set mensaje = "Es una subasta";
    end if;
    
    return mensaje;
end//
delimiter ;
select comprarProducto(1, 20, 1, 1);
select * from metodoPago;
select * from metodoEnvio;

select * from estado;

select subasta_idSubasta from publicacion
where subasta_idSubasta IS NULL;

select *  from publicacion;

select *  from publicacion 
where subasta_idSubasta IS NOT NULL; /* TODAS LAS SUBASTAS */

select estaActiva from publicacion
where publicacion.idPublicacion = idPublicacion;

select * from publicacion;
