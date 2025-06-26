# ARCHIVO CON TODOS LOS EJERCICIOS 

# ACLARACIONES :
/* A. en los tests estan subidos los archivos con calls, consultas de prueba para ir resolviendo ejercicios */ 
/* B. nos olvidamos de poner auto increment, para no borrar todo y tener que volver a rehacer los inserts
hicimos funciones que hagan lo mismo */
/* C. algo que quizas es confuso es que pusimos las calificaciones/puntuaciones como "satisfaccion" 
porque asi lo decia el enunciado, el que es SATISFACCION V se esta refieriendo a la puntuacion que el
COMPRADOR le dio al VENDEDOR, o sea es la calificacion que recibe el vendedor por como realiza su tarea y por ende
SATISFACCIONC se refiere a la puntuacion que el VENDEDOR le dio al COMPRADOR */
 
delimiter //
create function crearSubasta() returns int deterministic
begin
	declare idNuevo int;
	SELECT max(idSubasta) INTO idNuevo FROM subasta;
    return idNuevo + 1;
end // 
delimiter ;

delimiter //
create function crearIdProd() returns int deterministic
begin
	declare idNuevo int;
	SELECT max(idProducto) INTO idNuevo FROM producto;
    return idNuevo + 1;
end // 
delimiter ;

delimiter //
create function crearIdVenta() returns int deterministic
begin
	declare idNuevo int;
	SELECT max(idVentaDirecta) INTO idNuevo FROM ventaDirecta;
    return idNuevo + 1;
end // 
delimiter ;

delimiter //
create function crearIdPublicacion() returns int deterministic
begin
	declare idNuevo int;
	SELECT max(idPublicacion) INTO idNuevo FROM publicacion;
    return idNuevo + 1;
end // 
delimiter ;


#                                            ------------- STORED PROCEDURES -------------

/* 1. Definir un procedimiento buscarPublicacion que reciba el nombre de un producto y
muestre todas las publicaciones en las cuales está incluido ese producto. Mostrando el
id_publicacion, nombre producto, nombre categoría a la que pertenece y el precio de
publicación. */
delimiter //
create procedure buscarPublicacion (in nombreProducto varchar(45))
begin
    SELECT idPublicacion, nombreProducto, c.nombre as nombreCategoria, precio 
    FROM publicacion JOIN categoria c ON c.idCategoria 
    WHERE idProducto = (SELECT idProducto FROM producto WHERE nombre = nombreProducto);
end // 
delimiter ;
-- call buscarPublicacion("Smartphone Samsung S22");

/* 2. Definir un procedimiento crearPublicacion que reciba los datos de la publicación e
inserte una fila en la tabla publicación. Además tiene que recibir el tipo de publicación,
es una subasta o una venta directa */
delimiter //
create procedure crearPublicacion
(in idU int, in idC int, in nomProd varchar(45), in precio float, in tipo varchar(30))
begin
	declare idSubasta int default 0;
	declare idPost int default 0;
	declare idProd int default 0;
    
    SELECT idProducto INTO idProd FROM producto WHERE nombre = nomProd;
    
	set idPost = crearIdPublicacion();
	IF tipo = "venta" THEN
		INSERT INTO publicacion VALUE
        (idPost, idU, idC, idProd, precio, 1, current_date(), 10, "Bronce", NULL);
		-- estado "10" de default pq es el "completado" como para decir que esta completo el post
        -- asumimos tambien en un principio que es bronce el post
    ELSE
        set idSubasta = crearSubasta();
		INSERT INTO publicacion VALUE
        (idPost, idU, idC, idProd, precio, 1, current_date(), 10, "Bronce", idSubasta);
	END IF;
end //
delimiter ;

delimiter //
create procedure crearProducto(nombre varchar(45), descripcion longtext)
begin
	INSERT INTO producto values (crearIdProd(), nombre, descripcion);
end //
delimiter ;
-- call crearPublicacion(3, 9, "Acrilico Eterna Violeta", 500.50, "venta");
-- call crearProducto("Acrilico Eterna Violeta", "pintura acrilica de la marca eterna, color violeta");

