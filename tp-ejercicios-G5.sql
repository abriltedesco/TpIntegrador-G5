# ARCHIVO CON TODOS LOS EJERCICIOS 

/* nos olvidamos de poner auto increment, para no borrar todo y tener que volver a rehacer los inserts
hicimos funciones que hagan lo mismo */
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

call buscarPublicacion("Smartphone Samsung S22");

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

call crearPublicacion(3, 9, "Acrilico Eterna Violeta", 500.50, "venta");
call crearProducto("Acrilico Eterna Violeta", "pintura acrilica de la marca eterna, color violeta");

/* 3. Crear un procedimiento llamado verPreguntas que muestre todas las preguntas de una
publicación. */
delimiter // 
create procedure verPreguntas (in idP int)
begin
	SELECT pregunta FROM comentario where idPublicacion = idP;
end//
delimiter ;

call verPreguntas(1);

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

#                                                 ------------- VISTAS ------------- 
/* 1) Crear una vista que muestre todas las preguntas de publicaciones activas que aún no
tengan respuesta, incluyendo: id de la pregunta, la descripción, la publicación a la que
pertenece, el nombre del producto y el nombre del usuario que respondió. */
create view preguntasSinRespuesta as
select  comentario.*, idProducto from comentario 
join publicacion on publicacion.idPublicacion = comentario.idPublicacion
where respuesta IS NULL;

SELECT * FROM preguntasSinRespuesta;

/* 2) Crear una vista que muestre un top 10 de categorías más presentes en publicaciones de
esta semana. */
create view topCategoriasEstaSemana as
select categoria.idCategoria, categoria.nombre, count(categoria.idCategoria) as cantidad from publicacion
join categoria on publicacion.idCategoria = categoria.idCategoria
where week(fechaPublicacion) = week(current_date())
group by 1,2 
order by cantidad desc
limit 10;

SELECT * FROM topCategoriasEstaSemana;

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

UPDATE publicacion SET fechaPublicacion = current_date() WHERE idPublicacion = 1;
SELECT * FROM publicacionesTendenciaHoy;

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

/* 2) Crear un trigger calificar que después de hacer un update en la tabla venta verifique
que la calificación del vendedor y del comprador sea distinta de null. Si es así actualiza
con esos datos la calificación del usuario en base a la calificación de esa venta. */

/* 3) Crear un trigger cambiarCategoria que después de insertar en la tabla de venta
actualice la categoría de usuario. */

#                                          ------------- INDICES ------------
/* 1) Crear un índice en la tabla de publicaciones para acelerar la búsqueda por nombre de
producto. */

/* 2) Crear un índice para asegurar que no se repitan direcciones de correo electrónico en la
tabla de usuarios. */

/* 3) Crear un índice para optimizar las consultas frecuentes sobre publicaciones activas,
pausadas o finalizadas. */

# ------------- TRANSACCIONES -------------
/* 1. Plantear cómo sería el procedimiento crearPublicacion para que utilice una transacción
que inserte la publicación y, si corresponde, los datos de la subasta. Si alguna inserción
falla, se debe hacer rollback. En caso exitoso se debe devolver un mensaje de éxito. */

/* 2. Realizar lo anterior pero con el procedimiento actualizarReputacionUsuarios. */