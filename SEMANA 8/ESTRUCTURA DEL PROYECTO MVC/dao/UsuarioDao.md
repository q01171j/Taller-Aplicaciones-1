## 📄 Clase: UsuarioDao

> 📁 Ubicación: `modelo.dao/UsuarioDao.java`

---

### 🧩 Descripción

`UsuarioDao` es la clase encargada de gestionar las operaciones sobre la tabla `usuarios` en la base de datos. Implementa la interfaz `IUsuarios<UsuarioDto>` para extender las funcionalidades CRUD con lógica de autenticación y recuperación de cuentas eliminadas.

---

### 📌 Funcionalidad Principal

| Método                              | Descripción                                                                          |
| ----------------------------------- | ------------------------------------------------------------------------------------ |
| `crearUsuario(UsuarioDto obj)`      | Crea un nuevo usuario o lo restaura si ya existe como eliminado.                     |
| `actualizarUsuario(UsuarioDto obj)` | Actualiza los datos del usuario. Soporta actualización condicional de la contraseña. |
| `eliminarUsuario(String dni)`       | Realiza un borrado lógico (`eseliminado = true`).                                    |
| `ingresarUsuario(UsuarioDto obj)`   | Valida las credenciales y devuelve el usuario si cumple condiciones de acceso.       |
| `buscarUsuario(String filtro)`      | Devuelve una lista filtrada por nombre o DNI, ignorando los eliminados.              |

---

### 🔍 Detalles Técnicos

- Se usa `rollback()` y `commit()` en la creación para asegurar consistencia transaccional.
- Login solo válido para usuarios no eliminados y con acceso activo.
- El `crearUsuario` soporta reactivación de usuarios eliminados.
- Todos los accesos están protegidos con `PreparedStatement` para evitar inyecciones SQL.

---

### 🧠 Consideraciones

- Se muestra retroalimentación al usuario mediante `JOptionPane` en cada operación.
- Ideal para sistemas que requieren control de acceso seguro y gestión de usuarios.
- Puede extenderse fácilmente para implementar roles adicionales (más allá de Administrador/Normal).

---

### 🧾 Código Resumido (ejemplo)

