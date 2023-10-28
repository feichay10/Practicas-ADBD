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

/*Debe generar un script SQL con las siguientes características:
  ● Debe crear una base de datos viveros.
  ● Debe construir las tablas del modelo relacional. Elija para cada tabla los tipos
    de atributos más adecuados, las restricciones tipo CHECK así como las
    restricciones necesarias para realizar las operaciones de eliminación o
    actualización de forma oportuna (en cascada, por defecto, etc.).
  ● Debe definir correctamente los atributos de las tablas que sean derivados
  (calculados) en el modelo entidad-relación.
  ● Incluya al menos 5 filas en cada una de las tablas creadas. Las inserciones
  deben abordar todos los escenarios posibles en las tablas involucradas.
  ● Incluya ejemplos representativos de las operaciones DELETE.
*/

/* Las tablas que hay en la base de datos:
VIVERO(<u>id_vivero</u>, nombre_vivero, latitud_vivero, longitud_vivero) 
ASIGNA(<u>id_vivero</u>, <u>id_zona</u>)
ZONA(<u>id_zona</u>, nombre_zona, latitud_zona, longitud_zona, tipo_zona)
ALMACEN(<u>id_zona</u>, nombre_almacen)
ZONA_EXTERIOR(<u>id_zona</u>, nombre_zona_exterior)
EMPLEADO(<u>dni_empleado</u>, id_zona, nombre_empleado, tareas, productividad)
PRODUCTO(<u>nombre_producto</u>, id_zona, stock, precio, tipo_producto, dni_empleado, dni_plus, dni_cliente)
PLANTAS(<u>nombre_producto</u>, numero_plantas)
JARDINERIA(<u>nombre_producto</u>, numero_macetas)
DECORACION(<u>nombre_producto</u>, numero_decoracion)
CLIENTE_PLUS(<u>dni_plus</u>, nombre_plus, fecha_ingreso, pedidos_realizados, volumen_compra, dni_empleado)
CLIENTE(<u>dni_cliente</u>, nombre_cliente)
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
  id_vivero PRIMARY KEY,
  nombre_vivero VARCHAR(50) NOT NULL,
  latitud_vivero DECIMAL(10, 8) NOT NULL,
  longitud_vivero DECIMAL(11, 8) NOT NULL
);

CREATE TABLE ASIGNA (
  id_vivero INT NOT NULL,
  id_zona INT NOT NULL,
  PRIMARY KEY (id_vivero, id_zona),
  FOREIGN KEY (id_vivero) REFERENCES VIVERO(id_vivero) ON DELETE CASCADE,
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona) ON DELETE CASCADE
);

CREATE TABLE ZONA (
  id_zona PRIMARY KEY,
  nombre_zona VARCHAR(50) NOT NULL,
  latitud_zona DECIMAL(10, 8) NOT NULL,
  longitud_zona DECIMAL(11, 8) NOT NULL,
  tipo_zona VARCHAR(50) NOT NULL
);

CREATE TABLE ALMACEN (
  id_zona INT NOT NULL,
  nombre_almacen VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_zona, nombre_almacen),
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona) ON DELETE CASCADE
);

CREATE TABLE ZONA_EXTERIOR (
  id_zona INT NOT NULL,
  nombre_zona_exterior VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_zona, nombre_zona_exterior),
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona) ON DELETE CASCADE
);

CREATE TABLE EMPLEADO (
  dni_empleado PRIMARY KEY,
  id_zona INT NOT NULL,
  nombre_empleado VARCHAR(50) NOT NULL,
  tareas VARCHAR(50) NOT NULL,
  productividad INT NOT NULL,
  FOREIGN KEY (id_zona) REFERENCES ZONA(id_zona) ON DELETE CASCADE
);

CREATE TABLE PRODUCTO (
  nombre_producto PRIMARY KEY,
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

CREATE TABLE CLIENTE_PLUS (
  dni_plus PRIMARY KEY,
  nombre_plus VARCHAR(50) NOT NULL,
  fecha_ingreso DATE NOT NULL,
  pedidos_realizados INT NOT NULL,
  volumen_compra DECIMAL(10, 2) NOT NULL,
  dni_empleado VARCHAR(50) NOT NULL,
  FOREIGN KEY (dni_empleado) REFERENCES EMPLEADO(dni_empleado) ON DELETE CASCADE
);

CREATE TABLE CLIENTE (
  dni_cliente PRIMARY KEY,
  nombre_cliente VARCHAR(50) NOT NULL
);

-- Insertar datos
INSERT INTO VIVERO 
VALUES  (1, 'Vivero 1', 28.12345678, -16.12345678),
        (2, 'Vivero 2', 28.12345678, -16.12345678),
        (3, 'Vivero 3', 28.12345678, -16.12345678),
        (4, 'Vivero 4', 28.12345678, -16.12345678),
        (5, 'Vivero 5', 28.12345678, -16.12345678);

INSERT INTO ASIGNA
VALUES  (1, 1),
        (2, 2),
        (3, 3),
        (4, 4),
        (5, 5);

INSERT INTO ZONA
VALUES  (1, 'Zona 1', 28.12345678, -16.12345678, 'Interior'),
        (2, 'Zona 2', 28.12345678, -16.12345678, 'Interior'),
        (3, 'Zona 3', 28.12345678, -16.12345678, 'Interior'),
        (4, 'Zona 4', 28.12345678, -16.12345678, 'Interior'),
        (5, 'Zona 5', 28.12345678, -16.12345678, 'Interior');

INSERT INTO ALMACEN
VALUES  (1, 'Almacen 1'),
        (2, 'Almacen 2'),
        (3, 'Almacen 3'),
        (4, 'Almacen 4'),
        (5, 'Almacen 5');

INSERT INTO ZONA_EXTERIOR
VALUES  (1, 'Zona exterior 1'),
        (2, 'Zona exterior 2'),
        (3, 'Zona exterior 3'),
        (4, 'Zona exterior 4'),
        (5, 'Zona exterior 5');

INSERT INTO EMPLEADO
VALUES  ('12345678A', 1, 'Empleado 1', 'Tareas 1', 1),
        ('12345678B', 2, 'Empleado 2', 'Tareas 2', 2),
        ('12345678C', 3, 'Empleado 3', 'Tareas 3', 3),
        ('12345678D', 4, 'Empleado 4', 'Tareas 4', 4),
        ('12345678E', 5, 'Empleado 5', 'Tareas 5', 5);

INSERT INTO PRODUCTO
VALUES  ('Producto 1', 1, 1, 1.00, 'Planta', '12345678A', '12345678A', '12345678A'),
        ('Producto 2', 2, 2, 2.00, 'Planta', '12345678B', '12345678B', '12345678B'),
        ('Producto 3', 3, 3, 3.00, 'Planta', '12345678C', '12345678C', '12345678C'),
        ('Producto 4', 4, 4, 4.00, 'Planta', '12345678D', '12345678D', '12345678D'),
        ('Producto 5', 5, 5, 5.00, 'Planta', '12345678E', '12345678E', '12345678E');

INSERT INTO PLANTAS
VALUES  ('Producto 1', 1),
        ('Producto 2', 2),
        ('Producto 3', 3),
        ('Producto 4', 4),
        ('Producto 5', 5);

INSERT INTO JARDINERIA
VALUES  ('Producto 1', 1),
        ('Producto 2', 2),
        ('Producto 3', 3),
        ('Producto 4', 4),
        ('Producto 5', 5);

INSERT INTO DECORACION
VALUES  ('Producto 1', 1),
        ('Producto 2', 2),
        ('Producto 3', 3),
        ('Producto 4', 4),
        ('Producto 5', 5);

INSERT INTO CLIENTE_PLUS
VALUES  ('12345678A', 'Juan Perez', '2023-01-15', 5, 1500.75, '987654321'),
        ('12345678B', 'Maria Perez', '2023-01-15', 5, 1500.75, '987654321'),
        ('12345678C', 'Pedro Perez', '2023-01-15', 5, 1500.75, '987654321'),
        ('12345678D', 'Luis Perez', '2023-01-15', 5, 1500.75, '987654321'),
        ('12345678E', 'Ana Perez', '2023-01-15', 5, 1500.75, '987654321');

INSERT INTO CLIENTE  
VALUES  ('12345678P', 'Leopoldo Garcia'),
        ('12345678Q', 'Luis Garcia'),
        ('12345678R', 'Luisa Garcia'),
        ('12345678S', 'Luisana Garcia'),
        ('12345678T', 'Luisito Garcia');
