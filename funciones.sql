drop function comprarProducto;
delimiter //
create function comprarProducto(idUsuarioComprador int, idPublicacion int, idMetodoPago int, idMetodoEnvio int) returns text deterministic
begin
	declare mensaje text default "-";
    declare actividad boolean default 0;
    declare esVentaDirecta boolean default 1;
    declare idVenta int;
    set esVentaDirecta = (select subastaId from publicacion
    where subastaId IS NULL and publicacion.idPublicacion = idPublicacion);
    
    set actividad = (select estaActiva from publicacion
    where publicacion.idPublicacion = idPublicacion);
    
	if actividad = 1 AND esVentaDirecta = 1 then
		UPDATE publicacion set estaActiva = 0
		WHERE publicacion.idPublicacion = idPublicacion;
		UPDATE publicacion set estado = 11
		WHERE publicacion.idPublicacion = idPublicacion;
        set idVenta = crearIdVenta();
        insert into ventaDirecta value(idVenta, idMetodoPago, idMetodoEnvio);
		INSERT INTO compra VALUE (idPublicacion, idVenta, idUsuarioComprador, null, null);
		set mensaje = "Se ha actualizado el estado de la publicación";
    else if actividad = 0 then
		set mensaje = "La publicación no está activa.";
	else if esVentaDirecta = 0 then
		set mensaje = "Es una subasta";
	/*else 
		set mensaje = "gdggf";*/
    end if;
    end if;
    end if;
    return mensaje;
end//
delimiter ;
select comprarProducto(1, 1, 1, 1);

/* 8. Crear la función responderPregunta que debe verificar que el id_vendedor recibido sea
el id_vendedor asociado a la publicación sobre la cual se quiere responder, si es así se
agrega la respuesta a la pregunta y devuelve el mensaje correspondiente */

delimiter // 
create function responderPregunta (idVendedor int, id_publicacion int, respuestaVendedor text) returns text  deterministic
begin 
	declare vendedor int;
	declare mensaje text;
	SELECT idUsuarioV into vendedor FROM publicacion WHERE idPublicacion = id_publicacion;
	IF vendedor = idVendedor THEN 
		UPDATE comentario SET respuesta = respuestaVendedor WHERE idPublicacion = id_publicacion;
        set mensaje = "se ha agregado la respuesta exitosamente ";
	ELSE 
		set mensaje = "no es posible agregar la respuesta";
	END IF;
    return mensaje;
end //
delimiter ;

SELECT responderPregunta(16, 13, "Es de acero inoxidable reini");