```java
package modelo.dao;

import interfaces.IUsuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;
import modelo.dto.UsuarioDto;

public class UsuarioDao extends Conexion implements IUsuarios<UsuarioDto> {

    private String consulta;
    private PreparedStatement stmt;
    private ResultSet rs;
    private Connection conexion;

    @Override
    public boolean crearUsuario(UsuarioDto obj) {
        conexion = null;
        stmt = null;
        rs = null;

        try {
            conexion = obtenerConexion();
            conexion.setAutoCommit(false);

            // Verificar si el DNI ya existe
            consulta = "SELECT eseliminado FROM usuarios WHERE dni = ?";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, obj.getDni());
            rs = stmt.executeQuery();

            if (rs.next()) {
                boolean eliminado = rs.getBoolean("eseliminado");

                if (!eliminado) {
                    // Usuario activo ya existe
                    conexion.rollback();
                    JOptionPane.showMessageDialog(null, "El usuario ya existe.", "Registro duplicado", JOptionPane.WARNING_MESSAGE);
                    return false;
                } else {
                    // Restaurar y actualizar usuario eliminado
                    consulta = "UPDATE usuarios SET nombre = ?, contrasena = ?, rol = ?, acceso = ?, eseliminado = false WHERE dni = ?";
                    stmt = conexion.prepareStatement(consulta);
                    stmt.setString(1, obj.getNombre());
                    stmt.setString(2, obj.getContrasena());
                    stmt.setString(3, obj.getRol());
                    stmt.setBoolean(4, obj.tieneAcceso());
                    stmt.setString(5, obj.getDni());

                    int filasActualizadas = stmt.executeUpdate();
                    if (filasActualizadas > 0) {
                        conexion.commit();
                        JOptionPane.showMessageDialog(null, "Usuario restaurado y actualizado exitosamente.", "Éxito", JOptionPane.INFORMATION_MESSAGE);
                        return true;
                    } else {
                        conexion.rollback();
                        JOptionPane.showMessageDialog(null, "No se pudo restaurar el usuario.", "Error", JOptionPane.ERROR_MESSAGE);
                        return false;
                    }
                }
            }

            // Insertar nuevo usuario
            consulta = "INSERT INTO usuarios (dni, nombre, contrasena, rol, acceso, eseliminado) VALUES (?, ?, ?, ?, ?, false)";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, obj.getDni());
            stmt.setString(2, obj.getNombre());
            stmt.setString(3, obj.getContrasena());
            stmt.setString(4, obj.getRol());
            stmt.setBoolean(5, obj.tieneAcceso());

            int filasInsertadas = stmt.executeUpdate();

            if (filasInsertadas == 0) {
                conexion.rollback();
                throw new SQLException("No se pudo insertar el usuario.");
            }

            conexion.commit();
            JOptionPane.showMessageDialog(null, "Usuario creado exitosamente.", "Éxito", JOptionPane.INFORMATION_MESSAGE);
            return true;

        } catch (SQLException ex) {
            try {
                if (conexion != null) {
                    conexion.rollback();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            JOptionPane.showMessageDialog(null, "Error al crear el usuario: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            return false;

        } finally {
            consulta = "";
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public boolean actualizarUsuario(UsuarioDto obj) {
        conexion = null;
        stmt = null;

        try {
            conexion = obtenerConexion();

            String nuevaContrasena = obj.getContrasena();
            boolean actualizarContrasena = nuevaContrasena != null && !nuevaContrasena.isEmpty();

            if (actualizarContrasena) {
                consulta = "UPDATE usuarios SET nombre = ?, contrasena = ?, rol = ?, acceso = ? WHERE dni = ? AND eseliminado = false";
                stmt = conexion.prepareStatement(consulta);
                stmt.setString(1, obj.getNombre());
                stmt.setString(2, nuevaContrasena);
                stmt.setString(3, obj.getRol());
                stmt.setBoolean(4, obj.tieneAcceso());
                stmt.setString(5, obj.getDni());
            } else {
                consulta = "UPDATE usuarios SET nombre = ?, rol = ?, acceso = ? WHERE dni = ? AND eseliminado = false";
                stmt = conexion.prepareStatement(consulta);
                stmt.setString(1, obj.getNombre());
                stmt.setString(2, obj.getRol());
                stmt.setBoolean(3, obj.tieneAcceso());
                stmt.setString(4, obj.getDni());
            }

            int filas = stmt.executeUpdate();

            if (filas > 0) {
                JOptionPane.showMessageDialog(null, "Usuario actualizado exitosamente.", "Éxito", JOptionPane.INFORMATION_MESSAGE);
                return true;
            } else {
                JOptionPane.showMessageDialog(null, "No se encontró un usuario activo con ese DNI.", "Aviso", JOptionPane.WARNING_MESSAGE);
                return false;
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al actualizar el usuario: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            return false;

        } finally {
            consulta = "";
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public boolean eliminarUsuario(String dni) {
        conexion = null;
        stmt = null;

        // Marcamos como eliminado solo si aún no lo está
        consulta = "UPDATE usuarios SET eseliminado = true WHERE dni = ? AND eseliminado = false";

        try {
            conexion = obtenerConexion();
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, dni);

            int filas = stmt.executeUpdate();

            if (filas > 0) {
                JOptionPane.showMessageDialog(null, "Usuario eliminado correctamente (borrado lógico).", "Éxito", JOptionPane.INFORMATION_MESSAGE);
                return true;
            } else {
                JOptionPane.showMessageDialog(null, "No se encontró un usuario activo con ese DNI.", "Advertencia", JOptionPane.WARNING_MESSAGE);
                return false;
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al eliminar el usuario: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            return false;

        } finally {
            consulta = "";
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public UsuarioDto ingresarUsuario(UsuarioDto obj) {
        conexion = null;
        stmt = null;
        rs = null;

        consulta = "SELECT dni, nombre, contrasena, rol, acceso, eseliminado FROM usuarios WHERE dni = ?";

        try {
            conexion = obtenerConexion();
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, obj.getDni());

            rs = stmt.executeQuery();

            if (rs.next()) {
                String contrasenaBD = rs.getString("contrasena");
                boolean acceso = rs.getBoolean("acceso");
                boolean eliminado = rs.getBoolean("eseliminado");

                if (!eliminado && acceso && contrasenaBD.equals(obj.getContrasena())) {
                    // Login exitoso
                    return new UsuarioDto(
                            rs.getString("dni"),
                            rs.getString("nombre"),
                            contrasenaBD,
                            rs.getString("rol"),
                            acceso,
                            eliminado
                    );
                }
            }

            JOptionPane.showMessageDialog(null, "Usuario o contraseña incorrectos, o cuenta deshabilitada.", "Acceso denegado", JOptionPane.WARNING_MESSAGE);
            return null;

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al ingresar: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            return null;

        } finally {
            consulta = "";
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public List<UsuarioDto> buscarUsuario(String buscar) {
        List<UsuarioDto> lista = new ArrayList<>();
        conexion = null;
        stmt = null;
        rs = null;

        consulta = "SELECT dni, nombre, contrasena, rol, acceso, eseliminado FROM usuarios "
                + "WHERE (dni LIKE ? OR nombre LIKE ?) AND eseliminado = false";

        try {
            conexion = obtenerConexion();
            stmt = conexion.prepareStatement(consulta);
            String valorBusqueda = "%" + buscar + "%";
            stmt.setString(1, valorBusqueda);
            stmt.setString(2, valorBusqueda);

            rs = stmt.executeQuery();

            while (rs.next()) {
                UsuarioDto usuario = new UsuarioDto(
                        rs.getString("dni"),
                        rs.getString("nombre"),
                        rs.getString("contrasena"),
                        rs.getString("rol"),
                        rs.getBoolean("acceso"),
                        rs.getBoolean("eseliminado")
                );
                lista.add(usuario);
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, "Error al buscar usuarios: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        } finally {
            consulta = "";
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conexion != null) {
                    conexion.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return lista;
    }
}
```
