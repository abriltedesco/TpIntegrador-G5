-- Crear una vista que muestre todas las preguntas de publicaciones activas que aún no
-- tengan respuesta, incluyendo: id de la pregunta, la descripción, la publicación a la que
-- pertenece, el nombre del producto y el nombre del usuario que respondió.

create view preguntasSinRespuesta as
select  comentario.*, idProducto from comentario 
join publicacion on publicacion.idPublicacion = comentario.idPublicacion
where respuesta IS NULL;

select * from comentario 
join publicacion on publicacion.idPublicacion = comentario.idPublicacion
where respuesta IS NULL;



/*
Crear una vista que muestre un top 10 de categorías más presentes en publicaciones de
esta semana.
*/

select * from publicacion;
select * from categoria;
select count(*) from categoria;

select categoria.idCategoria, categoria.nombre, count(categoria.idCategoria) as cantidad from publicacion
join categoria on publicacion.idCategoria = categoria.idCategoria
where week(fechaPublicacion) = week(current_date())
group by 1,2 
order by cantidad desc
limit 10;

create view topCategoriasEstaSemana as
select categoria.idCategoria, categoria.nombre, count(categoria.idCategoria) as cantidad from publicacion
join categoria on publicacion.idCategoria = categoria.idCategoria
where week(fechaPublicacion) = week(current_date())
group by 1,2 
order by cantidad desc
limit 10;

select * from topCategoriasEstaSemana;

-- ---------------------------------------------------------------------------------------------------------------------------

/* 
Crear una vista que muestre las publicaciones que se encuentran en tendencia el día de
hoy. Estas serán las que tengan mayor cantidad de preguntas
*/

select * from publicacion;
select * from comentario;
select count(pregunta) from comentario;

select idPublicacion, count(pregunta)as cantidad from comentario
group by 1
order by 2 desc;


select comentario.idPublicacion, count(pregunta)as cantidad, publicacion.*from comentario
join publicacion on comentario.idPublicacion = publicacion.idPublicacion
where fechaPublicacion = current_date()
group by comentario.idPublicacion
order by cantidad desc
limit 10;

select nivelVistas from publicacion;

create view publicacionesTendenciaHoy as
select publicacion.idPublicacion, count(pregunta)as cantidad, idProducto, 
precio, fechaPublicacion from comentario
join publicacion on comentario.idPublicacion = publicacion.idPublicacion
where fechaPublicacion = current_date()
group by 1
order by cantidad desc
limit 10;

select * from publicacionesTendenciaHoy;

-- -------------------------------------------------------------------------------------------------------------------

/*
Crear una vista que muestre el nombre del vendedor con mayor reputación por
categoría. Se debe mostrar nombre del vendedor y nombre de la categoría
*/

select * from usuario;

select * from usuario
join publicacion on usuario.idUsuario = publicacion.idUsuarioV
join categoria on categoria.idCategoria = publicacion.idCategoria;

select categoria.nombre, usuario.username, reputacion from usuario
join publicacion on usuario.idUsuario = publicacion.idUsuarioV
join categoria on categoria.idCategoria = publicacion.idCategoria;

select categoria.nombre, username, max(reputacion) from usuario
join publicacion on usuario.idUsuario = publicacion.idUsuarioV
join categoria on categoria.idCategoria = publicacion.idCategoria
group by 1;


select idUsuarioV, categoria.nombre from usuario
join publicacion on usuario.idUsuario = publicacion.idUsuarioV
join categoria on categoria.idCategoria = publicacion.idCategoria
group by 1,2;


/* para probar
UPDATE usuario SET reputacion = 50 WHERE idUsuario = 37;
UPDATE usuario SET reputacion = 70 WHERE idUsuario = 17;
UPDATE usuario SET reputacion = 64 WHERE idUsuario = 27;
UPDATE usuario SET reputacion = 95 WHERE idUsuario = 28;
UPDATE usuario SET reputacion = 35 WHERE idUsuario = 18;
UPDATE usuario SET reputacion = 57 WHERE idUsuario = 31;
UPDATE usuario SET reputacion = 75  WHERE idUsuario = 9; 
*/

SELECT nombreUser, nombreCategoria FROM (SELECT MAX(rep), nombreCategoria FROM 
(SELECT reputacion as rep, nombre as nombreCategoria, username as nombreUser FROM usuario
JOIN publicacion p ON idUsuarioV = idUsuario
JOIN categoria c on c.idCategoria = p.idCategoria
GROUP BY idUsuarioV, p.idCategoria) as sss) as sss GROUP BY nombreCategoria;
-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------


