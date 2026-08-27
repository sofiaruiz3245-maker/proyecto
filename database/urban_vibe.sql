-- Base de datos: Urban Vibe
-- Motor: MySQL / MariaDB (XAMPP)

CREATE DATABASE IF NOT EXISTS urban_vibe
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE urban_vibe;

-- Tabla: usuarios (equivale a AuthContext.jsx)
CREATE TABLE usuarios (
  id_usuario     INT AUTO_INCREMENT PRIMARY KEY,
  nombre         VARCHAR(100) NOT NULL,
  correo         VARCHAR(150) NOT NULL UNIQUE,
  contrasena     VARCHAR(255) NOT NULL, -- guardar siempre con hash (bcrypt)
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabla: categorias (Camisas, Pantalones, Sudaderas)
CREATE TABLE categorias (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Tabla: productos (equivale al arreglo de Home.jsx)
CREATE TABLE productos (
  id_producto  INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(150) NOT NULL,
  precio       DECIMAL(10,2) NOT NULL,
  imagen       VARCHAR(255) NOT NULL,
  etiqueta     VARCHAR(20),            -- NUEVO / POPULAR
  id_categoria INT NOT NULL,
  CONSTRAINT fk_producto_categoria
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Tabla: pedidos (equivale a "Proceder al pago" en Carrito.jsx)
CREATE TABLE pedidos (
  id_pedido    INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario   INT NOT NULL,
  fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total        DECIMAL(10,2) NOT NULL,
  estado       ENUM('pendiente', 'pagado', 'cancelado') DEFAULT 'pendiente',
  CONSTRAINT fk_pedido_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabla: detalle_pedido (productos dentro de cada pedido)
CREATE TABLE detalle_pedido (
  id_detalle       INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido        INT NOT NULL,
  id_producto      INT NOT NULL,
  cantidad         INT NOT NULL DEFAULT 1,
  precio_unitario  DECIMAL(10,2) NOT NULL, -- precio al momento de comprar
  CONSTRAINT fk_detalle_pedido
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_detalle_producto
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Datos iniciales: categorías
INSERT INTO categorias (nombre) VALUES
  ('Camisas'),
  ('Pantalones'),
  ('Sudaderas');

-- Datos iniciales: productos (mismos de src/pages/Home.jsx)
INSERT INTO productos (nombre, precio, imagen, etiqueta, id_categoria) VALUES
  ('Camiseta esencial',    35000, 'camisa.png.jpeg',    'NUEVO',   1),
  ('Sudadera urbana',      60000, 'sudadera.png.jpeg',  'POPULAR', 3),
  ('Jean clásico',         80000, 'pantalon.png.jpeg',  'NUEVO',   2),
  ('Camiseta estampada',   38000, 'camisa1.png.jpeg',   'NUEVO',   1),
  ('Camiseta oversize',    42000, 'camisa2.png.jpeg',   'POPULAR', 1),
  ('Camiseta gráfica',     39000, 'camisa3.png.jpeg',   'NUEVO',   1),
  ('Camiseta manga larga', 45000, 'camisa4.png.jpeg',   'NUEVO',   1),
  ('Camiseta deportiva',   37000, 'camisa5.png.jpeg',   'POPULAR', 1),
  ('Conjunto Urban Vibe',  95000, 'conjunto1.png.jpeg', 'POPULAR', 3),
  ('Conjunto street',      98000, 'conjunto2.png.jpeg', 'NUEVO',   3),
  ('Conjunto oversize',   100000, 'conjunto3.png.jpeg', 'NUEVO',   3),
  ('Conjunto premium',    105000, 'conjunto4.png.jpeg', 'POPULAR', 3),
  ('Pantalón cargo',       75000, 'pantalon1.png.jpeg', 'NUEVO',   2),
  ('Pantalón jogger',      70000, 'pantalon2.png.jpeg', 'POPULAR', 2);
