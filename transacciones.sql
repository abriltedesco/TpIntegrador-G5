delimiter //
CREATE PROCEDURE crearPublicacion (in idU int, in idC int, in nomProd varchar(45), in precio float, in tipo varchar(45))
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
            set ok = false;
        END IF;
    end;

    IF todo_ok THEN
        SET idPost = crearIdPublicacion();
        IF tipo = 'venta' THEN
            INSERT INTO publicacion VALUE (idPost, idU, idC, idProd, precio, 1, CURRENT_DATE(), 10, 'Bronce', NULL);
        ELSE
            SET idSubasta = crearSubasta();
            INSERT INTO publicacion VALUE (idPost, idU, idC, idProd, precio, 1, CURRENT_DATE(), 10, 'Bronce', idSubasta);
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

