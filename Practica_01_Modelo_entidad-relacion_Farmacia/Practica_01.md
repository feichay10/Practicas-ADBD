# Practica 01. Modelo entida/relacion. Farmacia

Para diseñar un modelo entidad-relación (MER) para la gestión de una farmacia, debes identificar las entidades, atributos y relaciones que serán necesarios para representar adecuadamente el sistema. 

1. **Entidades Principales:**
   a. Medicamento
   b. Receta Médica
   c. Cliente
   d. Venta
   e. Empleado

2. **Atributos de la Entidad "Medicamento":**
   - Código de Medicamento (clave primaria)
   - Nombre del Medicamento
   - Tipo de Medicamento (por ejemplo, jarabe, comprimido, pomada)
   - Unidades en Stock
   - Unidades Vendidas
   - Precio
   - Venta Libre (booleano para indicar si es de venta libre o no)

3. **Atributos de la Entidad "Receta Médica":**
   - Número de Receta (clave primaria)
   - Fecha de Emisión
   - Médico Prescriptor
   - Información del Paciente (puede incluir el nombre del paciente, número de seguro social, etc.)
   - Medicamentos Prescritos (puede ser una lista de medicamentos con sus cantidades)

4. **Atributos de la Entidad "Cliente":**
   - ID de Cliente (clave primaria)
   - Nombre
   - Dirección
   - Número de Teléfono
   - Otros datos relevantes del cliente (por ejemplo, correo electrónico)

5. **Atributos de la Entidad "Venta":**
   - Número de Venta (clave primaria)
   - Fecha de Venta
   - Total de Venta
   - Método de Pago (efectivo, tarjeta, etc.)
   - ID de Cliente (clave foránea que relaciona la venta con un cliente, si es una venta registrada)

6. **Atributos de la Entidad "Empleado":**
   - ID de Empleado (clave primaria)
   - Nombre
   - Puesto
   - Fecha de Contratación
   - Salario
   - Otros detalles de empleados (por ejemplo, número de identificación)

7. **Relaciones:**
   a. Relación entre "Medicamento" y "Venta":
      - Un medicamento puede estar presente en varias ventas (relación uno a muchos).
   b. Relación entre "Medicamento" y "Receta Médica":
      - Un medicamento puede ser recetado en varias recetas médicas (relación uno a muchos).
   c. Relación entre "Cliente" y "Venta":
      - Un cliente puede realizar varias compras, pero una venta está asociada a un cliente (relación uno a muchos).
   d. Relación entre "Empleado" y "Venta":
      - Un empleado puede realizar varias ventas (relación uno a muchos).

8. **Cardinalidad de las Relaciones:**
   - "Medicamento" -> "Venta": Uno a muchos (un medicamento puede estar presente en varias ventas).
   - "Medicamento" -> "Receta Médica": Uno a muchos (un medicamento puede ser recetado en varias recetas).
   - "Cliente" -> "Venta": Uno a muchos (un cliente puede hacer varias compras).
   - "Empleado" -> "Venta": Uno a muchos (un empleado puede realizar varias ventas).

Este diseño conceptual del modelo entidad-relación te proporciona una base sólida para representar la gestión de una farmacia, teniendo en cuenta la catalogación de medicamentos, las ventas, las recetas médicas, los clientes y los empleados. Dependiendo de los detalles adicionales requeridos por tu sistema, es posible que desees agregar más atributos o relaciones.
