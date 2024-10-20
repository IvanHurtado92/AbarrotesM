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
    -- Aquí puedes agregar las claves foráneas si son necesarias
    UNIQUE (RFC),
    UNIQUE (Correo) -- Suponiendo que RFC y Correo deben ser únicos
);

insert into cliente values(null, 'Ivan', 'Hurtado', 'Lozano', '2002-09-20', 'dasd2432', 'ivan.hurtado92@outlook.com','hola');

select * from cliente;

drop table cliente;