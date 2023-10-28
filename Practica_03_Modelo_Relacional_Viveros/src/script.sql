/*
 * Universidad de La Laguna
 * Escuela Superior de Ingeniería y Tecnología
 * Grado en Ingeniería Informática
 * Asignatura: Administración y Diseño de Bases de Datos
 * Curso: 4º
 * Práctica 3: Modelo relacional. Viveros
 * Autor: Cheuk Kelly Ng Pante (alu0101364544@ull.edu.es)
 * Fecha: 01/11/2023
 * Descripción: Creación de una base de datos para viveros
 */

-- Crear base de datos
DROP DATABASE IF EXISTS VIVEROS;
CREATE DATABASE viveros;

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- Eliminar tablas si existen
DROP TABLE IF EXISTS VIVEROS;
DROP TABLE IF EXISTS ASIGNA;
DROP TABLE IF EXISTS ZONA;
DROP TABLE IF EXISTS ALMACEN;
DROP TABLE IF EXISTS ZONA_EXTERIOR;
DROP TABLE IF EXISTS EMPLEADO;
DROP TABLE IF EXISTS PRODUCTO;
DROP TABLE IF EXISTS PLANTAS;
DROP TABLE IF EXISTS JARDINERIA;
DROP TABLE IF EXISTS DECORACION;
DROP TABLE IF EXISTS CLIENTE_PLUS;
DROP TABLE IF EXISTS CLIENTE;

-- Crear tablas
CREATE TABLE VIVERO (
  id_vivero INT PRIMARY KEY,
  nombre_vivero VARCHAR(50) NOT NULL,
  latitud_vivero DECIMAL(10, 8) NOT NULL,
  longitud_vivero DECIMAL(11, 8) NOT NULL
  CONSTRAINT CHK_VIVERO_COORDENADAS CHECK (latitud_vivero BETWEEN -90 AND 90 AND longitud_vivero BETWEEN -180 AND 180)
);

CREATE TABLE ZONA (
  id_zona INT PRIMARY KEY,
  nombre_zona VARCHAR(50) NOT NULL,
  latitud_zona DECIMAL(10, 8) NOT NULL,
  longitud_zona DECIMAL(11, 8) NOT NULL,
  tipo_zona VARCHAR(50) NOT NULL
  CONSTRAINT CHK_ZONA_TIPO CHECK (tipo_zona IN ('Almacen', 'Zona_exterior'))
);

CREATE TABLE ASIGNA (
  id_vivero INT NOT NULL,
  id_zona INT NOT NULL,
  PRIMARY KEY (id_vivero, id_zona),
  FOREIGN KEY (id_vivero) REFERENCES VIVERO(id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona) ON DELETE CASCADE
);

CREATE TABLE ALMACEN (
  id_zona INT PRIMARY KEY,
  nombre_almacen VARCHAR(50) NOT NULL
);

CREATE TABLE ZONA_EXTERIOR (
  id_zona INT PRIMARY KEY,
  nombre_zona_exterior VARCHAR(50) NOT NULL
);

CREATE TABLE EMPLEADO (
  dni_empleado VARCHAR(50) PRIMARY KEY,
  id_zona INT NOT NULL,
  nombre_empleado VARCHAR(50) NOT NULL,
  tareas VARCHAR(50) NOT NULL,
  productividad INT NOT NULL,
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona) ON DELETE CASCADE
);

CREATE TABLE CLIENTE_PLUS (
  dni_plus VARCHAR(50) PRIMARY KEY,
  nombre_plus VARCHAR(50) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  pedidos_realizados INT NOT NULL,
  volumen_compra DECIMAL(10, 2) NOT NULL,
  dni_empleado VARCHAR(50) NOT NULL,
  FOREIGN KEY (dni_empleado) REFERENCES EMPLEADO(dni_empleado) ON DELETE CASCADE
);

CREATE TABLE CLIENTE (
  dni_cliente VARCHAR(50) PRIMARY KEY,
  nombre_cliente VARCHAR(50) NOT NULL
);