/* 3. Crear un procedimiento llamado verPreguntas que muestre todas las preguntas de una
publicación. */
delimiter // 
create procedure verPreguntas (in idP int)
begin
	SELECT pregunta FROM comentario where idPublicacion = idP;
end//
delimiter ;
-- call verPreguntas(1);

/* 4. Crear un procedimiento actualizarReputacionUsuarios que para cada usuario calcule el
promedio de las calificaciones recibidas en las ventas realizadas (tanto como vendedor
y comprador) y actualice el campo reputación con ese promedio (en escala 0-100).
Usar cursores */ 
delimiter // 
create function promedioCalificaciones(usuario int, tipoUser varchar (45))
returns float deterministic
begin
	declare promedio float default 0;
    IF tipoUser = "comprador" THEN
		SELECT avg(satisfaccionC) into promedio FROM compra 
		WHERE idComprador = usuario;
	ELSE
		SELECT avg(satisfaccionV) into promedio FROM compra c
        JOIN publicacion p ON p.idPublicacion = c.idPublicacion
		WHERE idUsuarioV = usuario;
	END IF;
    return promedio;
end // 
delimiter ;

SELECT promedioCalificaciones(9, "comprador");

delimiter // 
create function calif_a_rep(promedio float)
returns int deterministic
begin
	declare reputation int default 0.0;
		set reputation = 100 / (5 - promedio);
        if reputation > 100 then
			set reputation = 100;
		end if;
        -- 20 de rep si avg aprox 1, 40 si avg aprox 2, etc etc
	return reputation;
end // 
delimiter ;

delimiter //
create procedure actualizarReputacionUsuarios()
begin
	declare hayFilas int default 1;
    declare vendedorObtenido int;
    declare compradorObtenido int;
    declare promedioCV float;
    declare promedioCC float;
    
    DECLARE userCursor CURSOR FOR
		SELECT idUsuarioV, idComprador FROM publicacion p JOIN compra c ON c.idPublicacion = p.idPublicacion;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET hayFilas = 0;
    
    OPEN userCursor;
		cLoop:loop
			FETCH userCursor INTO vendedorObtenido, compradorObtenido;
				IF hayFilas = 0 THEN
					leave cLoop;
				END IF;
				
                set promedioCV = promedioCalificaciones(vendedorObtenido, "vendedor");
                set promedioCC = promedioCalificaciones(compradorObtenido, "comprador");
				UPDATE usuario SET reputacion = calif_a_rep(promedioCV) WHERE idUsuario = vendedorObtenido;
				UPDATE usuario SET reputacion = calif_a_rep(promedioCC) WHERE idUsuario = compradorObtenido;
        end loop cLoop;
    CLOSE userCursor;
end //
delimiter ;

#                                           ------------- STORED FUNCTIONS -------------
/* 1) Crear la función comprarProducto que debe recibir un usuario comprador, una publicación, un medio de pago y un tipo de envío. Tiene que verificar que la publicación
este activa, si no lo esta devuelve un mensaje ‘La publicación no está activa’. Si está activa verifica que se trate de una compra y no de una subasta. Si es una subasta
devuelve el mensaje ‘Es una subasta’ y sino hace las modificaciones e inserts correspondientes */
delimiter //
create function comprarProducto(idUsuarioComprador int, id_Publicacion int, idMetodoPago int, idMetodoEnvio int) returns text deterministic
begin
	declare mensaje text default "-";
    declare actividad boolean default 0;
    declare esVentaDirecta boolean default 0;
    declare esSubasta int;
    declare idVenta int;
    
    select subastaId INTO esSubasta from publicacion where idPublicacion = id_Publicacion;
    
    IF esSubasta IS NULL THEN 
		set esVentaDirecta = 1;
	END IF;
    
    select estaActiva INTO actividad from publicacion
    where idPublicacion = id_Publicacion;
    
	if actividad = 1 AND esVentaDirecta then
		UPDATE publicacion set estaActiva = 0
		WHERE publicacion.idPublicacion = id_Publicacion;
		UPDATE publicacion set estado = 11
		WHERE publicacion.idPublicacion = idPublicacion;
        set idVenta = crearIdVenta();
        insert into ventaDirecta value(idVenta, idMetodoPago, idMetodoEnvio);
		INSERT INTO compra VALUE (idPublicacion, idVenta, idUsuarioComprador, null, null);
		set mensaje = "Se ha actualizado el estado de la publicación";
    else if actividad = 1 and esVentaDirecta = 0 then
		set mensaje = "La publicación es una subasta ";
	else if actividad = 0 then
		set mensaje = "no esta activa.";
    end if;
    end if;
    end if;
    return mensaje;
