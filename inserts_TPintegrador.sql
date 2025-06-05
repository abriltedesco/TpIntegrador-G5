-- Inserts for 'usuario' table with realistic names and varied 'nivel' (normal, platinum, gold, NULL)
INSERT INTO `TPintegrador`.`usuario` (`idUsuario`, `username`, `nivel`, `reputacion`) VALUES
(1, 'juan.perez', 'normal', 150),
(2, 'maria.gonzalez', 'platinum', 300),
(3, 'carlos.rodriguez', 'normal', 120),
(4, 'ana.lopez', 'gold', 550),
(5, 'pedro.martinez', 'platinum', 280),
(6, 'laura.fernandez', 'normal', 150),       -- Repetition: nivel 'normal', reputacion 150
(7, 'javier.diaz', 'gold', 600),
(8, 'sofia.ruiz', 'platinum', 300),         -- Repetition: nivel 'platinum', reputacion 300
(9, 'diego.sanchez', NULL, 120),            -- NULL for nivel
(10, 'valentina.gomez', 'gold', 850),
(11, 'martin.torres', 'platinum', 280),     -- Repetition: nivel 'platinum', reputacion 280
(12, 'camila.ramirez', 'normal', 150),      -- Repetition: nivel 'normal', reputacion 150
(13, 'facundo.flores', 'gold', 550),        -- Repetition: nivel 'gold', reputacion 550
(14, 'agustina.benitez', 'platinum', 300),  -- Repetition: nivel 'platinum', reputacion 300
(15, 'nicolas.acosta', 'normal', 120),      -- Repetition: nivel 'normal', reputacion 120
(16, 'florencia.ortiz', 'gold', 900),
(17, 'sebastian.herrera', NULL, 280),       -- NULL for nivel
(18, 'emilia.garcia', 'normal', 150),       -- Repetition: nivel 'normal', reputacion 150
(19, 'rodrigo.moreno', 'gold', 600),        -- Repetition: nivel 'gold', reputacion 600
(20, 'lucia.blanco', 'platinum', 300),      -- Repetition: nivel 'platinum', reputacion 300
(21, 'alejandro.romero', 'normal', 120),    -- Repetition: nivel 'normal', reputacion 120
(22, 'gabriela.suarez', 'gold', 850),       -- Repetition: nivel 'gold', reputacion 850
(23, 'federico.vazquez', 'platinum', 280),  -- Repetition: nivel 'platinum', reputacion 280
(24, 'daniela.paz', NULL, 150),             -- NULL for nivel
(25, 'ignacio.silva', 'gold', 550);         -- Repetition: nivel 'gold', reputacion 550

-- Inserts for 'categoria' table with NO repetitions and only 10 entries
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

-- Inserts for 'producto' table with repetitions
INSERT INTO `TPintegrador`.`producto` (`idProducto`, `nombre`, `descripcion`) VALUES
(1, 'Smartphone Samsung S22', 'Teléfono inteligente de alta gama'),
(2, 'Remera Deportiva Nike', 'Remera de algodón para ejercicio'),
(3, 'Set de Sábanas King Size', 'Juego de sábanas de algodón egipcio'),
(4, 'Pelota de Fútbol Adidas', 'Balón de fútbol oficial AFA'),
(5, 'Novela "Cien Años de Soledad"', 'Clásico de la literatura latinoamericana'),
(6, 'Smartphone Xiaomi Redmi', 'Teléfono inteligente de gama media'), -- Similar product/repetition pattern
(7, 'Buzo con Capucha Adidas', 'Buzo de algodón con capucha'),        -- Similar product/repetition pattern
(8, 'Toallas de Mano Algodón', 'Set de toallas pequeñas de algodón'),      -- Similar product/repetition pattern
(9, 'Pelota de Baloncesto Spalding', 'Balón de baloncesto oficial NBA'),    -- Similar product/repetition pattern
(10, 'Libro "Hábitos Atómicos"', 'Best-seller de autoayuda'),        -- Similar product/repetition pattern
(11, 'Coche de Juguete Hot Wheels', 'Miniatura de coche de colección'), -- Repetition
(12, 'Aceite de Motor Castrol', 'Aceite sintético 5W-30'),
(13, 'Crema Antiarrugas Nivea', 'Crema facial para piel madura'),
(14, 'Kit de Jardinería Básico', 'Set de herramientas de mano para jardín'),
(15, 'Pintura Acrílica Profesional', 'Set de pinturas acrílicas de alta calidad'), -- Renamed to make it more distinct
(16, 'Correa Extensible para Perro', 'Correa retráctil de 5 metros'),
(17, 'Auriculares Bluetooth Sony', 'Auriculares supraaurales con Bluetooth'),
(18, 'Consola PlayStation 5', 'Consola de última generación de Sony'),
(19, 'Café Tostado en Grano', 'Granos de café 100% arábica'),
(20, 'Teclado Mecánico Redragon', 'Teclado gamer con switches rojos'),
(21, 'Taladro Percutor Bosch', 'Taladro con cable de alta potencia'),
(22, 'Anillo de Plata 925', 'Anillo de plata con diseño minimalista'),
(23, 'Reloj de Bolsillo Antiguo', 'Reloj de cuerda coleccionable'),
(24, 'Moneda Conmemorativa Bicentenario', 'Moneda de colección de 2 pesos'),
(25, 'Software Antivirus McAfee', 'Licencia de software antivirus por 1 año');

