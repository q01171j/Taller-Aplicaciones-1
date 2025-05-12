## 🪟 GUI: GuiMenu

> 📁 Ubicación: `gui/GuiMenu.java`

---

### 🧩 Descripción

`GuiMenu` es la interfaz gráfica principal del sistema, construida con **Java Swing**, que permite al usuario interactuar con los distintos módulos del sistema: gestión de usuarios, facultades, escuelas profesionales y carnets.

---

### 🖼️ Vista General

![Vista de la Interfaz GuiMenu](./GuiMenu.png)

> 📌 Asegúrate de que el archivo `GuiMenu.png` esté ubicado en la misma carpeta para visualizar esta imagen correctamente.

---

### 🎯 Funcionalidades

| Sección              | Función Principal                                              |
|----------------------|----------------------------------------------------------------|
| 🧑 Usuarios           | Crear, actualizar, eliminar y buscar usuarios.                |
| 🏢 Facultades         | Gestión de registros de facultades.                           |
| 🏫 Escuelas           | Asociación de escuelas profesionales a facultades.           |
| 🪪 Carnets            | Generación de carnets para estudiantes con imagen incluida.  |

---

### 📌 Componentes Notables

- **JTable** para mostrar usuarios, escuelas, facultades y carnets.
- **JTextField, JComboBox, JCheckBox, JDateChooser** para capturar información del usuario.
- **JLabel con icono** para mostrar la imagen del carnet.
- **Botones** con acciones dinámicas: cambiar texto entre "Actualizar / Guardar", "Eliminar / Cancelar", etc.
- Control visual y funcional según el **rol** del usuario logueado.

---

### 🧠 Consideraciones

- El sistema distingue entre usuarios Administradores y Normales.
- Los campos se habilitan/deshabilitan dinámicamente según el modo (crear/editar).
- Incluye soporte para carga de imágenes usando `JFileChooser`.

---

### 🔁 Navegación

Desde aquí puedes volver al `README` principal o revisar otras secciones:

🔙 [Volver al README Principal](../README.md)

📄 [Controlador asociado (ControladorMenu.java)](../controladores/ControladorMenu.java)