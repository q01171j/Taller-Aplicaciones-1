## 📄 Interface: IUsuarios

> 📁 Ubicación: `interfaces/IUsuarios.java`

---

### 🧩 Descripción

Esta interfaz define los métodos específicos para gestionar usuarios dentro del sistema. Es una extensión especializada del patrón CRUD para cubrir funcionalidades particulares como el login, gestión de acceso, y búsqueda avanzada.

---

### 🔍 Métodos Definidos

| Método                                      | Descripción                                              |
|--------------------------------------------|----------------------------------------------------------|
| `boolean crearUsuario(T obj)`              | Crea un nuevo usuario (o lo reactiva si estaba eliminado). |
| `boolean actualizarUsuario(T obj)`         | Actualiza los datos de un usuario existente.             |
| `boolean eliminarUsuario(String dni)`      | Realiza un borrado lógico del usuario.                   |
| `T ingresarUsuario(T obj)`                 | Valida las credenciales y retorna el usuario si es válido. |
| `List<T> buscarUsuario(String filtro)`     | Devuelve una lista de usuarios según un filtro.          |

---

### 🧾 Código Fuente

```java
package interfaces;

import java.util.List;


public interface IUsuarios<T> {
    boolean crearUsuario(T obj);
    boolean actualizarUsuario(T obj);
    boolean eliminarUsuario(String dni);
    T ingresarUsuario(T obj);
    List<T> buscarUsuario(String buscar);
}
```