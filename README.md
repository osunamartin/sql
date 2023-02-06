MySQL


### Descripción de base de datos (esquema magiaShop): 

La idea principal de esta base de datos es crear tablas con registros para consultas y acceso rápido para una tienda especializada en artículos de ilusionismo (donde magos amateurs y profesionales pueden compran productos para realizar en sus espectáculos). La BB.DD contaría con tablas con precios de productos, y registros de pedidos a realizar ya que contaría con servicio de envíos. Así mismo, guardaría datos de clientes (direcciones, contacto y productos a enviar) como también así un seguimiento de los productos de la tienda para poder actualizar sus precios conforme pase el tiempo, agregar nuevas adquisiciones y otros efectos de magia nuevos mientras dichas novedades lleguen al local.
Con respecto a la tienda en sí, contará con tablas para registros de los mismos empleados, sus puestos y otros datos generales. También se mantendrán registros de los proveedores de la tienda (artículos de librería, papeleras y materia prima variada de ser necesaria).
Finalmente, se tendrán tablas con registros de vendedores y otras tiendas autorizadas por fuera de la empresa (si es que estos se encuentran fuera del país, aunque responden directamente a la principal).
El objetivo de esta base de datos es mantener registro de todo lo que ocurre en la tienda, solucionando así los problemas de stock, pedidos y en caso de algo salir mal, poder consultar y tener fácil y rápido acceso a los datos. Como opción agregada, se buscaría un desarrollador que programe una interfaz funcional y visual para el acceso rápido a esta base de datos sin necesidad de conocer el lenguaje SQL.
Finalmente, frente a una posible problemática de pérdida de datos y/o posibles estafas por parte de falsos clientes, la base de datos ayudaría simplemente con backups y consultando clientes frente a reclamos para corroborar fácilmente si se trata de algo real o un intento de fraude.



---------


### Tablas de la entidad Cliente:

IdCliente: Clave primaria, número de identificación del cliente. Tipo de dato int (número entero) 

Nombre: Nombres de los clientes. Tipo de dato varchar (alfanumérico) 

Dirección: Dirección de entrega de pedidos de los clientes. Tipo de dato varchar (alfanumérico) 

CodPostal: Código postal de la dirección ya ingresada. Tipo de dato int (número entero) 

País: País de residencia del cliente (correspondiente a los datos de dirección y código postal). Tipo de dato varchar (alfanumérico) 

Contacto: Número de teléfono o e-mail de contacto. Tipo de dato varchar (alfanumérico)

---------

### Tablas de la entidad Productos:

IdProducto: Clave primaria, número de identificación del producto. Tipo de dato int (número entero) 

Nombre: Nombres de los productos. Tipo de dato varchar (alfanumérico) 

Categoría: Tipo de show en el que se utiliza dicho producto (magia de salón, de cerca, escenario o callejera). Tipo de dato varchar (alfanumérico) 

Audiencia: Audiencia espectadora de dicho producto (adultos o niños). Tipo de dato varchar (alfanumérico) 

Precio: Precio unitario del producto. Tipo de dato float (número decimal) 

Stock: Cantidad de unidades en stock del producto en la tienda. Tipo de dato int (número entero)

-----------------
### Tablas de la entidad Pedido:

IdCliente: Clave foránea, número de identificación conectado con la entidad Cliente. Tipo de dato int (número entero)

Valor: Valor total del pedido. Tipo de dato float (número decimal) 

Peso: Peso total del paquete con el pedido realizado. Tipo de dato float (decimal) 

IdProducto: Clave foránea, número de identificación conectado con la entidad Producto. Tipo de dato int (número entero) 

Cantidad: Cantidad de productos en el paquete. Tipo de dato int (número entero) 

IdPedido: Clave primaria, número de identificación del pedido. Tipo de dato int (número entero)

------------
### Tablas de la entidad ProductosPedido (intermedia entre Productos y Pedidos):
 
IdProdPed: Clave primaria, número de identificación de los productos dentro del pedido. Tipo de dato int (número entero)
 
IdPedido: Clave foránea, número de identificación conectado con la entidad Pedido. Tipo de dato int (número entero) 

