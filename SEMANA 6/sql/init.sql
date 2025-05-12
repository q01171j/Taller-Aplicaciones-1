-- Crear base de datos
CREATE DATABASE IF NOT EXISTS CarnetDB;
USE CarnetDB;

-- Eliminar tablas si existen (orden correcto por claves foráneas)
DROP TABLE IF EXISTS carnet;
DROP TABLE IF EXISTS estudiantes;
DROP TABLE IF EXISTS escuela_profesional;
DROP TABLE IF EXISTS facultad;
DROP TABLE IF EXISTS usuarios;

-- Tabla de facultades
CREATE TABLE facultad (
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    eseliminado BOOLEAN DEFAULT FALSE
);

-- Tabla de escuelas profesionales
CREATE TABLE escuela_profesional (
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    facultad_codigo VARCHAR(10) NOT NULL,
    eseliminado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (facultad_codigo) REFERENCES facultad(codigo)
);

-- Tabla de estudiantes
CREATE TABLE estudiantes (
    dni VARCHAR(20) PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    foto LONGBLOB,
    escuela_codigo VARCHAR(10) NOT NULL,
    eseliminado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (escuela_codigo) REFERENCES escuela_profesional(codigo)
);

-- Tabla de carnets
CREATE TABLE carnet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dni_estudiante VARCHAR(20) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    eseliminado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (dni_estudiante) REFERENCES estudiantes(dni)
);

-- Tabla de usuarios
CREATE TABLE usuarios (
    dni VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    rol VARCHAR(20) NOT NULL, -- valores esperados: 'Administrador' o 'Normal'
    acceso BOOLEAN DEFAULT TRUE,
    eseliminado BOOLEAN DEFAULT FALSE
);

INSERT INTO usuarios (dni, nombre, contrasena, rol, acceso, eseliminado)
VALUES ('12345678', 'Admin', 'admin123', 'Administrador', true, false);