end//
delimiter ;
-- select comprarProducto(1, 5, 1, 1);


/* 2. Crear la función cerrarPublicacion que debe cambiar el estado de la publicación a Finalizada. La función tiene que verificar que el usuario recibido por parámetro
coincida con el usuario vendedor cargado en la publicación ya que solo el usuario vendedor puede cerrar la publicación. También tiene que verificar que no tenga
calificaciones pendientes. */ 
delimiter //
create function cerrarPublicacion (p_idPublicacion INT, p_idUsuario INT) returns varchar(100) deterministic
begin
    DECLARE v_idVendedor INT;
    DECLARE v_pendientes INT;
    DECLARE resultado VARCHAR(100);
 
    SELECT idUsuarioV INTO v_idVendedor FROM publicacion
    WHERE idPublicacion = p_idPublicacion;
 
    IF v_idVendedor != p_idUsuario THEN
        SET resultado = 'Error: Usuario no autorizado';
        RETURN resultado;
    END IF;
 
	SELECT COUNT(*) INTO v_pendientes FROM compra
    WHERE idPublicacion = p_idPublicacion
	AND (satisfaccionC IS NULL OR satisfaccionV IS NULL);
 
    IF v_pendientes > 0 THEN
        SET resultado = 'Error: Hay calificaciones pendientes';
    ELSE
        SET resultado = 'OK: Se puede cerrar la publicación';
        UPDATE publicacion SET idEstado = 11 WHERE idPublicacion = p_idPublicacion;
    END IF;
 
    RETURN resultado;
end//
delimiter ;
-- select cerrarPublicacion(9,12);

/* 3. Crear la función eliminarProducto que debe eliminar un producto para lo cual verifica que el producto no esté asociado a ninguna publicación devolviendo el mensaje
correspondiente en cada caso. */
delimiter //
create function eliminarProducto (productoId INT) returns varchar(100) deterministic
begin
    DECLARE cantidad INT;
    DECLARE mensaje VARCHAR(100);
 
    SELECT COUNT(*) INTO cantidad FROM publicacion
    WHERE idProducto = productoId;
 
    IF cantidad > 0 THEN
        SET mensaje = "No se puede eliminar ya que el producto está en una publicación";
    ELSE
        SET mensaje = "Se eliminó correctamente";
        DELETE FROM producto WHERE idProducto = productoId;
    END IF;
 
    RETURN mensaje;
end //
delimiter ;
-- select eliminarProducto(40);

/* 4. Crear la función pausarPublicacion que debe verificar la existencia de la publicación recibida por parámetro y le cambia el estado a Pausad */
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
-- select pausarPublicacion(97);


/* 5. Crear la función pujarProducto que debe verificar que la publicación esté activa y que corresponda a una subasta. Si no suceden estas dos cosas devuelve el mensaje
apropiado. Si se cumplen esas dos condiciones actualiza la tabla de subasta con los parámetros recibidos y devuelve el mensaje ‘pujado satisfactoriamente’ */
delimiter //
create function pujarProducto(id_publicacion int, monto_a_ofertar float, idUsuario int) returns varchar (45) deterministic
begin
	DECLARE publicacion_activa boolean default 0;
	DECLARE esSubasta int;
	declare id_historial int;
    DECLARE mensaje varchar(45) default "publicacion inactiva" ;
    
	select estaActiva, subastaId into publicacion_activa, esSubasta from publicacion
    WHERE idPublicacion = id_publicacion ;
    
    IF esSubasta IS NULL THEN
		set mensaje = "no se trata de una subasta";
	ELSE IF publicacion_activa AND esSubasta IS NOT NULL THEN
		/* actualiza tabla subasta ???  PREGUNTAR A QUE OPCION SE REFIERE !!!!*/ 
			   /* A) crear historial para subasta para ponerle un monto a ofertar a esa subasta tipo
			   set id_historial = crearIdHistorial();
			   INSERT INTO historial VALUE(id_historial, monto_a_ofertar, idUsuario, current_date(), esSubasta); */
			   /* B) agregar o eliminar producto*/
		SET mensaje = "pujado satisfactoriamente";
   END IF;
   END IF;
   
   RETURN mensaje;
