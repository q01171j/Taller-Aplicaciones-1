-- Si la base de datos existe, elimínala
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'CarnetDB')
BEGIN
    DROP DATABASE CarnetDB;
END
GO

-- Crear la base de datos
CREATE DATABASE CarnetDB;
GO

-- Usar la base de datos
USE CarnetDB;
GO

-- Crear la tabla Carnet
CREATE TABLE Carnets (
    codigo NVARCHAR(50) PRIMARY KEY,
    dni NVARCHAR(20) NOT NULL,
    apellidos NVARCHAR(100) NOT NULL,
    nombres NVARCHAR(100) NOT NULL,
    facultad NVARCHAR(100) NOT NULL,
    carrera NVARCHAR(100) NOT NULL,
    fecha_expiracion DATE NOT NULL,
    foto VARBINARY(MAX)
);
GO