-- Inserts for 'estado' table (representing publicacion level)
INSERT INTO `TPintegrador`.`estado` (`idEstado`, `nombre`) VALUES
(1, 'bronce'),
(2, 'oro'),
(3, 'platino'),
(4, 'plata');

-- Inserts for 'publicacion' table with specific 'idEstado' (bronce, oro, platino, plata)
-- and ensuring idCategoria references only 1-10
INSERT INTO `TPintegrador`.`publicacion` (`idPublicacion`, `idUsuarioV`, `idCategoria`, `idProducto`, `precio`, `estaActiva`, `vistas`, `fechaPublicacion`, `idEstado`) VALUES
(1, 1, 1, 1, 750.00, 1, 250, '2024-01-01', 2),  -- oro, Electrónica
(2, 2, 2, 2, 29.99, 1, 180, '2024-01-05', 1),  -- bronce, Ropa
(3, 3, 3, 3, 65.00, 1, 100, '2024-01-10', 3),  -- platino, Hogar
(4, 4, 4, 4, 40.00, 1, 300, '2024-01-12', 4),  -- plata, Deportes
(5, 5, 5, 5, 20.00, 1, 90, '2024-01-15', 1),  -- bronce, Libros
(6, 6, 1, 6, 350.00, 1, 200, '2024-01-18', 2),  -- oro, Electrónica (repetition of category)
(7, 7, 2, 7, 45.00, 1, 150, '2024-01-20', 1),  -- bronce, Ropa (repetition of category)
(8, 8, 3, 8, 30.00, 1, 80, '2024-01-22', 3),  -- platino, Hogar (repetition of category)
(9, 9, 4, 9, 35.00, 1, 220, '2024-01-25', 4),  -- plata, Deportes (repetition of category)
(10, 10, 5, 10, 18.50, 1, 110, '2024-01-28', 1), -- bronce, Libros (repetition of category)
(11, 11, 6, 11, 15.00, 1, 70, '2024-02-01', 2), -- oro, Automotriz
(12, 12, 7, 12, 55.00, 1, 190, '2024-02-03', 1), -- bronce, Salud y Belleza
(13, 13, 8, 13, 40.00, 1, 120, '2024-02-05', 3), -- platino, Jardinería
(14, 14, 9, 14, 25.00, 1, 95, '2024-02-07', 4), -- plata, Arte
(15, 15, 10, 15, 28.00, 1, 130, '2024-02-09', 1), -- bronce, Mascotas
(16, 16, 1, 16, 22.00, 1, 85, '2024-02-12', 2), -- oro, Electrónica (repetition of category)
(17, 17, 2, 17, 180.00, 1, 310, '2024-02-15', 1), -- bronce, Ropa (repetition of category)
(18, 18, 3, 18, 500.00, 1, 450, '2024-02-18', 3), -- platino, Hogar (repetition of category)
(19, 19, 4, 19, 12.00, 1, 60, '2024-02-20', 4), -- plata, Deportes (repetition of category)
(20, 20, 5, 20, 95.00, 1, 140, '2024-02-22', 1), -- bronce, Libros (repetition of category)
(21, 21, 6, 21, 80.00, 1, 160, '2024-02-25', 2), -- oro, Automotriz (repetition of category)
(22, 22, 7, 22, 70.00, 1, 110, '2024-02-28', 1), -- bronce, Salud y Belleza (repetition of category)
(23, 23, 8, 23, 200.00, 1, 190, '2024-03-01', 3), -- platino, Jardinería (repetition of category)
(24, 24, 9, 24, 15.00, 1, 75, '2024-03-03', 4), -- plata, Arte (repetition of category)
(25, 25, 10, 25, 60.00, 1, 105, '2024-03-05', 1); -- bronce, Mascotas (repetition of category)

