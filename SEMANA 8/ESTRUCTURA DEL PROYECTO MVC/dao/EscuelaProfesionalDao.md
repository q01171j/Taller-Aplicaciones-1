## 🗂️ Clase: EscuelaProfesionalDao

> 📁 Ubicación: `modelo.dao/EscuelaProfesionalDao.java`

---

### 🧩 Descripción

Esta clase es responsable de gestionar las operaciones CRUD de las **escuelas profesionales**. Interactúa con la tabla `escuela_profesional` y se relaciona con la entidad `FacultadDto`.

Extiende la clase `Conexion` para obtener acceso a la base de datos y utiliza la interfaz `ICrud<EscuelaProfesionalDto>` para estandarizar las operaciones básicas.

---

### 📌 Funcionalidad

| Método                                  | Descripción                                                                  |
| --------------------------------------- | ---------------------------------------------------------------------------- |
| `crear(EscuelaProfesionalDto obj)`      | Inserta una nueva escuela con su código, nombre y facultad relacionada.      |
| `actualizar(EscuelaProfesionalDto obj)` | Modifica el nombre o la facultad de una escuela existente.                   |
| `eliminar(String codigo)`               | Realiza un borrado lógico (`eseliminado = true`) de la escuela.              |
| `buscar(String filtro)`                 | Busca escuelas filtrando por código o nombre. Incluye los datos de facultad. |

---

### 🧬 Relaciones con otras entidades

Durante la búsqueda, esta clase también arma el objeto `FacultadDto` relacionado con cada `EscuelaProfesionalDto`.

---

### 🧾 Código Fuente (parcial)

```java
public class EscuelaProfesionalDao extends Conexion implements ICrud<EscuelaProfesionalDto> {

    @Override
    public boolean crear(EscuelaProfesionalDto obj) {
        // ...
    }

    @Override
    public boolean actualizar(EscuelaProfesionalDto obj) {
        // ...
    }

    @Override
    public boolean eliminar(String codigo) {
        // ...
    }

    @Override
    public List<EscuelaProfesionalDto> buscar(String filtro) {
        // ...
    }

    private void cerrarTodo() {
        // ...
    }
}
```