CREATE TABLE PRODUCTO (
  nombre_producto VARCHAR(50) PRIMARY KEY,
  id_zona INT NOT NULL,
  stock INT NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  tipo_producto VARCHAR(50) NOT NULL,
  dni_empleado VARCHAR(50) NOT NULL,
  dni_plus VARCHAR(50) NOT NULL, 
  dni_cliente VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona) ON DELETE CASCADE,
  FOREIGN KEY (dni_empleado) REFERENCES EMPLEADO(dni_empleado) ON DELETE CASCADE,
  FOREIGN KEY (dni_plus) REFERENCES CLIENTE_PLUS(dni_plus) ON DELETE CASCADE,
  FOREIGN KEY (dni_cliente) REFERENCES CLIENTE(dni_cliente) ON DELETE CASCADE
);

CREATE TABLE PLANTAS (
  nombre_producto VARCHAR(50) PRIMARY KEY,
  numero_plantas INT NOT NULL,
  FOREIGN KEY (nombre_producto) REFERENCES PRODUCTO(nombre_producto) ON DELETE CASCADE
);

CREATE TABLE JARDINERIA (
  nombre_producto VARCHAR(50) PRIMARY KEY,
  numero_macetas INT NOT NULL,
  FOREIGN KEY (nombre_producto) REFERENCES PRODUCTO(nombre_producto) ON DELETE CASCADE
);

CREATE TABLE DECORACION (
  nombre_producto VARCHAR(50) PRIMARY KEY,
  numero_decoracion INT NOT NULL,
  FOREIGN KEY (nombre_producto) REFERENCES PRODUCTO(nombre_producto) ON DELETE CASCADE
);

-- Insertar datos
INSERT INTO VIVERO (id_vivero, nombre_vivero, latitud_vivero, longitud_vivero)
VALUES  (1, 'Vivero A', 40.7128, -74.0060),
        (2, 'Vivero B', 34.0522, -118.2437),
        (3, 'Vivero C', 41.8781, -87.6298),
        (4, 'Vivero D', 29.7604, -95.3698),
        (5, 'Vivero E', 37.7749, -122.4194);

INSERT INTO ZONA (id_zona, nombre_zona, latitud_zona, longitud_zona, tipo_zona)
VALUES  (1, 'Zona 1', 39.9526, -75.1652, 'Almacen'),
        (2, 'Zona 2', 38.9072, -77.0369, 'Almacen'),
        (3, 'Zona 3', 42.3601, -71.0589, 'Zona_exterior'),
        (4, 'Zona 4', 25.7617, -80.1918, 'Almacen'),
        (5, 'Zona 5', 33.7490, -84.3880, 'Zona_exterior');

INSERT INTO ASIGNA (id_vivero, id_zona)
VALUES  (1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 5);

INSERT INTO ALMACEN (id_zona, nombre_almacen)
VALUES  (1, 'Almacen 1'),
        (2, 'Almacen 2'),
        (3, 'Almacen 3'),
        (4, 'Almacen 4'),
        (5, 'Almacen 5');

INSERT INTO ZONA_EXTERIOR (id_zona, nombre_zona_exterior)
VALUES  (1, 'Zona exterior 1'),
        (2, 'Zona exterior 2'),
        (3, 'Zona exterior 3'),
        (4, 'Zona exterior 4'),
        (5, 'Zona exterior 5');

INSERT INTO EMPLEADO (dni_empleado, id_zona, nombre_empleado, tareas, productividad)
VALUES  ('12345678A', 1, 'Pedro Rodriguez Martin', 'Tareas 1', 1),
        ('12345678B', 2, 'Ana Lorenzo Lopez', 'Tareas 2', 2),
        ('12345678C', 3, 'Gerardo Martin Navarro', 'Tareas 3', 3),
        ('12345678D', 4, 'Nuria Miranda Corujo', 'Tareas 4', 4),
        ('12345678E', 5, 'Aroa Fernandez Acosta', 'Tareas 5', 5);

