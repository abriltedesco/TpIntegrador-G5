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


#2 
DELIMITER //
CREATE FUNCTION cerrarPublicacion (p_idPublicacion INT, p_idUsuario INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_idVendedor INT;
    DECLARE v_pendientes INT;
    DECLARE resultado VARCHAR(100);
 
    SELECT idUsuarioV INTO v_idVendedor
    FROM publicacion
    WHERE idPublicacion = p_idPublicacion;
 
    IF v_idVendedor != p_idUsuario THEN
        SET resultado = 'Error: Usuario no autorizado';
        RETURN resultado;
    END IF;
 
	SELECT COUNT(*) INTO v_pendientes
    FROM compra
    WHERE idPublicacion = p_idPublicacion
	AND (satisfaccionC IS NULL OR satisfaccionV IS NULL);
 
    IF v_pendientes > 0 THEN
        SET resultado = 'Error: Hay calificaciones pendientes';
    ELSE
        SET resultado = 'OK: Se puede cerrar la publicación';
        UPDATE publicacion SET idEstado = 11 WHERE idPublicacion = p_idPublicacion;
    END IF;
 
    RETURN resultado;
END//
DELIMITER ;
select cerrarPublicacion(9,12);
select e.nombre from publicacion p join estado e on p.idEstado = e.idEstado
where idPublicacion = 9 ;
select cerrarPublicacion(13,12);
select idUsuarioV FROM publicacion WHERE idPublicacion = 12;

#3
DELIMITER //
CREATE FUNCTION eliminarProducto (productoId INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    DECLARE mensaje VARCHAR(100);
 
    SELECT COUNT(*) INTO cantidad
    FROM publicacion
    WHERE idProducto = productoId;
 
    IF cantidad > 0 THEN
        SET mensaje = "No se puede eliminar ya que el producto está en una publicación";
    ELSE
        SET mensaje = "Se eliminó correctamente";
        DELETE FROM producto WHERE idProducto = productoId;
    END IF;
 
    RETURN mensaje;
END//
DELIMITER ;

select eliminarProducto(40);

#4

DELIMITER //
CREATE FUNCTION pausarPublicacion (idPub INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  DECLARE existe INT;
 
  SELECT COUNT(*) INTO existe
  FROM publicacion
  WHERE idPublicacion = idPub;
 
  IF existe = 0 THEN
    RETURN "La publicación no existe";
  END IF;
 
  UPDATE publicacion
  SET idEstado = 12
  WHERE idPublicacion = idPub;
 
  RETURN 'Publicación pausada exitosamente.';
END//
DELIMITER ;
select pausarPublicacion(97);
select e.nombre from publicacion p join estado e on p.idEstado = e.idEstado
where idPublicacion = 2 ;

drop function pujarProducto;
DELIMITER //
CREATE FUNCTION pujarProducto(id_publicacion INT)
RETURNS VARCHAR (45)
DETERMINISTIC
BEGIN
	DECLARE publicacion_activa boolean default 0;
	DECLARE esSubasta int;
    DECLARE mensaje varchar(45) default "publicacion inactiva" ;
    
	select estaActiva, subastaId into publicacion_activa, esSubasta from publicacion
    WHERE idPublicacion = id_publicacion ;
    
    IF esSubasta IS NULL THEN
		set mensaje = "no se trata de una subasta";
	ELSE IF publicacion_activa AND esSubasta IS NOT NULL THEN
		SET mensaje = "pujado satisfactoriamente";
   END IF;
   END IF;
   
   RETURN mensaje;
END //
DELIMITER ;
SELECT pujarProducto(34);

#6

DELIMITER //
CREATE FUNCTION eliminarCategoria(idCat INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  DECLARE publicaciones INT;
 
  SELECT COUNT(*) INTO publicaciones
  FROM publicacion
  WHERE idCategoria = idCat;
 
  IF publicaciones > 0 THEN
    RETURN "No se puede eliminar la categoría ya que tiene publicaciones.";
  END IF;
 
  DELETE FROM categoria WHERE idCategoria = idCat;
 
  RETURN "Categoría eliminada";
END//
DELIMITER ;
# probando con nueva categoria q no tenga ningun post asociado
INSERT INTO categoria value(11, "dePrueba");
select eliminarCategoria(11);
# probando con una q existe y tiene post asociados
select eliminarCategoria(1);

#b 7
DELIMITER //
CREATE FUNCTION puntuarComprador(idPub INT, idVendedor INT, nuevaPunt INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  DECLARE vendedorPub INT;
  DECLARE compradorID INT;
 
  SELECT idUsuarioV INTO vendedorPub
  FROM publicacion
  WHERE idPublicacion = idPub;
 
  IF vendedorPub IS NULL THEN
    RETURN "La publicación no existe";
  END IF;
 
  IF vendedorPub != idVendedor THEN
    RETURN "El usuario no es el vendedor de la publicación";
  END IF;
 
  SELECT idComprador INTO compradorID
  FROM compra
  WHERE idPublicacion = idPub;
 
  IF compradorID is null THEN
    RETURN "No tiene ventas";
  END IF;
  
  IF nuevaPunt > 5 THEN
	RETURN "calificacion invalida";
  END IF;
 
 
 # ACLARACION (x) : SATISFACCION V ES LA PUNTUACION HACIA EL VENDEDOR Y SATISFACCION C AL COMPRADOR
  UPDATE compra
  SET satisfaccionC = nuevaPunt
  WHERE idPublicacion = idPub;
 
  RETURN "Se ha actualilizado la calificacion";
END//
DELIMITER ;

SELECT idUsuarioV, idComprador, p.idPublicacion, 
satisfaccionV, satisfaccionC from publicacion p
join compra c ON p.idPublicacion = c.idPublicacion;
select puntuarComprador(17, 15, 3);
select puntuarComprador(12, 15, 5);
select puntuarComprador(54353, 15, 2);
select puntuarComprador(12, 15, 6);