-- Inserts for 'compra' table with repetitions in buyers/sellers and satisfactions
INSERT INTO `TPintegrador`.`compra` (`id_Publicacion`, `idComprador`, `satisfaccionC`, `idVendedor`) VALUES
(1, 2, 5, 1),
(2, 3, 4, 2),
(3, 4, 5, 3),
(4, 5, 3, 4),
(5, 6, 5, 5),
(6, 1, 4, 6),  -- Juan Perez buys from Laura Fernandez
(7, 2, 5, 7),  -- Maria Gonzalez buys from Javier Diaz
(8, 3, 4, 8),  -- Carlos Rodriguez buys from Sofia Ruiz
(9, 4, 5, 9),  -- Ana Lopez buys from Diego Sanchez
(10, 5, 3, 10), -- Pedro Martinez buys from Valentina Gomez
(11, 6, 5, 11), -- Laura Fernandez buys from Martin Torres
(12, 7, 4, 12), -- Javier Diaz buys from Camila Ramirez
(13, 8, 5, 13), -- Sofia Ruiz buys from Facundo Flores
(14, 9, 3, 14), -- Diego Sanchez buys from Agustina Benitez
(15, 10, 5, 15),-- Valentina Gomez buys from Nicolas Acosta
(16, 1, 4, 16), -- Juan Perez buys from Florencia Ortiz
(17, 2, 5, 17), -- Maria Gonzalez buys from Sebastian Herrera
(18, 3, 3, 18), -- Carlos Rodriguez buys from Emilia Garcia
(19, 4, 5, 19), -- Ana Lopez buys from Rodrigo Moreno
(20, 5, 4, 20), -- Pedro Martinez buys from Lucia Blanco
(21, 6, 5, 21), -- Laura Fernandez buys from Alejandro Romero
(22, 7, 3, 22), -- Javier Diaz buys from Gabriela Suarez
(23, 8, 5, 23), -- Sofia Ruiz buys from Federico Vazquez
(24, 9, 4, 24), -- Diego Sanchez buys from Daniela Paz
(25, 10, 5, 25); -- Valentina Gomez buys from Ignacio Silva

-- Inserts for 'metodoPago' table with *only* the specified options
INSERT INTO `TPintegrador`.`metodoPago` (`idMetodoPago`, `nombre`) VALUES
(1, 'Tarjeta de Credito'),
(2, 'Tarjeta de Debito'),
(3, 'Pago Facil'),
(4, 'Rapipago');

-- Inserts for 'metodoEnvio' table with *only* the specified options
INSERT INTO `TPintegrador`.`metodoEnvio` (`idMetodoEnvio`, `empresa`) VALUES
(1, 'Correo Argentino'),
(2, 'OCA');