end //
delimiter ;
-- SELECT pujarProducto(34);

/* 6. Crear la función eliminarCategoria que debe verificar que no haya ninguna publicación para esa categoría y la elimina devolviendo el mensaje correspondiente en cada caso. */
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

/* 7. Crear la función puntuarComprador que debe verificar que exista la venta y que el usuario recibido por parámetro sea el usuario vendedor. Si se cumplen las dos
condiciones actualiza la calificación del comprador y devuelve un mensaje. Si no devuelve el mensaje de error. */
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
 
 
 # ACLARACION (C) : SATISFACCION V ES LA PUNTUACION HACIA EL VENDEDOR Y SATISFACCION C AL COMPRADOR
  UPDATE compra
  SET satisfaccionC = nuevaPunt
  WHERE idPublicacion = idPub;
 
  RETURN "Se ha actualilizado la calificacion";
END//
DELIMITER ;

/* 8. Crear la función responderPregunta que debe verificar que el id_vendedor recibido sea el id_vendedor asociado a la publicación sobre la cual se quiere responder, si es así se
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
-- SELECT responderPregunta(16, 13, "Es de acero inoxidable");


#                                                 ------------- VISTAS ------------- 
/* 1) Crear una vista que muestre todas las preguntas de publicaciones activas que aún no
tengan respuesta, incluyendo: id de la pregunta, la descripción, la publicación a la que
pertenece, el nombre del producto y el nombre del usuario que respondió. */
create view preguntasSinRespuesta as
select  comentario.*, idProducto from comentario 
join publicacion on publicacion.idPublicacion = comentario.idPublicacion
where respuesta IS NULL;
-- SELECT * FROM preguntasSinRespuesta;

/* 2) Crear una vista que muestre un top 10 de categorías más presentes en publicaciones de
esta semana. */
create view topCategoriasEstaSemana as
select categoria.idCategoria, categoria.nombre, count(categoria.idCategoria) as cantidad from publicacion
join categoria on publicacion.idCategoria = categoria.idCategoria
where week(fechaPublicacion) = week(current_date())
group by 1,2 
order by cantidad desc
limit 10;
-- SELECT * FROM topCategoriasEstaSemana;

/* 3) Crear una vista que muestre las publicaciones que se encuentran en tendencia el día de
hoy. Estas serán las que tengan mayor cantidad de preguntas */
create view publicacionesTendenciaHoy as
select publicacion.idPublicacion, count(pregunta)as cantidad, idProducto, 
precio, fechaPublicacion from comentario
join publicacion on comentario.idPublicacion = publicacion.idPublicacion
where fechaPublicacion = current_date()
group by 1
order by cantidad desc
limit 10;

-- UPDATE publicacion SET fechaPublicacion = current_date() WHERE idPublicacion = 1;
-- SELECT * FROM publicacionesTendenciaHoy;

/* 4) Crear una vista que muestre el nombre del vendedor con mayor reputación por
categoría. Se debe mostrar nombre del vendedor y nombre de la categoría */

#                                           ------------- EVENTOS -------------

/* 1) Crear un evento que se ejecute una vez por semana y elimine todas las publicaciones
que estén pausadas y hayan sido creadas hace más de 90 días */
delimiter //
create event eliminarPublicacionesPausadas on schedule EVERY 1 week starts now() do
begin  
	delete from publicacion
	where idEstado = 12
	and fechaPublicacion > subdate(fechaPublicacion, interval 90 day);
end//
delimiter ;