INSERT INTO CLIENTE_PLUS (dni_plus, nombre_plus, fecha_ingreso, pedidos_realizados, volumen_compra, dni_empleado)
VALUES  ('76572129K', 'Juan Perez Acosta', '2023-01-15', 5, 1500.75, '12345678A'),
        ('43123311L', 'Maria Lago Gonzalez', '2023-01-15', 5, 1500.75, '12345678B'),
        ('88172212M', 'Pedro Ruiz Diaz', '2023-01-15', 5, 1500.75, '12345678C'),
        ('33212490J', 'Luis Sanchez Morales', '2023-01-15', 5, 1500.75, '12345678D'),
        ('92781284X', 'Ana Jimenez Torres', '2023-01-15', 5, 1500.75, '12345678E');

INSERT INTO CLIENTE (dni_cliente, nombre_cliente)
VALUES  ('12345678P', 'Leopoldo Ramos Mendoza'),
        ('12345678Q', 'Mario Nuñez Perez'),
        ('12345678R', 'Luisa Ortega Garcia'),
        ('12345678S', 'Sergio Rodriguez Lopez'),
        ('12345678T', 'Carlos Estevez Martin');

INSERT INTO PRODUCTO (nombre_producto, id_zona, stock, precio, tipo_producto, dni_empleado, dni_plus, dni_cliente)
VALUES  ('Palmera', 2, 10, 7.00, 'Plantas', '12345678B', '43123311L', '12345678Q'),
        ('Rosas', 4, 76, 3.50, 'Plantas', '12345678D', '33212490J', '12345678S'),
        ('Girasoles', 3, 3, 1.00, 'Plantas', '12345678C', '88172212M', '12345678R'),
        ('Bonsai', 4, 76, 3.50, 'Plantas', '12345678D', '33212490J', '12345678S'),
        ('Cactus', 5, 15, 55.00, 'Plantas', '12345678E', '92781284X', '12345678T'),
        ('Maceta mediana', 1, 87, 5.00, 'Jardineria', '12345678A', '76572129K', '12345678P'),
        ('Maceta grande', 2, 10, 7.00, 'Jardineria', '12345678B', '43123311L', '12345678Q'),
        ('Maceta plastico', 3, 3, 1.00, 'Jardineria', '12345678C', '88172212M', '12345678R'),
        ('Maceta marmol', 4, 76, 3.50, 'Jardineria', '12345678D', '33212490J', '12345678S'),
        ('Maceta fibra de carbono', 5, 15, 55.00, 'Jardineria', '12345678E', '92781284X', '12345678T'),
        ('Estatua', 5, 15, 55.00, 'Decoracion', '12345678E', '92781284X', '12345678T'),
        ('Banco jardin', 5, 15, 55.00, 'Decoracion', '12345678E', '92781284X', '12345678T'),
        ('Muebles exterior', 5, 15, 55.00, 'Decoracion', '12345678E', '92781284X', '12345678T'),
        ('Piedras decorativas', 5, 15, 55.00, 'Decoracion', '12345678E', '92781284X', '12345678T'),
        ('Lamparas', 5, 15, 55.00, 'Decoracion', '12345678E', '92781284X', '12345678T');

INSERT INTO PLANTAS (nombre_producto, numero_plantas)
VALUES  ('Palmera', 1),
        ('Rosas', 2),
        ('Girasoles', 3),
        ('Bonsai', 4),
        ('Cactus', 5);

INSERT INTO JARDINERIA (nombre_producto, numero_macetas)
VALUES  ('Maceta mediana', 1),
        ('Maceta grande', 2),
        ('Maceta plastico', 3),
        ('Maceta marmol', 4),
        ('Maceta fibra de carbono', 5);

INSERT INTO DECORACION (nombre_producto, numero_decoracion)
VALUES  ('Estatua', 1),
        ('Banco jardin', 2),
        ('Muebles exterior', 3),
        ('Piedras decorativas', 4),
        ('Lamparas', 5);

-- Verificar la restricción CHECK en la tabla VIVERO
SELECT * FROM VIVERO 
WHERE latitud_vivero NOT BETWEEN -90 AND 90 
OR longitud_vivero NOT BETWEEN -180 AND 180;

-- Verificar la restricción CHECK en la tabla ZONA
SELECT * FROM ZONA 
WHERE tipo_zona NOT IN ('Almacen', 'Zona_exterior');