-- Inserts for 'ventaDirecta' table using only the new valid metodoPago and metodoEnvio IDs
INSERT INTO `TPintegrador`.`ventaDirecta` (`idVentaDirecta`, `idMetodoPago`, `idMetodoEnvio`, `idPublicacion`) VALUES
(1, 1, 1, 1),  -- Tarjeta de Credito, Correo Argentino
(2, 2, 2, 2),  -- Tarjeta de Debito, OCA
(3, 3, 1, 3),  -- Pago Facil, Correo Argentino
(4, 4, 2, 4),  -- Rapipago, OCA
(5, 1, 1, 5),  -- Tarjeta de Credito, Correo Argentino (repetition)
(6, 2, 2, 6),  -- Tarjeta de Debito, OCA (repetition)
(7, 3, 1, 7),  -- Pago Facil, Correo Argentino (repetition)
(8, 4, 2, 8),  -- Rapipago, OCA (repetition)
(9, 1, 1, 9),  -- Tarjeta de Credito, Correo Argentino (repetition)
(10, 2, 2, 10), -- Tarjeta de Debito, OCA (repetition)
(11, 3, 1, 11), -- Pago Facil, Correo Argentino (repetition)
(12, 4, 2, 12), -- Rapipago, OCA (repetition)
(13, 1, 1, 13), -- Tarjeta de Credito, Correo Argentino (repetition)
(14, 2, 2, 14), -- Tarjeta de Debito, OCA (repetition)
(15, 3, 1, 15), -- Pago Facil, Correo Argentino (repetition)
(16, 4, 2, 16), -- Rapipago, OCA (repetition)
(17, 1, 1, 17), -- Tarjeta de Credito, Correo Argentino (repetition)
(18, 2, 2, 18), -- Tarjeta de Debito, OCA (repetition)
(19, 3, 1, 19), -- Pago Facil, Correo Argentino (repetition)
(20, 4, 2, 20), -- Rapipago, OCA (repetition)
(21, 1, 1, 21), -- Tarjeta de Credito, Correo Argentino (repetition)
(22, 2, 2, 22), -- Tarjeta de Debito, OCA (repetition)
(23, 3, 1, 23), -- Pago Facil, Correo Argentino (repetition)
(24, 4, 2, 24), -- Rapipago, OCA (repetition)
(25, 1, 1, 25); -- Tarjeta de Credito, Correo Argentino (repetition)


-- Inserts for 'comentario' table with repetitions in questions and users
INSERT INTO `TPintegrador`.`comentario` (`idComentario`, `pregunta`, `idUsuarioPregunta`, `respuesta`, `idPublicacion`) VALUES
(1, '¿El producto es nuevo y sellado?', 2, 'Sí, completamente nuevo y sellado.', 1),
(2, '¿Qué tallas están disponibles?', 3, 'Tenemos M, L y XL.', 2),
(3, '¿Realizan envíos a todo el país?', 4, 'Sí, enviamos a todo el país.', 3),
(4, '¿El precio es negociable?', 5, 'El precio publicado es el final.', 4),
(5, '¿Tienen stock para entrega inmediata?', 6, 'Sí, tenemos stock para envío inmediato.', 5),
(6, '¿El producto es nuevo y sellado?', 1, 'Sí, el producto es a estrenar.', 6), -- Repetition: question, user
(7, '¿Qué colores tienen disponibles?', 2, 'Disponible en rojo y azul.', 7),
(8, '¿Realizan envíos a todo el país?', 3, 'Sí, con costo adicional.', 8), -- Repetition: question, user
(9, '¿El precio es negociable?', 4, 'No, el precio es fijo.', 9),      -- Repetition: question, user
(10, '¿Tienen stock para entrega inmediata?', 5, 'Sí, lo tenemos en almacén.', 10), -- Repetition: question, user
(11, '¿Viene con garantía?', 6, 'Sí, 6 meses de garantía.', 11),
(12, '¿El producto es original?', 7, 'Sí, es 100% original.', 12),
(13, '¿Puedo retirar en persona?', 8, 'Sí, en nuestra oficina.', 13),
(14, '¿El producto es nuevo y sellado?', 9, 'Sí, sin uso y en su empaque original.', 14), -- Repetition: question, user
(15, '¿Qué tallas están disponibles?', 10, 'Solo la talla publicada.', 15), -- Repetition: question, user
(16, '¿Realizan envíos a todo el país?', 11, 'Sí, a través de Correo Argentino.', 16), -- Repetition: question, user
(17, '¿El precio es negociable?', 12, 'Por el momento no.', 17),        -- Repetition: question, user
(18, '¿Tienen stock para entrega inmediata?', 13, 'Sí, listo para despachar.', 18), -- Repetition: question, user
(19, '¿Viene con garantía?', 14, 'No, es un producto usado.', 19),
(20, '¿El producto es original?', 15, 'Totalmente original.', 20),
(21, '¿Puedo retirar en persona?', 16, 'Sí, previa coordinación.', 21),
(22, '¿El producto es nuevo y sellado?', 17, 'Sí, está nuevo.', 22),       -- Repetition: question, user
(23, '¿Qué tallas están disponibles?', 18, 'Solo la talla L.', 23),       -- Repetition: question, user
(24, '¿Realizan envíos a todo el país?', 19, 'Sí, a todo el territorio nacional.', 24), -- Repetition: question, user
(25, '¿El precio es negociable?', 20, 'El precio es fijo.', 25);        -- Repetition: question, user