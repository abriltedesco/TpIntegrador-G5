/* para no tener todo los inserts, consultas de prueba y call feochos en el archivo inicial van aca */

/* ejercicio 1 probado, funciono!!! */

delimiter //
CREATE TRIGGER borrarPreguntas BEFORE DELETE ON publicacion FOR EACH ROW
BEGIN
	DELETE FROM comentario WHERE idPublicacion = (old.idPublicacion);
END //
delimiter ;
 -- in idU int, in idC int, in nomProd varchar(45), in precio float, in tipo varchar(30))
call crearPublicacion(27, 4, "Cintas strap powerlifting", 300.50, "venta");
call crearProducto("Cintas strap powerlifting", "fsfjkdjffjf");
insert into comentario values(44, 42, "dfffsf", 9, "ddsf", current_date());
insert into comentario values(45, 42, "dfffsf", 10, "ddsf", current_date());

DELETE FROM publicacion WHERE idPublicacion = 42;


/* 222222 */
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

call crearProducto("Pantalon Jean Cargo", "cargo talle 36 negro con bolsillos");
call crearPublicacion(34, 2, "Pantalon Jean Cargo", 23657.50, "venta");
insert into comentario value(46, 45, "preguntapregunta", 14, "respuestarespuesta", current_date());
insert into ventaDirecta value(30, 3, 2);
insert into compra value(45, 30, 14, 2, 1);

UPDATE compra SET idComprador = 13 WHERE idPublicacion = 45;

/* 3 costó pero it's workinggggg */

SELECT count(*), idUsuarioV FROM compra c 
JOIN publicacion p ON p.idPublicacion = c.idPublicacion 
GROUP BY idUsuarioV;

-- usamos estas condiciones pq ningun monto supera 2000 entonces
delimiter //
create procedure actualizarNivel(in id_usuario int)
begin
	IF cantVentas(id_usuario) = 0 THEN
		UPDATE usuario SET nivel = "Normal" WHERE idUsuario = id_usuario;
	ELSE IF (cantVentas(id_usuario) > 0 AND cantVentas(id_usuario) <= 2) AND facturacion(id_usuario) >= 100 THEN
		UPDATE usuario SET nivel = "Platinum" WHERE idUsuario = id_usuario;
    ELSE IF cantVentas(id_usuario) > 2 AND facturacion(id_usuario) >= 1000 THEN
		UPDATE usuario SET nivel = "Gold" WHERE idUsuario = id_usuario;
    END IF;
    END IF;
    END IF;
end // 
delimiter ;
SELECT * FROM usuario ;
call actualizarNivel(21);
    
    SELECT count(*), idUsuarioV  FROM compra c
    JOIN publicacion p ON p.idPublicacion = c.idPublicacion  
    GROUP BY idUsuarioV;
    
    SELECT sum(precio), idUsuarioV FROM compra c
	JOIN publicacion p ON p.idPublicacion = c.idPublicacion  
    WHERE idUsuarioV = 27;

call crearProducto("Libro Orgullo y prejuicio", "novela romantica clasica");
INSERT INTO publicacion VALUE(43, 27, 5, 44, 8699.99, 1, current_date(), 10, "Oro", null);
insert into ventaDirecta value(29, 3, 2);
INSERT INTO compra VALUE(43, 29, 20, 3, 4);
