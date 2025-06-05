-- Crear una vista que muestre todas las preguntas de publicaciones activas que aún no
-- tengan respuesta, incluyendo: id de la pregunta, la descripción, la publicación a la que
-- pertenece, el nombre del producto y el nombre del usuario que respondió.

create view preguntasSinRespuesta as
select * from comentario where respuesta IS NULL;
