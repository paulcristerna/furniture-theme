-- Creación de la base de datos.

CREATE DATABASE tienda_muebles;

USE tienda_muebles;

-- Creación de la tabla de usuarios.

CREATE TABLE usuarios (
    id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Clave primaria.
    nombre VARCHAR(25) NOT NULL, -- Nombre del usuario.
    apellidoPaterno VARCHAR(25) NOT NULL, -- Apellido paterno del usuario.
    apellidoMaterno VARCHAR(25) NOT NULL, -- Apellido materno del usuario.
    direccion VARCHAR(250) NOT NULL, -- Nombre del proyecto del usuario.
    rfc VARCHAR(15) NOT NULL, -- Nombre del proyecto del usuario.
    email VARCHAR(50) NOT NULL, -- Email del usuario.
    password VARCHAR(25) NOT NULL -- Contraseña del usuario.
)  ENGINE=INNODB;

-- Creación de la tabla de productos.

CREATE TABLE productos (
    id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Clave primaria.
    imagen VARCHAR(15) NOT NULL, -- Nombre del producto.
    titulo VARCHAR(50) NOT NULL, -- titulo del producto.
    marca VARCHAR(25) NOT NULL, -- marca del producto.
    precio DECIMAL(7,2) NOT NULL -- precio del producto.
)  ENGINE=INNODB;

-- Creación de la tabla de productos.

CREATE TABLE carrito (
    id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Clave primaria.
    usuario INT(11) UNSIGNED NOT NULL, -- usuario del carrito.
    producto INT(11) UNSIGNED NOT NULL, -- producto del carrito.
    cantidad DECIMAL(7,2) NOT NULL, -- cantidad carrito.
    FOREIGN KEY (usuario) -- Clave foranea que relaciona los usuarios con el carrito.
    REFERENCES usuarios(id)
    ON DELETE CASCADE,
    FOREIGN KEY (producto) -- Clave foranea que relaciona los productos con el carrito.
    REFERENCES productos(id)
    ON DELETE CASCADE
)  ENGINE=INNODB;