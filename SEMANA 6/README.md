## 🔙 [Volver al inicio del repositorio](../)

---

# 🗃️ Semana 6

---

En esta semana se trabajó la creación y configuración de una **base de datos en SQL Server** utilizando **Docker** como entorno de ejecución. No se desarrollaron clases Java ni diagramas UML, sino que se enfocó en el entorno de bases de datos y su puesta en marcha automatizada.

### 📂 Estructura de archivos

- `init.sql`: Contiene el script SQL para la creación de la base de datos `CarnetDB`, junto con su tabla principal `Carnets`.
- `docker-compose.yml`: Archivo de configuración para levantar un contenedor con SQL Server y ejecutar automáticamente el script `init.sql`.
- `sql/`: Carpeta donde se encuentra el archivo `init.sql`.

---

### 🧱 Descripción del sistema

- Se crea la base de datos `CarnetDB` si no existe (eliminándola si ya está).
- Se crea la tabla `Carnets` con los siguientes campos:
  - `codigo` (clave primaria)
  - `dni`, `apellidos`, `nombres`, `facultad`, `carrera`, `fecha_expiracion`
  - `foto` (almacenada como `VARBINARY(MAX)`)

---

### 🐳 Docker

El contenedor SQL Server se configura automáticamente para:

- Exponerse en el puerto `1433`
- Ejecutar el script `init.sql` tras la inicialización
- Utilizar la imagen oficial de Microsoft SQL Server (`2022-latest`)
- Definir credenciales con usuario `SA` y contraseña `123`

---

### ▶️ ¿Cómo ejecutar?

1. Asegúrate de tener **Docker** instalado.
2. Abre una terminal en la carpeta `SEMANA 6`.
3. Ejecuta:

```bash
docker-compose up -d
