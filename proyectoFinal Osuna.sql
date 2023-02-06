CREATE DATABASE magiashop;
USE magiashop;

-- TABLAS

CREATE TABLE CLIENTE(
IdCliente INT NOT NULL AUTO_INCREMENT, 
Nombre VARCHAR(15),
CodPostal INT NOT NULL,
Direccion VARCHAR(30) NOT NULL,
Pais VARCHAR(15) NOT NULL,
Contacto VARCHAR(30) NOT NULL,
PRIMARY KEY (IdCliente)
);

CREATE TABLE Categoria(
IdCategoria INT NOT NULL AUTO_INCREMENT,
Categoria VARCHAR(20) NOT NULL,
PRIMARY KEY (IdCategoria)
);


CREATE TABLE PRODUCTO(
IdProducto INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR(15) NOT NULL,
IdCategoria INT NOT NULL,
Precio FLOAT NOT NULL,
Audiencia VARCHAR(10),
Stock INT NOT NULL,
Dificultad VARCHAR(10),
PRIMARY KEY(IdProducto),
FOREIGN KEY (IdCategoria) REFERENCES Categoria (IdCategoria)
);



CREATE TABLE PEDIDO(
IdPedido INT NOT NULL AUTO_INCREMENT,
Valor FLOAT NOT NULL,
Peso FLOAT NOT NULL,
Cantidad INT NOT NULL,
IdCliente INT NOT NULL,
IdProducto INT NOT NULL,
PRIMARY KEY (IdPedido),
FOREIGN KEY (IdCliente) REFERENCES CLIENTE(IdCliente),
FOREIGN KEY (IdProducto) REFERENCES PRODUCTO(IdProducto)
);

CREATE TABLE ProductosPedidos(
IdProdPed INT NOT NULL AUTO_INCREMENT,
IdPedido INT NOT NULL,
IdProducto INT NOT NULL,
FOREIGN KEY(IdProducto) REFERENCES Producto (IdProducto),
FOREIGN KEY (IdPedido) REFERENCES PEDIDO (IdPedido)
);

CREATE TABLE Puesto(
IdPuesto INT NOT NULL AUTO_INCREMENT,
Puesto VARCHAR(20) NOT NULL,
PRIMARY KEY (IdPuesto)
);

CREATE TABLE Empleados(
IdEmpleado INT NOT NULL AUTO_INCREMENT,
NomApe VARCHAR(20) NOT NULL,
IdPuesto INT NOT NULL,
FechaNac DATETIME NOT NULL,
Localidad VARCHAR(15),
PRIMARY KEY (IdEmpleado),
FOREIGN KEY(IdPuesto) REFERENCES Puesto (IdPuesto)
);


CREATE TABLE proveedor(
IdProv INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR (20) NOT NULL,
Tipo VARCHAR(20) NOT NULL,
Direccion VARCHAR(30) NOT NULL,
Localidad VARCHAR(30) NOT NULL,
Pais VARCHAR (20) NOT NULL,
PRIMARY KEY (IdProv)
);

CREATE TABLE puntosVenta(
IdPunto INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR (50),
Direccion VARCHAR(50) NOT NULL,
Localidad VARCHAR (50),
Pais VARCHAR (20) NOT NULL,
PRIMARY KEY (IdPunto)
);

CREATE TABLE vendedorAutorizado(
IdVendedor INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR (50) NOT NULL,
Nacionalidad VARCHAR (30) NOT NULL,
IdPunto INT,
PRIMARY KEY (IdVendedor),
FOREIGN KEY (IdPunto) REFERENCES puntosVenta (IdPunto)
);

-- REGISTROS/INSERTS

INSERT INTO Categoria(Categoria)
VALUES ('Salón'), 
       ('Callejera'), 
	   ('Cerca'),
       ('Escenario');

INSERT INTO CLIENTE
VALUES (1, 'Murphys Magic', 1301, '1234 Mp Street', 'USA', 'mmagic@gmail.com'), 
	   (2, 'Juan Tamariz', 2023, 'Av Sevilla 2312', 'España', 'jtmago@yahoo.com'),
       (3, 'Henry Evans', 1882, 'Av Córdoba 321', 'Argentina', 'evanshenry@gmail.com'),
       (NULL, 'Carlos Nisman', 1232, 'Perón 442', 'Argentina', 'nismattz@gmail.com'),
       (NULL, 'As de trébol', 9012, 'Milan 5521', 'Colombia', 'astrebol@gmail.com');
       

