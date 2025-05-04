## 🔙 [Volver al inicio del repositorio](../)

---

# 🗃️ Semana 6

---

En esta semana se trabajó la creación y configuración de una **base de datos en MySQL** utilizando **Docker** como entorno de ejecución. No se desarrollaron clases Java ni diagramas UML, sino que el enfoque fue exclusivamente la automatización del entorno de base de datos.

### 📂 Estructura de archivos

- `init.sql`: Script SQL que define la base de datos `CarnetDB` y su tabla principal `Carnets`.
- `docker-compose.yml`: Archivo de configuración para levantar un contenedor con MySQL y ejecutar automáticamente el script `init.sql`.
- `sql/`: Carpeta donde se encuentra el archivo SQL que se monta al contenedor.

---

### 🧱 Descripción del sistema

- Se crea la base de datos `CarnetDB` al iniciar el contenedor.
- Se define la tabla `Carnets` con los siguientes campos:
  - `codigo` (clave primaria)
  - `dni`, `apellidos`, `nombres`, `facultad`, `carrera`, `fecha_expiracion`
  - `foto` (almacenada como `LONGBLOB`)

---

### 🐳 Docker

El contenedor de MySQL se configura para:

- Exponerse en el puerto `3306`
- Usar la imagen oficial `mysql:8.0`
- Crear automáticamente la base de datos `CarnetDB`
- Ejecutar el script `init.sql` ubicado en `sql/` al arrancar
- Establecer las credenciales:
  - Usuario: `root`
  - Contraseña: `root123`

---

### ▶️ ¿Cómo ejecutar?

1. Asegúrate de tener **Docker** instalado.
2. Abre una terminal en la carpeta `SEMANA 6`.
3. Ejecuta:

```bash
docker-compose up -d