-- ============================================================
-- PROYECTO: URBAN VIBE
-- BASE DE DATOS PARA TIENDA DE ROPA EN LÍNEA
-- MOTOR: MySQL / MariaDB (XAMPP)
-- ============================================================


-- ============================================================
-- 1. CREACIÓN DE LA BASE DE DATOS
-- ============================================================

CREATE DATABASE IF NOT EXISTS urban_vibe
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE urban_vibe;


-- ============================================================
-- 2. TABLA: USUARIOS
-- ============================================================

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- ============================================================
-- 3. TABLA: CATEGORIAS
-- ============================================================

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;


-- ============================================================
-- 4. TABLA: PRODUCTOS
-- ============================================================

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    imagen VARCHAR(255) NOT NULL,
    etiqueta VARCHAR(20),
    estado ENUM('activo', 'inactivo') NOT NULL DEFAULT 'activo',
    id_categoria INT NOT NULL,

    -- Restricción para evitar precios negativos
    CONSTRAINT chk_producto_precio
        CHECK (precio >= 0),

    -- Restricción para evitar stock negativo
    CONSTRAINT chk_producto_stock
        CHECK (stock >= 0),

    -- Relación entre productos y categorías
    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ============================================================
-- 5. TABLA: PEDIDOS
-- ============================================================

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('pendiente', 'pagado', 'cancelado')
        NOT NULL DEFAULT 'pendiente',

    -- Restricción para evitar totales negativos
    CONSTRAINT chk_pedido_total
        CHECK (total >= 0),

    -- Relación entre pedidos y usuarios
    CONSTRAINT fk_pedido_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- ============================================================
-- 6. TABLA: DETALLE_PEDIDO
-- ============================================================

CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,

    -- La cantidad debe ser mayor que cero
    CONSTRAINT chk_detalle_cantidad
        CHECK (cantidad > 0),

    -- El precio no puede ser negativo
    CONSTRAINT chk_detalle_precio
        CHECK (precio_unitario >= 0),

    -- Relación entre detalle y pedido
    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    -- Relación entre detalle y producto
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;



-- ============================================================
-- PROYECTO: URBAN VIBE
-- FASE 2: POBLACIÓN Y MANIPULACIÓN DE DATOS (DML)
-- Motor: MySQL / MariaDB - XAMPP
-- ============================================================

-- ============================================================
-- 1. CREAR BASE DE DATOS
-- ============================================================

CREATE DATABASE IF NOT EXISTS urban_vibe
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE urban_vibe;


-- ============================================================
-- 2. CREAR TABLA: USUARIOS
-- ============================================================

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- ============================================================
-- 3. CREAR TABLA: CATEGORIAS
-- ============================================================

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;


-- ============================================================
-- 4. CREAR TABLA: PRODUCTOS
-- ============================================================

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    imagen VARCHAR(255) NOT NULL,
    etiqueta VARCHAR(20),
    estado ENUM('activo', 'inactivo') NOT NULL DEFAULT 'activo',
    id_categoria INT NOT NULL,

    CONSTRAINT chk_producto_precio
        CHECK (precio >= 0),

    CONSTRAINT chk_producto_stock
        CHECK (stock >= 0),

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ============================================================
-- 5. CREAR TABLA: PEDIDOS
-- ============================================================

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('pendiente', 'pagado', 'cancelado')
        NOT NULL DEFAULT 'pendiente',

    CONSTRAINT chk_pedido_total
        CHECK (total >= 0),

    CONSTRAINT fk_pedido_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- ============================================================
-- 6. CREAR TABLA: DETALLE_PEDIDO
-- ============================================================

CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,

    CONSTRAINT chk_detalle_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_detalle_precio
        CHECK (precio_unitario >= 0),

    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ============================================================
-- FASE 2 - DML
-- POBLACIÓN DE DATOS
-- ============================================================


-- ============================================================
-- 7. INSERTAR CATEGORIAS
-- ============================================================

INSERT INTO categorias (nombre) VALUES
('Camisas'),
('Pantalones'),
('Sudaderas');


-- ============================================================
-- 8. INSERTAR USUARIOS
-- ============================================================