INSERT INTO PRODUCTO
VALUES (1, 'Revolution', 3, 49.99, 'General', 5, 'Intermedia'),
	   (2, 'Cinemagic Flash', 1, 9.99, 'Adultos', 2, 'Fácil'),
       (3, 'Origami Can', 3, 2.50, 'Niños', 1, 'Difícil'),
       (NULL, 'That F Card', 2, 14.99, 'Adultos', 2, 'Fácil');
       
INSERT INTO PEDIDO
VALUES (NULL, 150.00, 4 , 3, 1, 1),
	   (NULL, 5, 2, 2, 3, 3);
       
INSERT INTO puesto
VALUES (NULL, 'Jefe'),
	   (NULL, 'Traductor'),
       (NULL, 'Productor');

INSERT INTO EMPLEADOS
VALUES (NULL, 'Daniel Flash', 1, '1990-3-3', 'Avellaneda'),
	   (NULL, 'Marcos Cruz', 2, '1986-5-10', 'Berazategui'),
       (NULL, 'Luciano Miserak', 3, '1999-4-3', 'Quilmes');
       
INSERT INTO proveedor
VALUES (NULL, 'Multigráfica', 'Papelera', 'Alem 23 ', 'Quilmes', 'Argentina'),
	   (NULL, 'Diseñart', 'Diseño Gráfico', 'Rivadavia 982', 'La Plata', 'Argentina'),
       (NULL, 'Espaper', 'Papelera', 'Colón 776', 'Madrid', 'España');        
       
INSERT INTO puntosVenta
VALUES (NULL, 'Bazar de Magia', 'Av J. Roca 1032', 'Capital Federal', 'Argentina'),
	   (NULL, 'RL Magic', '321 North Gardens', 'Miami', 'USA');
       
INSERT INTO vendedorAutorizado
VALUES (NULL, 'Richard Lens', 'Argentino',2);

-- VISTAS
      
CREATE VIEW Clientes_Arg
AS
SELECT * FROM cliente
WHERE Pais = 'Argentina';

CREATE VIEW dific_facil
AS
SELECT * FROM Producto
WHERE Dificultad = 'facil';

CREATE VIEW producto_barato
AS
SELECT * FROM Producto
WHERE Precio <= 10;

CREATE VIEW join_prod_categ 
AS
SELECT 	P.IdProducto, 
	    P.Nombre,
        C.Categoria,
        P.Precio, 
		P.Audiencia, 
		P.Stock,
		P.Dificultad 
FROM 	Producto P
INNER JOIN Categoria C ON C.IdCategoria = P.IdCategoria;

CREATE VIEW clientes_pedidos
AS
SELECT C.Nombre,
	   C.CodPostal, 
       C.Direccion, 
       C.Pais,
       P.IdPedido
       
FROM   Cliente C
INNER JOIN Pedido P ON C.IdCliente = P.IdCliente;


-- STORED PROCEDURES

DROP PROCEDURE IF EXISTS sp_ordenar_cliente;
USE magiaShop
DELIMITER //
CREATE PROCEDURE sp_ordenar_cliente(IN campo VARCHAR(30), IN orden VARCHAR(4))
BEGIN
	IF campo <> '' THEN
		SET @ordenar = CONCAT('ORDER BY ', campo);
	ELSE
		SET @ordenar = '';
	END IF;
    
    IF orden <> '' THEN
		SET @criterio = orden;
	ELSE
		SET @criterio = '';
	END IF;
    
	SET @clausula = CONCAT('SELECT * FROM cliente ', @ordenar,' ', @criterio, ';');
    
	PREPARE ejecutarSQL from @clausula;
    EXECUTE ejecutarSQL;
    DEALLOCATE PREPARE ejecutarSQL;
    


END //


DROP PROCEDURE IF EXISTS sp_agregar_empleado;
USE magiaShop
DELIMITER //
CREATE PROCEDURE  sp_agregar_empleado(id INT, nombre VARCHAR(20), posicion VARCHAR(15),
fechaNacim DATE, loc VARCHAR(15))
BEGIN
	
    INSERT INTO empleados (idEmpleado, NomApe, Puesto, FechaNac, Localidad)
	VALUES (id, nombre, posicion, fechaNacim, loc);
    
END //

-- TRIGGERS/LOGS

CREATE TABLE log_movimientos_cliente (
id_movimiento INT NOT NULL AUTO_INCREMENT,
fecha DATETIME NOT NULL,
usuario_id VARCHAR(30) NULL,
idCliente INT NULL,
nombre VARCHAR(15) NOT NULL,
contacto VARCHAR(30) NOT NULL,
tipo_movimiento VARCHAR(100) NULL,
PRIMARY KEY (id_movimiento)
);

