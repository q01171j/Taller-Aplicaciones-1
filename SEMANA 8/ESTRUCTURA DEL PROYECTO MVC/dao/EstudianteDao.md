## 📄 Clase: EstudianteDao

> 📁 Ubicación: `modelo.dao/EstudianteDao.java`

---

### 🧩 Descripción

`EstudianteDao` es la clase responsable de realizar las operaciones CRUD sobre la entidad **Estudiante**. Implementa la interfaz `ICrud<EstudianteDto>` y extiende de `Conexion` para acceder a la base de datos.

Se relaciona con `EscuelaProfesionalDto` y `FacultadDto`, ya que un estudiante pertenece a una escuela profesional y esta a su vez a una facultad.

---

### 📌 Funcionalidad

| Método                          | Descripción                                                                         |
| ------------------------------- | ----------------------------------------------------------------------------------- |
| `crear(EstudianteDto obj)`      | Registra un nuevo estudiante junto con su foto y escuela.                           |
| `actualizar(EstudianteDto obj)` | Permite editar nombres, apellidos, foto o escuela del estudiante.                   |
| `eliminar(String dni)`          | Realiza un borrado lógico (`eseliminado = true`).                                   |
| `buscar(String filtro)`         | Lista estudiantes según filtros de texto, incluyendo info de su escuela y facultad. |

---

### 🧬 Relaciones con otras entidades

Durante la búsqueda, se realiza un `JOIN` con las tablas `escuela_profesional` y `facultad`, lo que permite retornar la jerarquía completa del estudiante.

---

### 🧾 Código Fuente (resumen)

```java
package modelo.dao;

import interfaces.ICrud;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.EscuelaProfesionalDto;
import modelo.dto.EstudianteDto;
import modelo.dto.FacultadDto;

public class EstudianteDao extends Conexion implements ICrud<EstudianteDto> {

    private Connection conexion;
    private PreparedStatement stmt;
    private ResultSet rs;
    private String consulta;

    @Override
    public boolean crear(EstudianteDto obj) {
        try {
            conexion = obtenerConexion();

            consulta = "INSERT INTO estudiantes (dni, codigo, nombres, apellidos, foto, escuela_codigo, eseliminado) "
                    + "VALUES (?, ?, ?, ?, ?, ?, false)";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, obj.getDni());
            stmt.setString(2, obj.getCodigo());
            stmt.setString(3, obj.getNombres());
            stmt.setString(4, obj.getApellidos());
            stmt.setBytes(5, obj.getFoto());
            stmt.setString(6, obj.getEscuelaProfesional().getCodigo());

            int filas = stmt.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            cerrarTodo();
        }
    }

    @Override
    public boolean actualizar(EstudianteDto obj) {
        try {
            conexion = obtenerConexion();

            consulta = "UPDATE estudiantes SET nombres = ?, apellidos = ?, foto = ?, escuela_codigo = ? "
                    + "WHERE dni = ? AND eseliminado = false";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, obj.getNombres());
            stmt.setString(2, obj.getApellidos());
            stmt.setBytes(3, obj.getFoto());
            stmt.setString(4, obj.getEscuelaProfesional().getCodigo());
            stmt.setString(5, obj.getDni());

            int filas = stmt.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            cerrarTodo();
        }
    }

    @Override
    public boolean eliminar(String dni) {
        try {
            conexion = obtenerConexion();

            consulta = "UPDATE estudiantes SET eseliminado = true WHERE dni = ?";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, dni);

            int filas = stmt.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            cerrarTodo();
        }
    }

    @Override
    public List<EstudianteDto> buscar(String filtro) {
        List<EstudianteDto> lista = new ArrayList<>();

        try {
            conexion = obtenerConexion();

            consulta = "SELECT e.*, ep.codigo AS ep_codigo, ep.nombre AS ep_nombre, "
                    + "f.codigo AS f_codigo, f.nombre AS f_nombre, ep.eseliminado AS ep_eliminado, f.eseliminado AS f_eliminado "
                    + "FROM estudiantes e "
                    + "JOIN escuela_profesional ep ON e.escuela_codigo = ep.codigo "
                    + "JOIN facultad f ON ep.facultad_codigo = f.codigo "
                    + "WHERE (e.dni LIKE ? OR e.codigo LIKE ? OR e.nombres LIKE ? OR e.apellidos LIKE ?) AND e.eseliminado = false";

            stmt = conexion.prepareStatement(consulta);
            String param = "%" + filtro + "%";
            stmt.setString(1, param);
            stmt.setString(2, param);
            stmt.setString(3, param);
            stmt.setString(4, param);

            rs = stmt.executeQuery();

            while (rs.next()) {
                FacultadDto facultad = new FacultadDto(
                        rs.getString("f_codigo"),
                        rs.getString("f_nombre"),
                        rs.getBoolean("f_eliminado")
                );

                EscuelaProfesionalDto escuela = new EscuelaProfesionalDto(
                        rs.getString("ep_codigo"),
                        rs.getString("ep_nombre"),
                        facultad,
                        rs.getBoolean("ep_eliminado")
                );

                EstudianteDto estudiante = new EstudianteDto(
                        rs.getString("dni"),
                        rs.getString("codigo"),
                        rs.getString("nombres"),
                        rs.getString("apellidos"),
                        rs.getBytes("foto"),
                        escuela,
                        rs.getBoolean("eseliminado")
                );

                lista.add(estudiante);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            cerrarTodo();
        }

        return lista;
    }

    private void cerrarTodo() {
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

```