INSERT INTO usuarios (nombre, correo, contrasena) VALUES
('Juan Arias', 'juan.arias@urbanvibe.com', 'hash_demo_001'),
('Esteban', 'esteban@urbanvibe.com', 'hash_demo_002'),
('David', 'david@urbanvibe.com', 'hash_demo_003'),
('Brayan', 'brayan@urbanvibe.com', 'hash_demo_004'),
('Juana', 'juana@urbanvibe.com', 'hash_demo_005'),
('Mariana', 'mariana@urbanvibe.com', 'hash_demo_006'),
('Andrea', 'andrea@urbanvibe.com', 'hash_demo_007'),
('Cliente Uno', 'cliente1@urbanvibe.com', 'hash_demo_008'),
('Cliente Dos', 'cliente2@urbanvibe.com', 'hash_demo_009'),
('Cliente Tres', 'cliente3@urbanvibe.com', 'hash_demo_010');


-- ============================================================
-- 9. INSERTAR PRODUCTOS
-- ============================================================

INSERT INTO productos
(nombre, precio, stock, imagen, etiqueta, estado, id_categoria)
VALUES
('Camiseta esencial', 35000, 25, 'camisa.png.jpeg', 'NUEVO', 'activo', 1),
('Sudadera urbana', 60000, 15, 'sudadera.png.jpeg', 'POPULAR', 'activo', 3),
('Jean clasico', 80000, 12, 'pantalon.png.jpeg', 'NUEVO', 'activo', 2),
('Camiseta estampada', 38000, 20, 'camisa1.png.jpeg', 'NUEVO', 'activo', 1),
('Camiseta oversize', 42000, 18, 'camisa2.png.jpeg', 'POPULAR', 'activo', 1),
('Camiseta grafica', 39000, 22, 'camisa3.png.jpeg', 'NUEVO', 'activo', 1),
('Camiseta manga larga', 45000, 14, 'camisa4.png.jpeg', 'NUEVO', 'activo', 1),
('Camiseta deportiva', 37000, 16, 'camisa5.png.jpeg', 'POPULAR', 'activo', 1),
('Conjunto Urban Vibe', 95000, 10, 'conjunto1.png.jpeg', 'POPULAR', 'activo', 3),
('Conjunto street', 98000, 8, 'conjunto2.png.jpeg', 'NUEVO', 'activo', 3),
('Conjunto oversize', 100000, 7, 'conjunto3.png.jpeg', 'NUEVO', 'activo', 3),
('Conjunto premium', 105000, 6, 'conjunto4.png.jpeg', 'POPULAR', 'activo', 3),
('Pantalon cargo', 75000, 13, 'pantalon1.png.jpeg', 'NUEVO', 'activo', 2),
('Pantalon jogger', 70000, 11, 'pantalon2.png.jpeg', 'POPULAR', 'activo', 2);


-- ============================================================
-- 10. INSERTAR PEDIDOS HISTORICOS
-- ============================================================

INSERT INTO pedidos (id_usuario, total, estado) VALUES
(1, 73000, 'pagado'),
(2, 140000, 'pagado'),
(3, 80000, 'pagado'),
(4, 120000, 'pagado'),
(5, 95000, 'pagado'),
(6, 45000, 'pagado'),
(7, 105000, 'pagado'),
(8, 79000, 'pagado'),
(9, 137000, 'pendiente'),
(10, 60000, 'cancelado');


-- ============================================================
-- 11. INSERTAR DETALLES DE LOS PEDIDOS
-- ============================================================

INSERT INTO detalle_pedido
(id_pedido, id_producto, cantidad, precio_unitario)
VALUES
(1, 1, 1, 35000),
(1, 4, 1, 38000),

(2, 2, 1, 60000),
(2, 3, 1, 80000),

(3, 3, 1, 80000),

(4, 2, 2, 60000),

(5, 9, 1, 95000),

(6, 7, 1, 45000),

(7, 12, 1, 105000),

(8, 8, 1, 37000),
(8, 5, 1, 42000),

(9, 10, 1, 98000),
(9, 6, 1, 39000),

(10, 2, 1, 60000);


-- ============================================================
-- 12. UPDATE DE PRODUCTO
-- Demostración de actualización segura con WHERE
-- ============================================================

UPDATE productos
SET stock = 30
WHERE id_producto = 1;


-- ============================================================
-- 13. VERIFICAR EL UPDATE
-- ============================================================

