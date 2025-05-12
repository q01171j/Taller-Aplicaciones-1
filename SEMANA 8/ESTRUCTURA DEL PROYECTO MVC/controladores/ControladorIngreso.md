## 🧠 Controlador: ControladorIngreso

> 📁 Ubicación: `controladores/ControladorIngreso.java`

---

### 🧩 Descripción

`ControladorIngreso` se encarga de gestionar la lógica del proceso de inicio de sesión en el sistema. Toma los datos desde `GuiIngreso`, valida los campos y consulta el DAO correspondiente para verificar las credenciales.

---

### 🔐 Funcionalidad Principal

- Validar que los campos no estén vacíos.
- Llamar al método `ingresarUsuario()` del `UsuarioDao`.
- Si el usuario es válido y tiene acceso, abrir la ventana principal (`GuiMenu`).
- Mostrar mensajes de error si la autenticación falla.
- Limpiar los campos luego de cada intento.

---

### 💻 Código Fuente

```java
public class ControladorIngreso {
    private final GuiIngreso vista;
    private final UsuarioDao dao;
    private UsuarioDto dto;

    public ControladorIngreso(GuiIngreso vista, UsuarioDao dao) {
        this.vista = vista;
        this.dao = dao;
    }

    public void loginUsuario() {
        String dni = vista.txtDni.getText();
        String contrasena = vista.pwContrasena.getText();

        if(dni.equals("") || contrasena.equals("")) {
            JOptionPane.showMessageDialog(vista, "Rellene los campos", "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }

        dto = new UsuarioDto(dni, contrasena);
        UsuarioDto usuarioLogueado = dao.ingresarUsuario(dto);
        dto = null;

        if(usuarioLogueado != null) {
            vista.dispose();
            new GuiMenu(usuarioLogueado).setVisible(true);
        }

        vista.txtDni.setText("");
        vista.pwContrasena.setText("");
    }
}
```
