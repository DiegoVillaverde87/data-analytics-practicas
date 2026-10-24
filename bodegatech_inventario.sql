-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Diego Villaverde
-- Fecha: 2026-10-24
-- Entorno: SQL Server 2016 o posterior (SSMS)
-- ══════════════════════════════════════════

-- ── SECCIÓN DDL ──────────────────────────

-- Paso 1: eliminar la tabla anterior para poder repetir la práctica.
DROP TABLE IF EXISTS inventario;
-- GO separa este lote de la creación de la tabla en SSMS.
GO

-- Paso 2: crear la estructura del inventario.
CREATE TABLE inventario (
    -- INT guarda un identificador entero; PRIMARY KEY evita duplicados y nulos.
    id_producto INT PRIMARY KEY,

    -- VARCHAR(100) permite nombres de hasta 100 caracteres.
    nombre_producto VARCHAR(100),

    -- VARCHAR(50) permite categorías breves de hasta 50 caracteres.
    categoria VARCHAR(50),

    -- DECIMAL guarda importes exactos: 10 dígitos en total, incluidos 2 decimales.
    precio_unitario DECIMAL(10, 2),

    -- INT representa unidades enteras disponibles.
    stock_actual INT,

    -- INT representa el umbral de reposición en unidades enteras.
    stock_minimo INT,

    -- DATE guarda la fecha de ingreso sin incluir una hora.
    fecha_ingreso DATE,

    -- TINYINT guarda enteros pequeños; usamos 1 = disponible y 0 = descontinuado.
    -- En SQL Server se escribe TINYINT, sin (1).
    activo TINYINT
);
GO

-- ── SECCIÓN DML ──────────────────────────

-- Paso 3: cargar los 10 productos, indicando el orden de las columnas.
INSERT INTO inventario (
    id_producto,
    nombre_producto,
    categoria,
    precio_unitario,
    stock_actual,
    stock_minimo,
    fecha_ingreso,
    activo
)
VALUES
    (1, 'Laptop Pro 15', 'Computación', 1200.00, 15, 3, '2024-01-10', 1),
    (2, 'Mouse Inalámbrico', 'Accesorios', 28.00, 80, 10, '2024-01-10', 1),
    (3, 'Monitor 4K 27"', 'Computación', 450.00, 12, 2, '2024-01-15', 1),
    (4, 'Teclado Mecánico', 'Accesorios', 95.00, 40, 5, '2024-01-15', 1),
    (5, 'Laptop Basic 14', 'Computación', 650.00, 20, 3, '2024-02-01', 1),
    (6, 'Auriculares BT Pro', 'Audio', 120.00, 35, 5, '2024-02-01', 1),
    (7, 'Hub USB-C 7 puertos', 'Accesorios', 45.00, 60, 10, '2024-02-10', 1),
    (8, 'Webcam HD 1080p', 'Accesorios', 85.00, 25, 5, '2024-02-10', 1),
    (9, 'SSD Externo 1TB', 'Almacenamiento', 130.00, 18, 3, '2024-03-01', 1),
    (10, 'Parlante Bluetooth', 'Audio', 60.00, 45, 8, '2024-03-01', 1);

-- Paso 4: registrar las ventas del día.

-- Venta de 3 unidades de Laptop Pro 15: 15 - 3 = 12.
UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto = 1;

-- Venta de 12 unidades de Mouse Inalámbrico: 80 - 12 = 68.
UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto = 2;

-- Venta de 5 unidades de Auriculares BT Pro: 35 - 5 = 30.
UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto = 6;

-- Paso 5: marcar la Webcam HD 1080p como descontinuada.
UPDATE inventario
SET activo = 0
WHERE id_producto = 8;

-- Paso 6: ver la tabla completa para confirmar que los datos se cargaron.
SELECT * FROM inventario;

