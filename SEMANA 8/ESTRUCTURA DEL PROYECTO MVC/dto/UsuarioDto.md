## 👤 DTO: UsuarioDto

> 📁 Ubicación: `modelo.dto/UsuarioDto.java`

---

### 🧩 Descripción

La clase `UsuarioDto` representa a los usuarios del sistema (administradores o usuarios normales). Incluye datos de autenticación, nombre, rol, y control de acceso lógico.

---

### 🧬 Atributos Principales

| Atributo      | Tipo      | Descripción                                        |
| ------------- | --------- | -------------------------------------------------- |
| `dni`         | `String`  | Documento de identidad, usado como clave primaria. |
| `nombre`      | `String`  | Nombre completo del usuario.                       |
| `contrasena`  | `String`  | Contraseña de acceso al sistema.                   |
| `rol`         | `String`  | Rol del usuario: `Administrador` o `Normal`.       |
| `acceso`      | `boolean` | Indica si el usuario tiene permiso para acceder.   |
| `esEliminado` | `boolean` | Borrado lógico del usuario.                        |

---

### 🔧 Métodos Principales

| Método                       | Descripción                                                    |
| ---------------------------- | -------------------------------------------------------------- |
| `getDni()`                   | Retorna el DNI del usuario.                                    |
| `getNombre()`                | Retorna el nombre del usuario.                                 |
| `getContrasena()`            | Devuelve la contraseña del usuario.                            |
| `getRol()`                   | Devuelve el rol asignado.                                      |
| `tieneAcceso()`              | Indica si el usuario tiene acceso habilitado (`true`/`false`). |
| `isEliminado()`              | Indica si está marcado como eliminado.                         |
| `compararContrasena(String)` | Compara la contraseña actual con otra cadena ingresada.        |
| `toString()`                 | Devuelve el `dni` (usado en `JTable`).                         |

---

### 🧾 Código Fuente

```java
public class UsuarioDto {

    private String dni;
    private String nombre;
    private String contrasena;
    private String rol;
    private boolean acceso;
    private boolean esEliminado;

    public UsuarioDto(String dni, String nombre, String contrasena, String rol, boolean acceso, boolean esEliminado) {
        this.dni = dni;
        this.nombre = nombre;
        this.contrasena = contrasena;
        this.rol = rol;
        this.acceso = acceso;
        this.esEliminado = esEliminado;
    }

    public UsuarioDto(String dni, String nombre, String contrasena, String rol) {
        this.dni = dni;
        this.nombre = nombre;
        this.contrasena = contrasena;
        this.rol = rol;
    }

    public UsuarioDto(String dni, String contrasena) {
        this.dni = dni;
        this.contrasena = contrasena;
    }

    public boolean compararContrasena(String contrasena) {
        return this.contrasena.equals(contrasena);
    }

    public String getDni() {
        return dni;
    }

    public String getNombre() {
        return nombre;
    }

    public String getContrasena() {
        return contrasena;
    }

    public String getRol() {
        return rol;
    }

    public boolean tieneAcceso() {
        return acceso;
    }

    public boolean isEliminado() {
        return esEliminado;
    }

    @Override
    public String toString() {
        return dni;
    }
}
```
