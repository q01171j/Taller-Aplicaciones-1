## 🔙 [Volver a Semana 8](../)

---

## 📐 Estructura del Proyecto MVC

El sistema está organizado siguiendo el patrón **MVC (Modelo - Vista - Controlador)**, con sus respectivas capas implementadas mediante paquetes Java. A continuación, se detalla cada paquete y sus archivos clave, con enlaces para consultar su código fuente y descripción.

---

### 📦 Paquete `interfaz`

Contiene las interfaces que definen los contratos genéricos y específicos para el acceso a datos y control de vista.

| Archivo                      | Descripción                                      | Ver Código 📎                    |
|-----------------------------|--------------------------------------------------|----------------------------------|
| `ICrud.java`                | Interface genérica para operaciones CRUD         | [Ver Código](./interfaz/ICrud.md) |
| `IUsuarios.java`            | Interface especializada para gestión de usuarios | [Ver Código](./interfaz/IUsuarios.md) |
| `IControladorMenu.java`     | Interface que define acciones del menú principal | [Ver Código](./interfaz/IControladorMenu.md) |

---

### 📦 Paquete `modelo.dto`

Contiene las clases DTO (Data Transfer Object) que representan las entidades del sistema.

| Archivo                      | Descripción                                      | Ver Código 📎                        |
|-----------------------------|--------------------------------------------------|--------------------------------------|
| `UsuarioDto.java`           | Representa un usuario del sistema                | [Ver Código](./modelo.dto/UsuarioDto.md) |
| `FacultadDto.java`          | Representa una facultad universitaria            | [Ver Código](./modelo.dto/FacultadDto.md) |
| `EscuelaProfesionalDto.java`| Representa una escuela profesional               | [Ver Código](./modelo.dto/EscuelaProfesionalDto.md) |
| `EstudianteDto.java`        | Representa un estudiante                         | [Ver Código](./modelo.dto/EstudianteDto.md) |
| `CarnetDto.java`            | Representa el carnet de un estudiante            | [Ver Código](./modelo.dto/CarnetDto.md) |

---

### 📦 Paquete `modelo.dao`

Contiene las clases DAO responsables del acceso a la base de datos.

| Archivo                      | Descripción                                      | Ver Código 📎                         |
|-----------------------------|--------------------------------------------------|---------------------------------------|
| `UsuarioDao.java`           | CRUD específico para usuarios                    | [Ver Código](./modelo.dao/UsuarioDao.md) |
| `FacultadDao.java`          | CRUD para facultades                             | [Ver Código](./modelo.dao/FacultadDao.md) |
| `EscuelaProfesionalDao.java`| CRUD para escuelas profesionales                 | [Ver Código](./modelo.dao/EscuelaProfesionalDao.md) |
| `EstudianteDao.java`        | CRUD para estudiantes                            | [Ver Código](./modelo.dao/EstudianteDao.md) |
| `CarnetDao.java`            | CRUD para carnets                                | [Ver Código](./modelo.dao/CarnetDao.md) |
| `Conexion.java`             | Encapsula la conexión con la base de datos       | [Ver Código](./modelo.dao/Conexion.md) |

---

### 📦 Paquete `controladores`

Contiene la lógica que une la vista (GUI) con los datos (DAO/DTO).

| Archivo                      | Descripción                                      | Ver Código 📎                            |
|-----------------------------|--------------------------------------------------|------------------------------------------|
| `ControladorIngreso.java`   | Controla el proceso de inicio de sesión          | [Ver Código](./controladores/ControladorIngreso.md) |
| `ControladorMenu.java`      | Controla el panel principal y todos sus módulos  | [Ver Código](./controladores/ControladorMenu.md)    |

---

### 📦 Paquete `gui`

Contiene las interfaces gráficas creadas con Java Swing.

| Archivo                      | Descripción                                      | Ver Código 📎                      |
|-----------------------------|--------------------------------------------------|------------------------------------|
| `GuiIngreso.java`           | Ventana de inicio de sesión                      | [Ver Código](./gui/GuiIngreso.md) |
| `GuiMenu.java`              | Ventana principal que contiene los paneles       | [Ver Código](./gui/GuiMenu.md)    |

---

🔗 Cada enlace lleva a un archivo `README.md` con la descripción y código del archivo correspondiente.

¿Quieres que te genere ahora uno de esos archivos `README.md` individuales de ejemplo?
