## 🔙 [Volver a Semana 8](../)

---

# 🛢️ Configuración de Base de Datos con Docker y VSCode

Este apartado explica cómo configurar y ejecutar la base de datos del sistema usando **Docker**, **Docker Compose** y **VSCode**, sin necesidad de instalar manualmente MySQL ni phpMyAdmin.

---

## 🐳 ¿Qué es Docker?

**Docker** es una herramienta que permite crear, probar y desplegar aplicaciones rápidamente en entornos aislados llamados **contenedores**.

Con Docker no necesitas instalar MySQL en tu máquina. Solo necesitas un contenedor que lo tenga preconfigurado.

📌 [¿Qué es Docker? (video explicativo)](https://www.youtube.com/watch?v=pTFZFxd4hOI)

---

## 🧰 Requisitos Previos

Asegúrate de tener instaladas las siguientes herramientas:

| Aplicación     | Función                                      | Descarga                           |
|----------------|----------------------------------------------|------------------------------------|
| 🐳 Docker       | Ejecutar contenedores (MySQL, etc.)           | [Descargar Docker](https://www.docker.com/products/docker-desktop/) |
| 🖥️ VSCode       | Editor para manejar proyectos con Docker      | [Descargar VSCode](https://code.visualstudio.com/) |
| ☕ NetBeans     | IDE para ejecutar el proyecto Java (Swing)    | [Descargar NetBeans](https://netbeans.apache.org/download/index.html) |
| 🧩 MySQL Driver | Conector JDBC para tu proyecto en Java        | [Descargar JDBC](https://dev.mysql.com/downloads/connector/j/) |

---

## 📁 Estructura de Carpetas

Tu carpeta del proyecto debería tener esta estructura:

## 📁 Estructura del Proyecto Docker + SQL

```
proyecto/
├── docker-compose.yml
└── sql/
    └── init.sql (tu script con la base de datos)
```

---

## ⚙️ Configuración y Ejecución del Contenedor MySQL

A continuación, te explicamos cómo iniciar el contenedor de MySQL que cargará automáticamente tu base de datos desde el script `init.sql`.

### 📝 1. Verifica tu archivo `docker-compose.yml`

Tu archivo `docker-compose.yml` debe estar en la raíz de tu proyecto y lucir así:

```yaml
version: "3.8"

services:
  mysql:
    image: mysql:8.0
    container_name: mysql_container
    restart: "no"
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: CarnetDB
    ports:
      - "3306:3306"
    volumes:
      - ./sql:/docker-entrypoint-initdb.d
    tmpfs:
      - /var/lib/mysql
```

> 📌 Asegúrate de que el archivo `init.sql` esté dentro de la carpeta `sql/` en la misma ruta que este `docker-compose.yml`.

---

### 🧪 2. Ejecutar el contenedor

Abre una terminal en VSCode en la raíz del proyecto y ejecuta:

```bash
docker-compose up
```

Esto hará lo siguiente:

- Levanta un contenedor con MySQL 8.0.
- Crea la base de datos `CarnetDB`.
- Ejecuta automáticamente el script `init.sql`.

---

### ✅ 3. Verificar conexión

Una vez levantado el contenedor, puedes conectar NetBeans con la base de datos usando el siguiente host:

- **Host**: `localhost`
- **Puerto**: `3306`
- **Usuario**: `root`
- **Contraseña**: `root123`
- **Base de Datos**: `CarnetDB`

Puedes probar la conexión desde NetBeans o cualquier cliente como DBeaver, DataGrip, o MySQL Workbench.

---

---

## 🗃️ Script SQL de Base de Datos (`init.sql`)

Este archivo es ejecutado automáticamente por Docker al iniciar el contenedor. Crea la base de datos `CarnetDB` y todas sus tablas, además de insertar un usuario administrador para acceder al sistema.

### 📄 Contenido de `sql/init.sql`

```sql
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

-- Usuario administrador inicial
INSERT INTO usuarios (dni, nombre, contrasena, rol, acceso, eseliminado)
VALUES ('12345678', 'Admin', 'admin123', 'Administrador', true, false);

-- Facultades de ejemplo
INSERT INTO facultad (codigo, nombre) VALUES
('FIIS', 'Facultad de Ingeniería'),
('FCS', 'Facultad de Ciencias de la Salud');

-- Escuelas profesionales de ejemplo
INSERT INTO escuela_profesional (codigo, nombre, facultad_codigo) VALUES
('SIS', 'Ingeniería de Sistemas', 'FIIS'),
('IND', 'Ingeniería Industrial', 'FIIS'),
('MED', 'Medicina Humana', 'FCS');

-- Estudiantes de ejemplo (sin imagen por defecto)
INSERT INTO estudiantes (dni, codigo, nombres, apellidos, foto, escuela_codigo) VALUES
('98765432', 'SIS001', 'Carlos', 'Pérez', NULL, 'SIS'),
('87654321', 'IND002', 'Lucía', 'García', NULL, 'IND');

-- Carnets de ejemplo
INSERT INTO carnet (dni_estudiante, fecha_expiracion) VALUES
('98765432', '2025-12-31'),
('87654321', '2025-06-30');
```

---

Con este script puedes levantar y poblar toda la base de datos sin hacer configuraciones adicionales manualmente.