Fecha: Fecha generada automáticamente cuando se agrega un producto al pedido. Tipo de dato TIMESTAMP (Fecha auto-generada)

---------
### Tablas de la entidad Categoría:


IdCategoria: Clave primaria, número de identificación de la categoría de un producto determinado. Tipo de dato int (número entero) 

Categoria: Nombre de la categoría en sí (en cuanto a en qué tipo de show se realiza, pudiendo ser callejera, de salón, de cerca o en escenarios de teatros). Tipo de dato varchar (alfanumérico)

---------
### Tablas de la entidad Puesto:

IdPuesto: Clave primaria, identificación del puesto dentro de la tienda. Tipo de dato int (número entero) 

Puesto: Nombre del puesto. Tipo de dato VARCHAR (alfanumérico)

-----
### Tablas de la entidad Empleados:

IdEmpleado: Clave primaria, identificación del empleado. Tipo de dato int (número entero) 

NomApe: Nombre y apellido del empleado de la tienda. Tipo de dato varchar (alfanumérico)

IdPuesto: Clave foránea, identificación conectada con la tabla Puesto. Tipo de dato int (número entero)

FechaNac: Fecha de nacimiento del empleado. Tipo de dato DATE (fecha)

Localidad: Localidad de residencia actual del empleado. Tipo de dato varchar (alfanumérico)

---------
### Tablas de la entidad proveedor:

IdProv: Clave primaria, número de identificación del proveedor de la tienda. Tipo de dato INT (entero).

Nombre: Nombre del proveedor o empresa proveedora. Tipo de dato VARCHAR (alfanumérico).

Tipo: Categoría o tipo de proveedor (qué clase de material provee). Tipo de dato VARCHAR (alfanumérico).

Dirección: Dirección del local/tienda proveedora. Tipo de dato VARCHAR (alfanumérico).

Localidad: Localidad de residencia de la tienda proveedora. Tipo de dato VARCHAR (alfanumérico).

País: País de residencia de la tienda proveedora. Tipo de dato VARCHAR (alfanumérico)

---------
### Tablas de la entidad puntosVenta:

IdPunto: Clave primaria, número de identificación del punto de venta. Tipo de dato INT (entero).

Nombre: Nombre de la tienda externa o punto de venta. Tipo de dato VARCHAR (alfanumérico).

Dirección: Dirección de la tienda externa o punto de venta. Tipo de dato VARCHAR (alfanumérico).

Localidad: Localidad de residencia del punto de venta. Tipo de dato VARCHAR (alfanumérico).

País: País de residencia del país en el cual se encuentra el punto. Tipo de dato VARCHAR (alfanumérico)

---------
### Tablas de la entidad vendedorAutorizado:

IdVendedor: Clave primaria, número de identificación del vendedor. Tipo de dato INT (entero).

Nombre: Nombre del vendedor autorizado. Tipo de dato VARCHAR (alfanumérico).

Nacionalidad: Nacionalidad o país de residencia donde opera el vendedor autorizado. Tipo de dato VARCHAR (alfanumérico).

IdPunto: Clave foránea, número de identificación del punto de venta (tabla PuntosVenta). Tipo de dato INT (entero).

---------
### Tablas de la entidad log_movimientos_cliente (encargada de registrar movimientos mediante un Trigger de la tabla Clientes):

Id_Movimiento: Clave primaria, número identificación del movimiento. Tipo de dato Int (número entero)

Fecha: Fecha de realización del movimiento. Tipo de dato DATETIME (fecha y hora)

Usuario_Id: Identificación y nombre del usuario que realiza movimientos. Tipo de dato VARCHAR (alfanumérico)

IdCliente: De la tabla Cliente, número de identificación. Tipo de dato INT (entero)

Nombre: De la tabla Cliente, nombre del mismo. Tipo de dato VARCHAR (alfanumérico)

Contacto: De la tabla Cliente, contacto del mismo. Tipo de dato VARCHAR (alfanumérico)

Tipo_Movimiento: Tipo de movimiento (si es Insert, Update o Delete) realizado por el usuario en nuestra base de datos. Tipo de dato VARCHAR (alfanumérico)