SELECT
    id_producto,
    nombre,
    stock
FROM productos
WHERE id_producto = 1;


-- ============================================================
-- 14. INSERTAR USUARIO TEMPORAL
-- Para demostrar DELETE seguro
-- ============================================================

INSERT INTO usuarios
(nombre, correo, contrasena)
VALUES
('Usuario Temporal',
 'temporal@urbanvibe.com',
 'hash_demo_011');


-- ============================================================
-- 15. VERIFICAR USUARIO TEMPORAL
-- ============================================================

SELECT *
FROM usuarios
WHERE correo = 'temporal@urbanvibe.com';


-- ============================================================
-- 16. DELETE SEGURO
-- Se elimina únicamente el usuario temporal
-- ============================================================

DELETE FROM usuarios
WHERE correo = 'temporal@urbanvibe.com';


-- ============================================================
-- 17. VERIFICAR EL DELETE
-- ============================================================

SELECT *
FROM usuarios
WHERE correo = 'temporal@urbanvibe.com';


-- ============================================================
-- 18. CONSULTA PARA COMPROBAR LAS RELACIONES
-- ENTRE PEDIDOS, USUARIOS Y PRODUCTOS
-- ============================================================

SELECT
    p.id_pedido,
    u.nombre AS cliente,
    pr.nombre AS producto,
    dp.cantidad,
    dp.precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS subtotal
FROM detalle_pedido dp
INNER JOIN pedidos p
    ON dp.id_pedido = p.id_pedido
INNER JOIN usuarios u
    ON p.id_usuario = u.id_usuario
INNER JOIN productos pr
    ON dp.id_producto = pr.id_producto;


-- ============================================================
-- FIN DE LA FASE 2
-- ============================================================




USE urban_vibe;

-- =====================================================
-- FASE 3: LÓGICA DE NEGOCIO Y OBJETOS AVANZADOS
-- PROYECTO: URBAN VIBE
-- =====================================================


-- =====================================================
-- 1. VISTA: CATÁLOGO DE PRODUCTOS ACTIVOS
-- =====================================================

CREATE OR REPLACE VIEW vista_catalogo_productos AS
SELECT
    p.id_producto,
    p.nombre AS producto,
    c.nombre AS categoria,
    p.precio,
    p.stock,
    p.etiqueta,
    p.estado
FROM productos p
INNER JOIN categorias c
    ON p.id_categoria = c.id_categoria
WHERE p.estado = 'activo';


-- Comprobación
SELECT * FROM vista_catalogo_productos;


-- =====================================================
-- 2. VISTA: RESUMEN DE VENTAS POR CLIENTE
-- =====================================================

CREATE OR REPLACE VIEW vista_resumen_ventas AS
SELECT
    u.id_usuario,
    u.nombre AS cliente,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    COALESCE(
        SUM(
            CASE
                WHEN p.estado = 'pagado'
                THEN p.total
                ELSE 0
            END
        ),
        0
    ) AS total_compras
FROM usuarios u
LEFT JOIN pedidos p
    ON u.id_usuario = p.id_usuario
GROUP BY
    u.id_usuario,
    u.nombre;


-- Comprobación
SELECT * FROM vista_resumen_ventas;


-- =====================================================
-- 3. PROCEDIMIENTO ALMACENADO
-- HISTORIAL DE COMPRAS DE UN CLIENTE
-- =====================================================

DELIMITER //

