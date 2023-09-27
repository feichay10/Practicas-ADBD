# Practica 01. Modelo entida/relacion. Farmacia

Para diseñar un modelo entidad-relación (MER) para la gestión de una farmacia, hay que identificar las entidades, atributos y relaciones que serán necesarios para representar adecuadamente el sistema.

El diseño conceptual del modelo entidad/relación para la gestión de una farmacia se puede representar de la siguiente manera:

**Entidades Principales:**

1. **Medicamento**:
   - Atributos: Código de Medicamento (Clave Primaria), Nombre, Tipo de Medicamento, Unidades en Stock, Unidades Vendidas, Precio, Venta con Receta.

2. **Laboratorio**:
   - Atributos: Código de Laboratorio (Clave Primaria), Nombre, Teléfono, Dirección, Fax, Nombre de la Persona de Contacto.

3. **Familia de Medicamentos**:
   - Atributos: Código de Familia (Clave Primaria), Nombre de la Familia.

4. **Cliente**:
   - Atributos: ID de Cliente (Clave Primaria), Nombre, Dirección, Teléfono, Datos Bancarios.

5. **Compra**:
   - Atributos: ID de Compra (Clave Primaria), Fecha de Compra.

6. **Detalle de Compra**:
   - Atributos: ID de Detalle (Clave Primaria), Cantidad Comprada, Precio Unitario, Total, Medicamento (Clave Foranea), Compra (Clave Foranea).

7. **Pago de Cliente**:
   - Atributos: ID de Pago (Clave Primaria), Fecha de Pago, Monto, Cliente (Clave Foranea).

**Relaciones:**

- **Medicamento-Laboratorio (1 a N)**:
  - Un medicamento es fabricado o suministrado por un laboratorio, pero un laboratorio puede tener varios medicamentos. Relación de uno a muchos entre Laboratorio y Medicamento.

- **Medicamento-Familia (N a M)**:
  - Un medicamento puede pertenecer a una o varias familias de medicamentos, y una familia puede tener varios medicamentos. Relación de muchos a muchos entre Medicamento y Familia de Medicamentos.

- **Compra-Detalle de Compra (1 a N)**:
  - Una compra puede tener uno o varios detalles de compra, pero cada detalle de compra pertenece a una única compra. Relación de uno a muchos entre Compra y Detalle de Compra.

- **Medicamento-Detalle de Compra (N a M)**:
  - Un detalle de compra se refiere a un medicamento específico, y un medicamento puede estar presente en varios detalles de compra. Relación de muchos a muchos entre Medicamento y Detalle de Compra.

- **Compra-Cliente (N a 1)**:
  - Una compra está asociada a un cliente, pero un cliente puede tener varias compras. Relación de uno a muchos entre Cliente y Compra.

- **Pago de Cliente-Cliente (1 a 1)**:
  - Un pago de cliente está asociado a un cliente y un cliente puede tener varios pagos. Relación uno a uno entre Pago de Cliente y Cliente.

Con este diseño conceptual, puedes gestionar eficazmente los medicamentos, laboratorios, familias de medicamentos, compras, detalles de compra, clientes y pagos en una farmacia, cumpliendo con las especificaciones mencionadas.