/* 2) Crear un evento que se ejecute diariamente y marque como “observadas” las
publicaciones activas de tipo venta directa que no tienen configurado un medio de
pago. */
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

#                                           ------------- TRIGGERS ------------
/* 1) Crear un trigger borrarPreguntas que antes de borrar una fila en la tabla de publicación
borre todas las preguntas en la tabla de preguntas. */
delimiter //
CREATE TRIGGER borrarPreguntas BEFORE DELETE ON publicacion FOR EACH ROW
BEGIN
	DELETE FROM comentario WHERE idPublicacion = (old.idPublicacion);
END //
delimiter ;
-- DELETE FROM publicacion WHERE idPublicacion = ;

/* 2) Crear un trigger calificar que después de hacer un update en la tabla venta verifique
que la calificación del vendedor y del comprador sea distinta de null. Si es así actualiza
con esos datos la calificación del usuario en base a la calificación de esa venta. */
delimiter //
CREATE TRIGGER calificar_after_update AFTER UPDATE ON compra FOR EACH ROW
BEGIN 
	DECLARE calificacion_comprador INT ;
	DECLARE calificacion_vendedor INT ;
	DECLARE idVendedor INT ;
	DECLARE promedioV FLOAT ;
	DECLARE promedioC FLOAT ;
    
    set calificacion_comprador = new.satisfaccionC;
    set calificacion_vendedor = new.satisfaccionV;
    
	SELECT idUsuarioV INTO idVendedor
    FROM compra c JOIN publicacion p on p.idPublicacion = c.idPublicacion
    WHERE p.idPublicacion = (new.idPublicacion);
    
    set promedioV = promedioCalificaciones(idVendedor, "vendedor");
    set promedioC = promedioCalificaciones(new.idComprador, "comprador");
    
	IF calificacion_comprador IS NOT NULL AND calificacion_vendedor IS NOT NULL THEN
		UPDATE usuario SET reputacion = calif_a_rep(promedioV) WHERE idUsuario = idVendedor;
		UPDATE usuario SET reputacion = calif_a_rep(promedioC) WHERE idUsuario = (new.idComprador);
    END IF;
END //
delimiter ;

/* 3) Crear un trigger cambiarCategoria que después de insertar en la tabla de venta
actualice la categoría de usuario. */
delimiter //
create function cantVentas(id_usuario int) returns int deterministic 
begin
	declare cant int default 0;
    SELECT count(*) into cant FROM compra c
    JOIN publicacion p ON p.idPublicacion = c.idPublicacion  
    WHERE idUsuarioV = id_usuario;
    return cant;
end // 
delimiter ;

delimiter //
create function facturacion(id_usuario int) returns float deterministic 
begin
	declare suma float default 0;
    SELECT sum(precio) into suma FROM compra c
	JOIN publicacion p ON p.idPublicacion = c.idPublicacion  
    WHERE idUsuarioV = id_usuario;
    return suma;
end // 
delimiter ;

delimiter //
create procedure actualizarNivel(in id_usuario int)
begin
	IF cantVentas(id_usuario) <= 5 AND cantVentas(id_usuario) > 0 THEN
		UPDATE usuario SET nivel = "Normal" WHERE idUsuario = id_usuario;
	ELSE IF (cantVentas(id_usuario) > 5 AND cantVentas(id_usuario) <= 10) AND facturacion(id_usuario) >= 100000 THEN
		UPDATE usuario SET nivel = "Platinum" WHERE idUsuario = id_usuario;
    ELSE IF cantVentas(id_usuario) > 11 AND facturacion(id_usuario) >= 1000000 THEN
		UPDATE usuario SET nivel = "Gold" WHERE idUsuario = id_usuario;
    END IF;
    END IF;
    END IF;
end // 
delimiter ;

delimiter //
CREATE TRIGGER cambiarCategoria AFTER INSERT ON compra FOR EACH ROW
BEGIN
	declare id_usuario_vendedor int ;
    SELECT idUsuarioV INTO id_usuario_vendedor FROM publicacion
    WHERE idPublicacion = (new.idPublicacion);
	call actualizarNivel(id_usuario_vendedor);
END //
delimiter ;

