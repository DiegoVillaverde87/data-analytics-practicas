-- Módulo 2, Unidad 1: diseño de tablas para un sistema de ventas.

CREATE TABLE clientes (
    -- INT guarda números enteros para identificar a cada cliente.
    id_cliente INT,

    -- VARCHAR(100) permite nombres de hasta 100 caracteres.
    nombre VARCHAR(100),

    -- TEXT permite guardar una biografía o notas extensas.
    perfil_bio TEXT,

    -- DATE guarda solamente la fecha, sin la hora.
    fecha_registro DATE
);

CREATE TABLE productos (
    -- INT guarda números enteros para identificar a cada producto.
    id_producto INT,

    -- VARCHAR(255) permite descripciones de hasta 255 caracteres.
    descripcion VARCHAR(255),

    -- DECIMAL(10, 2) guarda valores exactos: 10 dígitos en total, 2 decimales.
    precio DECIMAL(10, 2),

    -- SMALLINT guarda enteros pequeños; usamos 1 para activo y 0 para inactivo.
    esta_activo SMALLINT
);

