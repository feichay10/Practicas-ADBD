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

-- Crear base de datos
DROP DATABASE IF EXISTS VIVEROS;
CREATE DATABASE viveros;