#                                          ------------- INDICES ------------
/* 1) Crear un índice en la tabla de publicaciones para acelerar la búsqueda por nombre de
producto. */
CREATE INDEX index_producto_nombre ON producto(nombre);
/* 2) Crear un índice para asegurar que no se repitan direcciones de correo electrónico en la
tabla de usuarios. */
ALTER TABLE usuario ADD UNIQUE INDEX index_emails_usuarios (email);
CREATE UNIQUE INDEX index_emails_usuarios ON usuario(email);
/* 3) Crear un índice para optimizar las consultas frecuentes sobre publicaciones activas,
pausadas o finalizadas. */
CREATE INDEX index_publicacion_estado ON publicacion(idEstado);

# ------------- TRANSACCIONES -------------
/* 1. Plantear cómo sería el procedimiento crearPublicacion para que utilice una transacción
que inserte la publicación y, si corresponde, los datos de la subasta. Si alguna inserción
falla, se debe hacer rollback. En caso exitoso se debe devolver un mensaje de éxito. */
delimiter //
CREATE PROCEDURE crearPublicacionTransaccion (in idU int, in idC int, in nomProd varchar(45), in precio float, in tipo varchar(45))
begin
    DECLARE idSubasta int default 0;
    DECLARE idPost int default 0;
    DECLARE idProd  int default 0;
    DECLARE todo_ok boolean default true;

    START TRANSACTION;
	begin
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET todo_ok = false;
        SELECT idProducto INTO idProd FROM producto WHERE nombre = nomProd;
        IF idProd IS NULL THEN
            set todo_ok = false;
        END IF;
    end;

    IF todo_ok THEN
        SET idPost = crearIdPublicacion();
        IF tipo = 'venta' THEN
            INSERT INTO publicacion VALUE (idPost, idU, idC, idProd, precio, 1, CURRENT_DATE(), 10, 'Bronce', NULL);
        ELSE IF tipo = "subasta" then
            SET idSubasta = crearSubasta();
            INSERT INTO publicacion VALUE (idPost, idU, idC, idProd, precio, 1, CURRENT_DATE(), 10, 'Bronce', idSubasta);
        END IF;
        END IF;
    END IF;
    
    IF todo_ok THEN
        COMMIT;
        select 'publicacion creada exitosamente.' as mensaje;
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'error al crear la publicacion/buscar el producto';
    END IF;
end //
delimiter ;

select * from publicacion;
call crearPublicacionTransaccion (3, 9, null, 500.50, "qsy");

/* 2. Realizar lo anterior pero con el procedimiento actualizarReputacionUsuarios. */

delimiter //
create procedure actualizarReputacionUsuariosTransaccion()
begin
    declare hayFilas int default 1;
    declare vendedorObtenido int;
    declare compradorObtenido int;
    declare promedioCV float;
    declare promedioCC float;
    declare todo_ok boolean default true;

    DECLARE userCursor CURSOR FOR
        SELECT p.idUsuarioV, c.idComprador FROM publicacion p
        JOIN compra c ON c.idPublicacion = p.idPublicacion;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET hayFilas = 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    begin
        set todo_ok = false;
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'error en la transacción al actualizar';
    end;

    START TRANSACTION;
    begin
        OPEN userCursor;
        cLoop: loop
            FETCH userCursor INTO vendedorObtenido, compradorObtenido;
            IF hayFilas = 0 THEN
                LEAVE cLoop;
            END IF;

            SET promedioCV = promedioCalificaciones(vendedorObtenido, "vendedor");
            SET promedioCC = promedioCalificaciones(compradorObtenido, "comprador");
            UPDATE usuario SET reputacion = calif_a_rep(promedioCV) WHERE idUsuario = vendedorObtenido;
            UPDATE usuario SET reputacion = calif_a_rep(promedioCC) WHERE idUsuario = compradorObtenido;
        end loop;
        CLOSE userCursor;
    end; 
    
    IF todo_ok THEN
        COMMIT;
        select 'actualización exitosa' as mensaje;
    END IF;

end //
delimiter ;
call actualizarReputacionUsuariosTransaccion();
