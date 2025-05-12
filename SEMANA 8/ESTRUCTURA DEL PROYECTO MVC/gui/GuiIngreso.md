## 🔐 GUI: GuiIngreso

> 📁 Ubicación: `gui/GuiIngreso.java`

---

### 🧩 Descripción

`GuiIngreso` es la pantalla de inicio de sesión del sistema. Permite al usuario autenticarse ingresando su **DNI** y **contraseña**. Según el rol validado (Administrador o Usuario Normal), se redirige a una vista con privilegios distintos.

---

### 🖼️ Vista General

![Vista de la Interfaz GuiIngreso](./GuiIngreso.png)

> 📌 Asegúrate de que el archivo `GuiIngreso.png` esté ubicado en la misma carpeta para que se visualice correctamente aquí.

---

### 🎯 Funcionalidades

- Ingreso al sistema mediante credenciales.
- Validación de campos vacíos.
- Mensajes de error si las credenciales son incorrectas o el usuario está inhabilitado.
- Carga automática del `GuiMenu` al iniciar sesión correctamente.

---

### 🧠 Consideraciones Técnicas

- Utiliza un `JPasswordField` para seguridad.
- Llama al método `ingresarUsuario()` desde el DAO, que valida contra la base de datos.
- Controla el flujo hacia `GuiMenu` si el usuario tiene acceso.
- Si el usuario es eliminado o deshabilitado, se bloquea el ingreso.

---

### 📌 Componentes Notables

| Componente         | Función                                |
|--------------------|----------------------------------------|
| `txtDni`           | Campo de texto para el DNI.            |
| `pwContrasena`     | Campo de contraseña oculta.            |
| `btnIngresar`      | Botón que valida las credenciales.     |
| `JOptionPane`      | Mostrar mensajes de alerta o error.    |

---

### 🔁 Navegación

🔙 [Volver al README Principal](../README.md)  
📄 [Controlador asociado (ControladorIngreso.java)](../controladores/ControladorIngreso.java)
