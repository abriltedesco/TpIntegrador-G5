
-- Inserts for 'usuario' table (20 entries with varied 'nivel' and 'reputacion')
INSERT INTO `TPintegrador`.`usuario` (`idUsuario`, `username`, `nivel`, `reputacion`) VALUES
(1, 'juan.perez', 'Normal', 150),
(2, 'maria.gonzalez', 'Platinum', 300),
(3, 'carlos.rodriguez', 'Normal', 120),
(4, 'ana.lopez', 'Gold', 550),
(5, 'pedro.martinez', 'Platinum', 280),
(6, 'laura.fernandez', NULL, 90),
(7, 'javier.diaz', 'Gold', 600),
(8, 'sofia.ruiz', 'Platinum', 320),
(9, 'diego.sanchez', 'Normal', 110),
(10, 'valentina.gomez', 'Gold', 850),
(11, 'martin.torres', NULL, 75),
(12, 'camila.ramirez', 'Normal', 160),
(13, 'facundo.flores', 'Gold', 580),
(14, 'agustina.benitez', 'Platinum', 290),
(15, 'nicolas.acosta', 'Normal', 130),
(16, 'florencia.ortiz', 'Gold', 920),
(17, 'sebastian.herrera', NULL, 80),
(18, 'emilia.garcia', 'Normal', 140),
(19, 'rodrigo.moreno', 'Gold', 610),
(20, 'lucia.blanco', 'Platinum', 310);

-- Inserts for 'categoria' table (10 unique entries)
INSERT INTO `TPintegrador`.`categoria` (`idCategoria`, `nombre`) VALUES
(1, 'Electrónica'),
(2, 'Ropa'),
(3, 'Hogar'),
(4, 'Deportes'),
(5, 'Libros'),
(6, 'Automotriz'),
(7, 'Salud y Belleza'),
(8, 'Jardinería'),
(9, 'Arte'),
(10, 'Mascotas');

-- Inserts for 'producto' table (20 entries)
INSERT INTO `TPintegrador`.`producto` (`idProducto`, `nombre`, `descripcion`) VALUES
(1, 'Smartphone Samsung S22', 'Teléfono inteligente de alta gama con cámara mejorada'),
(2, 'Remera Deportiva Nike', 'Remera de algodón para ejercicio transpirable'),
(3, 'Set de Sábanas King Size', 'Juego de sábanas de algodón egipcio de 600 hilos'),
(4, 'Pelota de Fútbol Adidas', 'Balón de fútbol oficial AFA, talla 5'),
(5, 'Novela "Cien Años de Soledad"', 'Clásico de la literatura latinoamericana de Gabriel García Márquez'),
(6, 'Smartphone Xiaomi Redmi', 'Teléfono inteligente de gama media con batería de larga duración'),
(7, 'Buzo con Capucha Adidas', 'Buzo de algodón con capucha y bolsillo canguro'),
(8, 'Toallas de Mano Algodón', 'Set de toallas pequeñas de algodón 100% orgánico'),
(9, 'Pelota de Baloncesto Spalding', 'Balón de baloncesto oficial NBA, talla 7'),
(10, 'Libro "Hábitos Atómicos"', 'Best-seller de autoayuda para construir buenos hábitos'),
(11, 'Coche de Juguete Hot Wheels', 'Miniatura de coche de colección, escala 1:64'),
(12, 'Aceite de Motor Castrol', 'Aceite sintético 5W-30 para motores modernos'),
(13, 'Crema Antiarrugas Nivea', 'Crema facial para piel madura con Q10 y protección solar'),
(14, 'Kit de Jardinería Básico', 'Set de herramientas de mano para jardín, incluye pala y rastrillo'),
(15, 'Pintura Acuarela Winsor & Newton', 'Set de acuarelas profesionales, 12 colores vibrantes'),
(16, 'Correa Extensible para Perro', 'Correa retráctil de 5 metros para perros de hasta 20kg'),
(17, 'Auriculares Bluetooth Sony', 'Auriculares supraaurales con Bluetooth y cancelación de ruido'),
(18, 'Consola PlayStation 5', 'Consola de última generación de Sony con gráficos 4K'),
(19, 'Café Tostado en Grano', 'Granos de café 100% arábica, tueste medio'),
(20, 'Teclado Mecánico Redragon', 'Teclado gamer con switches rojos e iluminación RGB');