CREATE PROCEDURE sp_historial_compras_cliente(
    IN p_id_usuario INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN

    SELECT
        p.id_pedido,
        p.fecha_pedido,
        p.estado,
        p.total
    FROM pedidos p
    WHERE p.id_usuario = p_id_usuario
      AND DATE(p.fecha_pedido)
          BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY p.fecha_pedido DESC;

END //

DELIMITER ;


-- Prueba del procedimiento
CALL sp_historial_compras_cliente(
    1,
    '2026-01-01',
    '2026-12-31'
);


-- =====================================================
-- 4. TABLA PARA HISTORIAL DE PRECIOS
-- =====================================================

CREATE TABLE historial_precios (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10,2) NOT NULL,
    precio_nuevo DECIMAL(10,2) NOT NULL,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_historial_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- =====================================================
-- 5. TRIGGER DE AUDITORÍA DE PRECIOS
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_historial_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN

    IF OLD.precio <> NEW.precio THEN

        INSERT INTO historial_precios
        (
            id_producto,
            precio_anterior,
            precio_nuevo
        )
        VALUES
        (
            OLD.id_producto,
            OLD.precio,
            NEW.precio
        );

    END IF;

END //

DELIMITER ;


-- =====================================================
-- Prueba del TRIGGER
-- =====================================================

UPDATE productos
SET precio = 36000
WHERE id_producto = 1;

SELECT * FROM historial_precios;


-- =====================================================
-- 6. ÍNDICES
-- =====================================================

CREATE INDEX idx_productos_nombre
ON productos(nombre);

CREATE INDEX idx_productos_estado
ON productos(estado);

CREATE INDEX idx_pedidos_estado
ON pedidos(estado);


-- Comprobación
SHOW INDEX FROM productos;

SHOW INDEX FROM pedidos;


-- =====================================================
-- 7. TABLA TEMPORAL
-- PRODUCTOS CON BAJO STOCK
-- =====================================================

CREATE TEMPORARY TABLE tmp_productos_bajo_stock AS
SELECT
    id_producto,
    nombre,
    precio,
    stock
FROM productos
WHERE stock <= 10;


-- Consulta de la tabla temporal
SELECT * FROM tmp_productos_bajo_stock;


-- =====================================================
-- FIN DE LA FASE 3
-- =====================================================


USE urban_vibe;

-- =========================================================
-- FASE 4: INTEGRIDAD Y CONCURRENCIA
-- PROCESO DE CHECKOUT MEDIANTE TRANSACCIONES
-- =========================================================


-- =========================================================
-- PRUEBA 1: CHECKOUT EXITOSO
-- =========================================================
-- Se crea un pedido, se agregan sus productos,
-- se descuenta el stock y finalmente se confirma
-- la operación mediante COMMIT.

START TRANSACTION;

-- 1. Crear la cabecera del pedido
-- Cliente: Juan Arias (id_usuario = 1)
INSERT INTO pedidos (id_usuario, total, estado)
VALUES (1, 77000, 'pagado');

-- 2. Guardar el ID del pedido creado
SET @nuevo_pedido = LAST_INSERT_ID();

-- 3. Insertar los productos comprados
INSERT INTO detalle_pedido
    (id_pedido, id_producto, cantidad, precio_unitario)
VALUES
    (@nuevo_pedido, 1, 1, 35000),
    (@nuevo_pedido, 4, 1, 38000);

-- 4. Descontar el stock del producto 1
UPDATE productos
SET stock = stock - 1
WHERE id_producto = 1
  AND stock >= 1;

-- 5. Descontar el stock del producto 4
UPDATE productos
SET stock = stock - 1
WHERE id_producto = 4
  AND stock >= 1;

-- 6. Confirmar toda la operación
COMMIT;


-- =========================================================
-- VERIFICACIÓN DEL CHECKOUT EXITOSO
-- =========================================================

-- Ver el pedido creado
SELECT *
FROM pedidos
ORDER BY id_pedido DESC
LIMIT 1;

-- Ver los productos del pedido
SELECT
    dp.id_detalle,
    dp.id_pedido,
    dp.id_producto,
    dp.cantidad,
    dp.precio_unitario
FROM detalle_pedido dp
WHERE dp.id_pedido = @nuevo_pedido;

-- Verificar el stock después de la compra
SELECT
    id_producto,
    nombre,
    stock
FROM productos
WHERE id_producto IN (1, 4);


-- =========================================================
-- PRUEBA 2: STOCK INSUFICIENTE
-- =========================================================
-- Se intenta comprar una cantidad superior al stock disponible.
-- La operación NO debe confirmarse.

START TRANSACTION;

-- 1. Crear pedido de prueba
INSERT INTO pedidos (id_usuario, total, estado)
VALUES (2, 3500000, 'pagado');

-- 2. Guardar el ID del pedido de prueba
SET @pedido_prueba = LAST_INSERT_ID();

-- 3. Intentar comprar 100 unidades
INSERT INTO detalle_pedido
    (id_pedido, id_producto, cantidad, precio_unitario)
VALUES
    (@pedido_prueba, 1, 100, 35000);

-- 4. Consultar el stock disponible
SELECT stock
INTO @stock_disponible
FROM productos
WHERE id_producto = 1;

-- 5. Comprobar si existe stock suficiente
SELECT
    @stock_disponible AS stock_actual,
    100 AS cantidad_solicitada,
    CASE
        WHEN @stock_disponible >= 100
            THEN 'STOCK SUFICIENTE'
        ELSE 'STOCK INSUFICIENTE'
    END AS resultado;


-- =========================================================
-- 6. CANCELAR LA OPERACIÓN
-- =========================================================
-- Como no existe stock suficiente,
-- se revierte toda la transacción.

ROLLBACK;


-- =========================================================
-- VERIFICACIÓN DEL ROLLBACK
-- =========================================================

-- Comprobar que el pedido de prueba no quedó guardado
SELECT *
FROM pedidos
WHERE id_pedido = @pedido_prueba;

-- Comprobar que el stock no fue modificado
SELECT
    id_producto,
    nombre,
    stock
FROM productos
WHERE id_producto = 1;


-- =========================================================
-- FIN DE LA FASE 4
-- =========================================================

-- =========================================================
-- FASE 5 - ROLES, USUARIOS Y PERMISOS
-- BASE DE DATOS: urban_vibe
-- =========================================================

USE urban_vibe;


-- =========================================================
-- 1. CREAR ROLES
-- =========================================================

CREATE ROLE IF NOT EXISTS 'App_Backend';

CREATE ROLE IF NOT EXISTS 'Administrador';


-- =========================================================
-- 2. PERMISOS PARA EL ROL App_Backend
-- El backend puede consultar productos y categorías
-- =========================================================

GRANT SELECT
ON urban_vibe.productos
TO 'App_Backend';

GRANT SELECT
ON urban_vibe.categorias
TO 'App_Backend';


-- =========================================================
-- 3. PERMISOS PARA EL ROL Administrador
-- =========================================================

GRANT SELECT
ON urban_vibe.pedidos
TO 'Administrador';

GRANT SELECT
ON urban_vibe.usuarios
TO 'Administrador';

GRANT SELECT
ON urban_vibe.detalle_pedido
TO 'Administrador';

GRANT SELECT, INSERT, UPDATE
ON urban_vibe.categorias
TO 'Administrador';

GRANT SELECT, INSERT, UPDATE
ON urban_vibe.productos
TO 'Administrador';


-- =========================================================
-- 4. CREAR USUARIO PARA LA APLICACIÓN
-- =========================================================

CREATE USER IF NOT EXISTS
'cliente_app'@'localhost'
IDENTIFIED BY 'Cliente123';


-- =========================================================
-- 5. CREAR USUARIO ADMINISTRADOR
-- =========================================================

CREATE USER IF NOT EXISTS
'admin_urban'@'localhost'
IDENTIFIED BY 'Admin123';


-- =========================================================
-- 6. ASIGNAR ROL App_Backend AL USUARIO CLIENTE
-- =========================================================

GRANT 'App_Backend'
TO 'cliente_app'@'localhost';

SET DEFAULT ROLE
'App_Backend'
FOR 'cliente_app'@'localhost';


-- =========================================================
-- 7. ASIGNAR ROL Administrador AL USUARIO ADMIN
-- =========================================================

GRANT 'Administrador'
TO 'admin_urban'@'localhost';

SET DEFAULT ROLE
'Administrador'
FOR 'admin_urban'@'localhost';


-- =========================================================
-- 8. ACTUALIZAR PRIVILEGIOS
-- =========================================================

FLUSH PRIVILEGES;


-- =========================================================
-- 9. VERIFICAR LOS PERMISOS DE App_Backend
-- =========================================================

SHOW GRANTS FOR 'App_Backend';


-- =========================================================
-- 10. VERIFICAR LOS PERMISOS DE Administrador
-- =========================================================

SHOW GRANTS FOR 'Administrador';


-- =========================================================
-- 11. VERIFICAR EL USUARIO CLIENTE
-- =========================================================

SHOW GRANTS FOR 'cliente_app'@'localhost';


-- =========================================================
-- 12. VERIFICAR EL USUARIO ADMINISTRADOR
-- =========================================================

SHOW GRANTS FOR 'admin_urban'@'localhost';


-- =========================================================
-- FIN DE LA FASE 5
-- =========================================================