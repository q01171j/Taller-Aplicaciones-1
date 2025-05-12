## 📄 Interface: ICrud

> 📁 Ubicación: `interfaces/ICrud.java`

---

### 🧩 Descripción

Interfaz genérica que define las operaciones básicas CRUD (Crear, Leer, Actualizar y Eliminar) para cualquier tipo de entidad. Es utilizada como base para la mayoría de los DAO del sistema.

---

### 🔍 Métodos Definidos

| Método                          | Descripción                                          |
| ------------------------------- | ---------------------------------------------------- |
| `boolean crear(T obj)`          | Crea un nuevo registro en la base de datos.          |
| `boolean actualizar(T obj)`     | Actualiza un registro existente.                     |
| `boolean eliminar(String id)`   | Realiza un borrado lógico del registro.              |
| `List<T> buscar(String filtro)` | Busca registros que coincidan con un filtro textual. |

---

### 🧾 Código Fuente

```java
package interfaces;

import java.util.List;

public interface ICrud<T> {

    boolean crear(T obj);

    boolean actualizar(T obj);

    boolean eliminar(String id); // Por clave primaria (como dni o código)

    List<T> buscar(String filtro);
}

```