-- Inserts for 'estado' table (12 distinct transactional states including Finalizada and Pausada)
INSERT INTO `TPintegrador`.`estado` (`idEstado`, `nombre`) VALUES
(1, 'Pendiente de Pago'),
(2, 'Procesando'),
(3, 'Enviado'),
(4, 'Entregado'),
(5, 'Cancelado'),
(6, 'Reembolsado'),
(7, 'Devuelto'),
(8, 'En Espera'),
(9, 'Fallido'),
(10, 'Completado'),
(11, 'Finalizada'),
(12, 'Pausada');

-- Inserts for 'publicacion' table (20 entries with varied states and nivelVistas)
INSERT INTO `TPintegrador`.`publicacion` (`idPublicacion`, `idUsuarioV`, `idCategoria`, `idProducto`, `precio`, `estaActiva`, `vistas`, `fechaPublicacion`, `idEstado`, `nivelVistas`) VALUES
(1, 1, 1, 1, 750.00, 1, 250, '2024-01-01', 11, 'Oro'),             -- Finalizada, Oro
(2, 2, 2, 2, 29.99, 1, 180, '2024-01-05', 1, 'Bronce'),           -- Pendiente de Pago, Bronce
(3, 3, 3, 3, 65.00, 1, 100, '2024-01-10', 3, 'Platino'),          -- Enviado, Platino
(4, 4, 4, 4, 40.00, 1, 300, '2024-01-12', 5, 'Plata'),            -- Cancelado, Plata
(5, 5, 5, 5, 20.00, 0, 90, '2024-01-15', 12, 'Bronce'),           -- Pausada, Bronce
(6, 6, 6, 6, 350.00, 1, 200, '2024-01-18', 2, 'Oro'),             -- Procesando, Oro
(7, 7, 7, 7, 45.00, 1, 150, '2024-01-20', 4, 'Bronce'),           -- Entregado, Bronce
(8, 8, 8, 8, 30.00, 1, 80, '2024-01-22', 6, 'Platino'),          -- Reembolsado, Platino
(9, 9, 9, 9, 35.00, 1, 220, '2024-01-25', 8, 'Plata'),            -- En Espera, Plata
(10, 10, 10, 10, 18.50, 1, 110, '2024-01-28', 10, 'Bronce'),       -- Completado, Bronce
(11, 11, 1, 11, 15.00, 1, 70, '2024-02-01', 11, 'Oro'),            -- Finalizada, Oro
(12, 12, 2, 12, 55.00, 1, 190, '2024-02-03', 1, 'Bronce'),          -- Pendiente de Pago, Bronce
(13, 13, 3, 13, 40.00, 1, 120, '2024-02-05', 3, 'Platino'),        -- Enviado, Platino
(14, 14, 4, 14, 25.00, 0, 95, '2024-02-07', 12, 'Plata'),          -- Pausada, Plata
(15, 15, 5, 15, 28.00, 1, 130, '2024-02-09', 2, 'Bronce'),         -- Procesando, Bronce
(16, 16, 6, 16, 22.00, 1, 85, '2024-02-12', 4, 'Oro'),             -- Entregado, Oro
(17, 17, 7, 17, 180.00, 1, 310, '2024-02-15', 6, 'Bronce'),         -- Reembolsado, Bronce
(18, 18, 8, 18, 500.00, 1, 450, '2024-02-18', 8, 'Platino'),        -- En Espera, Platino
(19, 19, 9, 19, 12.00, 0, 60, '2024-02-20', 12, 'Plata'),          -- Pausada, Plata
(20, 20, 10, 20, 95.00, 1, 140, '2024-02-22', 10, 'Bronce');       -- Completado, Bronce

-- Inserts for 'compra' table (20 entries with satisfaccionC and satisfaccionV between 1 and 5)
INSERT INTO `TPintegrador`.`compra` (`id_Publicacion`, `idComprador`, `satisfaccionC`, `satisfaccionV`) VALUES
(1, 2, 5, 4),
(2, 3, 4, 5),
(3, 4, 3, 3),
(4, 5, 2, 1),
(5, 6, 5, 5),
(6, 1, 4, 2),
(7, 2, 5, 3),
(8, 3, 3, 4),
(9, 4, 1, 5),
(10, 5, 5, 1),
(11, 6, 4, 4),
(12, 7, 5, 5),
(13, 8, 3, 2),
(14, 9, 2, 3),
(15, 10, 5, 4),
(16, 11, 4, 5),
(17, 12, 5, 1),
(18, 13, 3, 2),
(19, 14, 1, 3),
(20, 15, 5, 4);

