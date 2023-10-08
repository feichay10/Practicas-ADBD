# Modelo entidad/relación. Farmacia
## Objetivos
Los principales objetivos de esta práctica son los siguientes:
* Practicar la modelización conceptual mediante esquemas entidad/relación.
## Recursos
* Draw.io
## Descripción
Crea en Draw.io (u otro software de similares características) un modelo
entidad/relación para el siguiente escenario.

La gestión de una farmacia requiere poder llevar control de los medicamentos existentes, así como de los que se van sirviendo, para lo cual se pretende diseñar un sistema acorde a las siguientes especificaciones:

* En la farmacia se requiere una catalogación de todos los medicamentos existentes, para lo cual se almacenará un código de medicamento, nombre del medicamento, tipo de medicamento (jarabe, comprimido, pomada,..) unidades en stock, unidades vendidas y precio. Existen medicamentos de venta libre y otros que sólo se pueden dispensar con receta médica.
* La farmacia compra cada medicamento a un laboratorio, o bien los fabrica ella
misma. Se desea conocer el código del laboratorio, nombre, teléfono, dirección y fax, así como el nombre de la persona de contacto.
* Los medicamentos se agrupan en familias, dependiendo del tipo de enfermedades a las que dicho medicamento se aplica. De este modo, si la farmacia no dispone de un medicamento concreto, puede vender otro similar aunque de distinto laboratorio.
* La farmacia tiene algunos clientes que realizan los pagos de sus pedidos a fin de cada mes (clientes con crédito). La farmacia quiere mantener las unidades de cada medicamento comprado (con o sin crédito) así como la fecha de compra. Además, es necesario conocer los datos bancarios de los clientes con crédito, así como la fecha de pago de las compras que realizan.