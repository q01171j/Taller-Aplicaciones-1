## 📄 Interface: IControladorMenu

> 📁 Ubicación: `interfaces/IControladorMenu.java`

---

### 🧩 Descripción

Esta interfaz define los métodos de control del módulo principal de la aplicación, permitiendo manejar las acciones relacionadas con el mantenimiento de usuarios desde la vista `GuiMenu`.

---

### 🔍 Métodos Definidos

| Método                      | Descripción                                                   |
| --------------------------- | ------------------------------------------------------------- |
| `void inicializar()`        | Inicializa la interfaz desactivando campos y botones.         |
| `void buscarUsuarios()`     | Busca usuarios en base a un filtro ingresado.                 |
| `void seleccionarUsuario()` | Carga los datos del usuario seleccionado en la tabla.         |
| `void crearUsuario()`       | Prepara la interfaz para el ingreso de un nuevo usuario.      |
| `void actualizarUsuario()`  | Permite editar los datos de un usuario seleccionado.          |
| `void guardarUsuario()`     | Guarda un usuario nuevo o actualizado según el modo actual.   |
| `void cancelarUsuario()`    | Cancela la acción actual y vuelve al estado de visualización. |
| `void eliminarUsuario()`    | Realiza el borrado lógico del usuario seleccionado.           |

---

### 🧾 Código Fuente

```java
package interfaces;

public interface IControladorMenu {

    void inicializar();

    void buscarUsuarios();

    void seleccionarUsuario();

    void crearUsuario();

    void actualizarUsuario();

    void guardarUsuario();

    void cancelarUsuario();

    void eliminarUsuario();
}
```
