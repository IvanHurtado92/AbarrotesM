SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE database IF NOT EXISTS abarrotes DEFAULT CHARACTER SET utf8 ;
USE abarrotes ;


CREATE TABLE if not exists cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(250),
    Apell_pat VARCHAR(250),
    Apell_mat VARCHAR(250),
    Fecha_nac VARCHAR(250),
    RFC VARCHAR(100),
    Correo VARCHAR(150),
    Password VARCHAR(100),
    Direccion VARCHAR(100),
    Telefono VARCHAR(100),
    Carrito INT

    -- Aquí puedes agregar las claves foráneas si son necesarias
    -- UNIQUE (RFC),
    -- UNIQUE (Correo) -- Suponiendo que RFC y Correo deben ser únicos
);

DELIMITER //

CREATE TRIGGER set_carrito_value
    BEFORE INSERT ON cliente
    FOR EACH ROW
BEGIN
    SET NEW.Carrito = NEW.id_cliente;
END; //

CREATE TRIGGER update_carrito_value
    BEFORE UPDATE ON cliente
    FOR EACH ROW
BEGIN
    SET NEW.Carrito = NEW.id_cliente;
END; //

DELIMITER ;


insert into cliente values(null, 'Ivan', 'Hurtado', 'Lozano', '2002-09-20', 'dasd2432', 'ivan.hurtado92@outlook.com','hola', 'Olivares 505', '0123456789');
insert into cliente values(null, 'Mau', 'de Hurtado', '', '2002-09-20', 'dasd2432', 'mauivanoutlook.com','hola', 'tenayuca 92', 1023456789);

insert into proveedor values(null, 'Miguel', 'Archuleta', 'Lopez', 'Flex');
insert into proveedor values(null, 'Raul', 'Ramirez', 'Jerez', 'Predio Ramirez');

insert into producto values(null, 'SlapChop', '.','.','.',500.2,200.3,1004,'.34','Miguelito',1);
insert into producto values(null, 'manzana', '.','.','.',30.2,40.3,100,'No se que va aqui','Pedrito',2);
insert into producto values(null, 'manzana verde', '.','.','.',30.2,40.3,100,'No se que va aqui','Pedrito',2);

insert into pedido values(1, '30 de febrero', 'Ta bien', 'Bueno', 1);

insert into paquete values(1, 2, 1, 1, 1);

insert into estado values(null, 'bueno');
insert into estado values(null, 'malo');
insert into estado values(null, 'perfecto');

insert into inventario values(1, '21/10/2024', 4000, 3000, 2000, 4000.5, 3000.5, 2000.5, 1000.5, 300, 2, 1);
insert into inventario values(2, '25/10/2024', 4000, 3000, 2000, 4000.5, 3000.5, 2000.5, 1000.5, 250, 1, 1);


insert into empresa values(null, 'Flex', 'Productos industriales Flex', 'Manufactura');
insert into empresa values(null, 'Amazon', 'Amazon software and services', 'Desarrolo de SW');

insert into empleado values(null, 'Mau','adios', 'Rivera', 'Gonzalez', '33 de diciembre', 'sadsa23e23ad23', 10000, 'soltero', 'activo', 'Ingenieria','Empleado');
insert into empleado values(null, 'Leo','adios', 'Cruz', 'Oritz', '33 de diciembre', 'sadsa23e23ad23', 10000, 'casado', 'activo', 'Ingenieria','Empleado');
insert into empleado values(null, 'Ivan','adios', 'Hurtado', 'Lozano', '20 de septiembre', 'hurpro123', 10000, 'soltero', 'activo', 'Ingenieria','Empleado');
insert into empleado values(null, 'Pedro','hola', 'Rodriguez', 'Castro', '33 de diciembre', 'sadsa23e23adf', 10000, 'viudo', 'activo', 'prepa','Administrador');
insert into empleado values(null, 'Juan','adios', 'Rodriguez', 'Castro', '33 de diciembre', 'sadsa23e23ad23', 10000, 'viudo', 'activo', 'prepa','Empleado');
insert into empleado values(null, 'admin','caca', '', '', '', 'sadsa23e23ad21', 10000000, 'mujeriego', 'activo', 'Doctorado','Administrador');

select * from cliente;
select * from proveedor;
select * from producto;
select * from pedido;
select * from paquete;
select * from empleado;
select * from proveedor;
select * from producto;
select * from pedido;
select * from paquete;
select * from empleado;

delete from empleado where(nivel_estudio = 'Sin estudios');

drop database abarrotes;

set foreign_key_checks = 0;
drop table cliente;
set foreign_key_checks = 1;