DROP TRIGGER IF EXISTS movimientos_cliente;
CREATE TRIGGER movimientos_cliente
AFTER INSERT ON cliente
FOR EACH ROW
INSERT INTO log_movimientos_cliente
(id_movimiento, fecha, usuario_id, idCliente, nombre, contacto, tipo_movimiento)
VALUES 
(NULL, NOW(), SESSION_USER(), NEW.idCliente, NEW.nombre, NEW.contacto, 'INSERT: Se insertó registro.');


DELIMITER $$
DROP TRIGGER IF EXISTS pais_restriccion;
CREATE TRIGGER pais_restriccion
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(200);
    IF (NEW.pais = 'Rusia') THEN
		SET msg = 'Imposible, no trabajamos con este país';
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	
	END IF;


END$$


CREATE TABLE log_movimientos_producto(
idMovimiento INT NOT NULL AUTO_INCREMENT,
fecha DATETIME NOT NULL,
usuario_id VARCHAR(30) NULL,
idProducto INT NULL,
nombre VARCHAR(30) NOT NULL,
precio FLOAT NOT NULL,
tipoMovimiento VARCHAR (100) NULL,
PRIMARY KEY (idMovimiento)
);

DROP TRIGGER IF EXISTS movimientos_producto;
CREATE TRIGGER movimientos_producto
AFTER INSERT ON producto
FOR EACH ROW
INSERT INTO log_movimientos_producto
(idMovimiento, fecha, usuario_id, idProducto, nombre, precio, tipo_movimiento)
VALUES 
(NULL, NOW(), SESSION_USER(), NEW.idProducto, NEW.nombre, NEW.precio, 'INSERT: registro insertado correctamente');


DELIMITER $$
DROP TRIGGER IF EXISTS modificar_producto_restriccion;
CREATE TRIGGER modificar_producto_restriccion
BEFORE UPDATE ON producto
FOR EACH ROW
BEGIN

	DECLARE msg VARCHAR(200);
    
	SET msg = 'Error: No está habilitado editar registros';
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
	
END$$

 
-- USUARIOS 

SELECT * FROM mysql.user;

-- CREACIÓN DE USUARIOS
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'contraseña1'; 
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY 'contraseña2'; 

-- SE LE DA PERMISO SÓLO DE LECTURA A LAS TABLAS DE LA BBDD AL PRIMER USUARIO
GRANT SELECT ON magiaShop.* TO 'usuario1'@'localhost';

-- SE LE DA PERMISO DE LECTURA, INSERCIÓN, BORRADO Y MODIFICACIÓN AL SEGUNDO USUARIO
GRANT SELECT, INSERT, UPDATE ON magiaShop.* TO 'usuario2'@'localhost';

-- SE LE QUITA EL PERMISO DE BORRADO AL SEGUNDO USUARIO
REVOKE DELETE ON *.* FROM 'usuario2'@'localhost';


-- TCL/TRANSACTIONS

-- PRIMERA TRANSACCIÓN
START TRANSACTION;
SET autocommit = OFF;

DELETE FROM cliente
WHERE pais = 'Colombia'; 

ROLLBACK;

COMMIT;

-- SEGUNDA TRANSACCIÓN
START TRANSACTION;
SET autocommit = OFF;

INSERT INTO producto
VALUES (NULL, 'Bermuda', 1, 30.00, 'Adultos', 30, 'Fácil'),
	   (NULL, 'Surprise', 3, 50.00, 'Adultos', 10, 'Fácil'),
	   (NULL, 'Supercan', 3, 99.99, 'Todos', 4, 'Difícil'),
	   (NULL, 'Dresscode', 2, 80.00, 'Todos', 6, 'Intermedia');

SAVEPOINT registrosPrimarios;

INSERT INTO producto
VALUES	(NULL, 'Mouse Trap', 1 , 55.00, 'Niños', 60, 'Fácil'),
		(NULL, '3 Card Monte', 2, 4.50, 'Todos', 7, 'Intermedia'),
        (NULL, 'Wild Card', 3, 60.00, 'Adultos', 10, 'Difícil'),
        (NULL, 'Safe Lock', 3, 120.00 , 'Adultos', 5, 'Intermedia');
        
SAVEPOINT registrosSecundarios;

ROLLBACK TO registrosPrimarios;

COMMIT;

-- RELEASE SAVEPOINT registrosPrimarios;






