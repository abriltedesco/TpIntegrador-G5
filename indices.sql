CREATE INDEX index_producto_nombre ON producto(nombre);

ALTER TABLE usuario ADD UNIQUE INDEX index_emails_usuarios (email);
CREATE UNIQUE INDEX index_emails_usuarios ON usuario(email);

ALTER TABLE usuario ADD COLUMN email varchar(100);
UPDATE usuario SET email = 'juan.perez@gmail.com' WHERE idUsuario = 1;

INSERT INTO usuario (idUsuario, username, nivel, reputacion, email)
VALUES (41, 'nuevo.usuario', 'Normal', 100, 'juan.perez@gmail.com');


CREATE INDEX index_publicacion_estado ON publicacion(idEstado);
SELECT * FROM publicacion WHERE idEstado IN (1, 3, 11, 12);