---------
### Tablas de la entidad log_movimientos_producto (encargada de registrar movimientos en la tabla Producto):

IdMovimiento: Clave primaria, número de identificación del movimiento. Tipo de dato INT (entero)

Fecha: Fecha de realización del movimiento. Tipo de dato DATETIME (fecha y hora)

UsuarioId: Identificación y nombre del usuario que realiza movimientos. Tipo de dato VARCHAR (alfanumérico)

IdProducto: De la tabla Producto, número de identificación. Tipo de dato INT (entero)

Nombre: De la tabla Producto, nombre del mismo. Tipo de dato VARCHAR (alfanumérico)

Precio: Precio del producto, tipo de dato FLOAT (decimal)

TipoMovimiento: Tipo de movimiento (si es Insert, Update o Delete) realizado por el usuario en nuestra base de datos. Tipo de dato VARCHAR (alfanumérico)

---------
### Vistas: 

Vista clientes_arg: Vista creada para sólo mostrar los clientes cuyo país es “Argentina” en la tabla Cliente. El objetivo es que se pueda acceder a esta vista para contactar o ver datos de clientes dentro del país. 

Vista dific_facil: Vista creada para sólo mostrar los productos de dificultad “fácil” en la tabla Productos. El objetivo de esta vista es filtrar los productos de fácil performance para saber cuáles vender y/o recomendar a ilusionistas amateurs. Vista producto_barato: Vista creada para sólo mostrar productos cuyo “precio” sea menor a 10 (USD). Esta podría usarse para hacer un checkeo de stock para productos baratos. 

Vista join_prod_categ: Vista hecha con la función JOIN para unir la tabla Producto con la de Categoría. El objetivo de esta view sería utilizar el join como puntero para poder ver la categoría (en cuanto a performance en vivo) dentro de la tabla producto. Vista clientes_pedidos: Vista hecha con la función JOIN para unir la tabla Pedido con la de Cliente. (muestra el idPedido que corresponde a cada cliente). Se utilizaría para ver a qué cliente le corresponde cada pedido.

---------
### Funciones: (Ambas utilizan la tabla Cliente) 


Cambiar_nombre_cliente: Función creada para dar dos parámetros (idCliente y nombre), permite modificar el nombre de un cliente en su registro. Al darse ámbos parámetros, modifica el registro sin la necesidad de utilizar la sentencia Update Table ni nada por el estilo. 

Contar_pais: Función creada con el propósito de contar cuantos registros hay con el país que se especifique en el único parámetro. Esta función nos facilita hacer estadísticas y es útil para saber cantidad de clientes en un país determinado.

---------
### Stored Procedures: 

sp_ordenar_cliente: Interactúa con la tabla cliente, este procedimiento pide dos parámetros IN de los cuales el primero sería el Campo o columna a ordenar y el segundo el orden en sí (si es ascendente o descendente). Facilita el orden de registros si queremos hacerlo por orden alfabético o a la inversa. 

sp_agregar_empleado: Se utiliza directamente e interactúa con la tabla empleados; nos permite insertar un registro en dicha tabla sin la necesidad de los INSERT INTO / VALUES. Muy útil si se desconoce MYSQL.

---------
### Triggers:

País_restricción: Trigger que se ejecuta específicamente cuando un usuario intenta insertar un registro en la tabla Cliente cuyo país sea ‘Rusia’. Se activa antes (Before) de insertar dicho registro.

Movimientos_cliente: Trigger que copia registros y muestra la fecha de inserción, cambio o borrado de los registros en la tabla Cliente como también así el usuario que realizó dichos movimientos. Se activa después (After) de la realización.

Movimientos_producto: Trigger que copia registros y muestra la fecha de inserción, cambio o borrado de los registros en la tabla Producto como también así el usuario que realizó dichos movimientos. Se activa después (After) de la realización.

Modificar_producto_restricción: Trigger que directamente se activa cuando se intenta modificar algo de la tabla Productos. Muestra un mensaje de error, no permitiendo a los usuarios modificar nada de dicha tabla. Se activa antes (Before) de modificar algún registro.





