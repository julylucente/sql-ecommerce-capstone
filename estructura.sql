-- PROYECTO FINAL: ANALISIS DE VENTAS E-COMMERCE
-- Creacion de las tablas principales

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100),
    fecha_registro DATE
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio NUMERIC(10,2)
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER REFERENCES clientes(id_cliente),
    id_producto INTEGER REFERENCES productos(id_producto),
    fecha_pedido DATE,
    cantidad INTEGER,
    precio_unitario NUMERIC(10,2)
);



-- CARGA DE DATOS: CLIENTES
-- Clientes registrados en distintas ciudades argentinas

INSERT INTO clientes (id_cliente, nombre, ciudad, fecha_registro) VALUES
(1, 'Lucia Fernandez', 'Buenos Aires', '2025-12-10'),
(2, 'Martin Gonzalez', 'Cordoba', '2025-12-15'),
(3, 'Sofia Rodriguez', 'Rosario', '2026-01-05'),
(4, 'Juan Perez', 'Buenos Aires', '2026-01-10'),
(5, 'Camila Lopez', 'Mendoza', '2026-01-18'),
(6, 'Tomas Martinez', 'La Plata', '2026-02-02'),
(7, 'Valentina Garcia', 'Cordoba', '2026-02-12'),
(8, 'Nicolas Sanchez', 'Rosario', '2026-02-20'),
(9, 'Agustina Romero', 'Buenos Aires', '2026-03-01'),
(10, 'Facundo Diaz', 'Mar del Plata', '2026-03-08'),
(11, 'Martina Torres', 'Mendoza', '2026-03-15'),
(12, 'Benjamin Ruiz', 'La Plata', '2026-04-01'),
(13, 'Florencia Castro', 'Buenos Aires', '2026-04-10'),
(14, 'Santiago Herrera', 'Cordoba', '2026-04-22'),
(15, 'Julieta Morales', 'Rosario', '2026-05-05');



-- CARGA DE DATOS: PRODUCTOS
-- Catalogo de tecnologia y accesorios

INSERT INTO productos (id_producto, nombre_producto, categoria, precio) VALUES
(1, 'Notebook Lenovo', 'Computacion', 850000),
(2, 'Mouse Logitech', 'Accesorios', 25000),
(3, 'Teclado Mecanico', 'Accesorios', 75000),
(4, 'Monitor Samsung 24', 'Computacion', 320000),
(5, 'Auriculares Sony', 'Audio', 120000),
(6, 'Parlante JBL', 'Audio', 95000),
(7, 'Smartphone Samsung', 'Celulares', 650000),
(8, 'Cargador USB-C', 'Accesorios', 18000),
(9, 'Tablet Lenovo', 'Computacion', 280000),
(10, 'Smartwatch Xiaomi', 'Wearables', 110000),
(11, 'Webcam Logitech', 'Accesorios', 68000),
(12, 'Funda para Tablet', 'Accesorios', NULL);



-- CARGA DE DATOS: PEDIDOS
-- Operaciones realizadas entre enero y junio de 2026

INSERT INTO pedidos
(id_pedido, id_cliente, id_producto, fecha_pedido, cantidad, precio_unitario)
VALUES
(1, 1, 1, '2026-01-08', 1, 850000),
(2, 2, 2, '2026-01-12', 2, 25000),
(3, 3, 5, '2026-01-18', 1, 120000),
(4, 4, 7, '2026-01-25', 1, 650000),
(5, 1, 3, '2026-02-03', 1, 75000),
(6, 5, 4, '2026-02-08', 1, 320000),
(7, 6, 8, '2026-02-14', 3, 18000),
(8, 2, 6, '2026-02-20', 1, 95000),
(9, 7, 10, '2026-02-26', 1, 110000),
(10, 3, 2, '2026-03-02', 2, 25000),
(11, 8, 9, '2026-03-06', 1, 280000),
(12, 1, 7, '2026-03-10', 1, 650000),
(13, 9, 5, '2026-03-15', 2, 120000),
(14, 4, 8, '2026-03-20', 1, 18000),
(15, 10, 3, '2026-03-28', 1, 75000),
(16, 5, 1, '2026-04-03', 1, 850000),
(17, 11, 6, '2026-04-08', 2, 95000),
(18, 2, 4, '2026-04-12', 1, 320000),
(19, 12, 2, '2026-04-18', 1, 25000),
(20, 7, 7, '2026-04-25', 1, 650000),
(21, 1, 5, '2026-05-02', 1, 120000),
(22, 13, 10, '2026-05-07', 1, 110000),
(23, 3, 8, '2026-05-12', 2, 18000),
(24, 14, 9, '2026-05-18', 1, 280000),
(25, 6, 3, '2026-05-25', 1, 75000),
(26, 15, 11, '2026-06-02', 1, 68000),
(27, 4, 2, '2026-06-08', 3, 25000),
(28, 8, 6, '2026-06-14', 1, 95000),
(29, 9, 7, '2026-06-20', 1, 650000),
(30, 1, 12, '2026-06-25', 1, NULL);


SELECT 'clientes' AS tabla, COUNT(*) AS registros FROM clientes
UNION ALL
SELECT 'productos', COUNT(*) FROM productos
UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos;
