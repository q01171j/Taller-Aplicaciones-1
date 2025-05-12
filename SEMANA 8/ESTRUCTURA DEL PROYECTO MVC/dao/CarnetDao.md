## 🗂️ Clase: CarnetDao

> 📁 Ubicación: `modelo.dao/CarnetDao.java`

---

### 🧩 Descripción

Esta clase se encarga de gestionar todas las operaciones relacionadas al **Carnet** del estudiante. Implementa la interfaz `ICrud<CarnetDto>` y extiende de `Conexion`, lo que le permite establecer conexión a la base de datos y realizar operaciones CRUD (Create, Read, Update, Delete).

---

### 📌 Funcionalidad

| Método                      | Descripción                                                           |
| --------------------------- | --------------------------------------------------------------------- |
| `crear(CarnetDto obj)`      | Inserta un nuevo registro de carnet (solo `dni`, `fecha_expiración`). |
| `actualizar(CarnetDto obj)` | Actualiza únicamente la fecha de expiración del carnet.               |
| `eliminar(String dni)`      | Realiza un borrado lógico (`eseliminado = true`) del carnet.          |
| `buscar(String filtro)`     | Retorna una lista de carnets según DNI, código, nombre o apellido.    |

---

### 🔁 Relación con otras entidades

Durante la búsqueda, esta clase también arma los objetos anidados:

- `EstudianteDto`
- `EscuelaProfesionalDto`
- `FacultadDto`

Y los utiliza para construir un `CarnetDto` completo.

---

### 🧾 Código Fuente

```java
// Solo se incluye una parte. Puedes consultar el archivo completo en:
// modelo.dao/CarnetDao.java

public class CarnetDao extends Conexion implements ICrud<CarnetDto> {

    @Override
    public boolean crear(CarnetDto obj) {
        // ...
    }

    @Override
    public boolean actualizar(CarnetDto obj) {
        // ...
    }

    @Override
    public boolean eliminar(String dniEstudiante) {
        // ...
    }

    @Override
    public List<CarnetDto> buscar(String filtro) {
        // ...
    }

    private void cerrarTodo() {
        // ...
    }
}
```
