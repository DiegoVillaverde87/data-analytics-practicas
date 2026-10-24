-- Motor utilizado: SQL Server 2016 o posterior (SSMS)
-- Checkpoint: Script SQL de Ingeniería de Datos
-- Proyecto: TechStore - Ventas_Tech_DB
-- Autor: Diego Villaverde
-- Fecha: 2026-10-24

-- Crear la base solamente si todavía no existe.
-- DB_ID devuelve NULL cuando la base no existe.
USE master;
GO

IF DB_ID(N'Ventas_Tech_DB') IS NULL
BEGIN
    EXEC(N'CREATE DATABASE [Ventas_Tech_DB];');
END;
GO

-- Seleccionar la base antes de trabajar con sus tablas.
USE [Ventas_Tech_DB];
GO

-- === SECCIÓN 1: DROP ===
-- Eliminar primero las tablas que dependen de otras mediante foreign keys.
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
GO

-- === SECCIÓN 2: CREATE ===
-- Crear primero las tablas independientes y después las que las referencian.
-- PRIMARY KEY identifica cada registro sin admitir duplicados ni nulos.

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200) NULL
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50) NULL,
    fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    -- DECIMAL conserva valores monetarios exactos con dos decimales.
    precio DECIMAL(10, 2) NOT NULL,
    -- Los valores por defecto se usan si se omite la columna en el INSERT.
    stock INT DEFAULT 0,
    -- BIT representa el estado: 1 = activo, 0 = inactivo.
    activo BIT DEFAULT 1,
    CONSTRAINT fk_productos_categorias
        FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT NOT NULL,
    -- Se guarda el precio unitario de la venta, aunque cambie el del producto.
    precio_unitario DECIMAL(10, 2) NOT NULL,
    fecha_venta DATE NOT NULL,
    CONSTRAINT fk_ventas_clientes
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ventas_productos
        FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
GO

-- === SECCIÓN 3: INSERT ===
-- Cargar primero las tablas sin dependencias.
-- Se explicitan las columnas para identificar a qué campo corresponde cada valor.

-- Categorías: 4 registros.
INSERT INTO categorias (id_categoria, nombre_categoria, descripcion) VALUES
    (1, 'Computación', 'Laptops, PCs y monitores'),
    (2, 'Accesorios', 'Periféricos y complementos'),
    (3, 'Audio', 'Auriculares y parlantes'),
    (4, 'Almacenamiento', 'Discos y memorias');

-- Clientes: 5 registros.
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES
    (1, 'María López', 'maria@mail.com', 'Buenos Aires', '2024-01-05'),
    (2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', '2024-01-10'),
    (3, 'Ana Gómez', 'ana@mail.com', 'Rosario', '2024-02-01'),
    (4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15'),
    (5, 'Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01');

-- Productos: 6 registros. Las categorías referenciadas ya existen.
INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) VALUES
    (1, 'Laptop Pro 15', 1, 1200.00, 15, 1),
    (2, 'Mouse Inalámbrico', 2, 28.00, 80, 1),
    (3, 'Monitor 4K 27', 1, 450.00, 12, 1),
    (4, 'Auriculares BT Pro', 3, 120.00, 35, 1),
    (5, 'SSD Externo 1TB', 4, 130.00, 18, 1),
    (6, 'Teclado Mecánico', 2, 95.00, 40, 1);

-- Ventas: 10 registros. Los clientes y productos referenciados ya existen.
INSERT INTO ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta) VALUES
    (1, 1, 1, 2, 1200.00, '2024-03-05'),
    (2, 2, 2, 5, 28.00, '2024-03-06'),
    (3, 3, 3, 1, 450.00, '2024-03-07'),
    (4, 1, 4, 2, 120.00, '2024-03-08'),
    (5, 4, 5, 3, 130.00, '2024-03-10'),
    (6, 2, 6, 4, 95.00, '2024-03-11'),
    (7, 5, 1, 1, 1200.00, '2024-03-12'),
    (8, 3, 2, 8, 28.00, '2024-03-13'),
    (9, 4, 4, 1, 120.00, '2024-03-14'),
    (10, 5, 3, 2, 450.00, '2024-03-15');
GO

-- === SECCIÓN 4: VALIDACIÓN ===
-- Total esperado: 25 registros distribuidos entre las cuatro tablas.
SELECT * FROM categorias;   -- Esperado: 4 filas.
SELECT * FROM clientes;     -- Esperado: 5 filas.
SELECT * FROM productos;    -- Esperado: 6 filas.
SELECT * FROM ventas;       -- Esperado: 10 filas.