-- Inserts for 'metodoPago' table
INSERT INTO `TPintegrador`.`metodoPago` (`idMetodoPago`, `nombre`) VALUES
(1, 'Tarjeta de Credito'),
(2, 'Tarjeta de Debito'),
(3, 'Pago Facil'),
(4, 'Rapipago');

-- Inserts for 'metodoEnvio' table
INSERT INTO `TPintegrador`.`metodoEnvio` (`idMetodoEnvio`, `empresa`) VALUES
(1, 'Correo Argentino'),
(2, 'OCA');

-- Inserts for 'ventaDirecta' table (20 entries)
INSERT INTO `TPintegrador`.`ventaDirecta` (`idVentaDirecta`, `idMetodoPago`, `idMetodoEnvio`, `idPublicacion`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 1, 3),
(4, 4, 2, 4),
(5, 1, 1, 5),
(6, 2, 2, 6),
(7, 3, 1, 7),
(8, 4, 2, 8),
(9, 1, 1, 9),
(10, 2, 2, 10),
(11, 3, 1, 11),
(12, 4, 2, 12),
(13, 1, 1, 13),
(14, 2, 2, 14),
(15, 3, 1, 15),
(16, 4, 2, 16),
(17, 1, 1, 17),
(18, 2, 2, 18),
(19, 3, 1, 19),
(20, 4, 2, 20);

-- Inserts for 'comentario' table (20 entries with 'fecha' column)
INSERT INTO `TPintegrador`.`comentario` (`idComentario`, `idPublicacion`, `pregunta`, `idUsuarioPregunta`, `respuesta`, `fecha`) VALUES
(1, 1, '¿El producto es nuevo y sellado?', 2, 'Sí, completamente nuevo y sellado.', '2024-01-02'),
(2, 2, '¿Qué tallas están disponibles?', 3, 'Tenemos M, L y XL.', '2024-01-06'),
(3, 3, '¿Realizan envíos a todo el país?', 4, 'Sí, enviamos a todo el país.', '2024-01-11'),
(4, 4, '¿El precio es negociable?', 5, 'El precio publicado es el final.', '2024-01-13'),
(5, 5, '¿Tienen stock para entrega inmediata?', 6, 'Sí, tenemos stock para envío inmediato.', '2024-01-16'),
(6, 6, '¿El producto es compatible con Android?', 1, 'Sí, es compatible con Android 10 o superior.', '2024-01-19'),
(7, 7, '¿La tela es transpirable?', 2, 'Sí, es un tejido técnico muy transpirable.', '2024-01-21'),
(8, 8, '¿Qué tipo de algodón es?', 3, 'Algodón Pima de alta calidad.', '2024-01-23'),
(9, 9, '¿Es apta para uso en exteriores?', 4, 'Sí, es resistente al agua y al desgaste.', '2024-01-26'),
(10, 10, '¿Es una edición de bolsillo?', 5, 'No, es la edición de tapa dura.', '2024-01-29'),
(11, 11, '¿Cuál es la autonomía de la batería?', 6, 'Aproximadamente 8 horas de uso continuo.', '2024-02-02'),
(12, 12, '¿El buzo tiene bolsillos laterales?', 7, 'Sí, tiene dos bolsillos frontales.', '2024-02-04'),
(13, 13, '¿Las toallas sueltan pelusa?', 8, 'No, están prelavadas para evitarlo.', '2024-02-06'),
(14, 14, '¿Es original o réplica?', 9, 'Es un producto 100% original con licencia oficial.', '2024-02-08'),
(15, 15, '¿El libro incluye separador?', 10, 'Sí, incluye un separador de diseño exclusivo.', '2024-02-10'),
(16, 16, '¿La correa es apta para perros grandes?', 11, 'No, es para perros pequeños y medianos.', '2024-02-13'),
(17, 17, '¿Viene con estuche de carga?', 12, 'Sí, incluye un estuche de carga portátil.', '2024-02-16'),
(18, 18, '¿Qué juegos incluye?', 13, 'No incluye juegos, se venden por separado.', '2024-02-19'),
(19, 19, '¿Es café molido o en grano?', 14, 'Viene en grano para moler en casa.', '2024-02-21'),
(20, 20, '¿Las teclas son silenciosas?', 15, 'No, es un teclado mecánico con sonido de click.', '2024-02-23');
