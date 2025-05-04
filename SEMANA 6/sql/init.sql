-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS CarnetDB;

-- Crear la base de datos
CREATE DATABASE CarnetDB;

-- Usar la base de datos
USE CarnetDB;

-- Crear la tabla Carnets solo si no existe
CREATE TABLE IF NOT EXISTS Carnets (
    codigo VARCHAR(50) PRIMARY KEY,
    dni VARCHAR(20) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    facultad VARCHAR(100) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    foto LONGBLOB
);