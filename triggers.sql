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
/* 3 */

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
