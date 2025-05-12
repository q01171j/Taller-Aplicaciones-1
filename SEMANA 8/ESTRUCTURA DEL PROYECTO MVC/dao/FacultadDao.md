## 📄 Clase: FacultadDao

> 📁 Ubicación: `modelo.dao/FacultadDao.java`

---

### 🧩 Descripción

`FacultadDao` es la clase responsable de realizar operaciones CRUD sobre la tabla **facultad** en la base de datos. Implementa la interfaz `ICrud<FacultadDto>` y extiende de `Conexion` para utilizar el método de conexión centralizado.

Permite registrar, modificar, listar y realizar borrado lógico de facultades.

---

### 📌 Funcionalidad

| Método                        | Descripción                                                            |
| ----------------------------- | ---------------------------------------------------------------------- |
| `crear(FacultadDto obj)`      | Inserta una nueva facultad en la base de datos.                        |
| `actualizar(FacultadDto obj)` | Modifica el nombre de una facultad existente.                          |
| `eliminar(String codigo)`     | Realiza un borrado lógico de la facultad (marca `eseliminado = true`). |
| `buscar(String filtro)`       | Devuelve una lista filtrada por código o nombre.                       |

---

### 🔍 Detalles Técnicos

- La búsqueda se realiza con cláusulas `LIKE` para permitir coincidencias parciales.
- No se eliminan registros físicamente; se aplica borrado lógico (`eseliminado = true`).
- Usa `PreparedStatement` para evitar inyecciones SQL.

---

### 🧾 Código Fuente (resumen)

```java
package modelo.dao;


import interfaces.ICrud;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.FacultadDto;

public class FacultadDao extends Conexion implements ICrud<FacultadDto> {

    private Connection conexion;
    private PreparedStatement stmt;
    private ResultSet rs;
    private String consulta;

    @Override
    public boolean crear(FacultadDto obj) {
        try {
            conexion = obtenerConexion();

            consulta = "INSERT INTO facultad (codigo, nombre, eseliminado) VALUES (?, ?, false)";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, obj.getCodigo());
            stmt.setString(2, obj.getNombre());

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
    public boolean actualizar(FacultadDto obj) {
        try {
            conexion = obtenerConexion();

            consulta = "UPDATE facultad SET nombre = ? WHERE codigo = ? AND eseliminado = false";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, obj.getNombre());
            stmt.setString(2, obj.getCodigo());

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
    public boolean eliminar(String codigo) {
        try {
            conexion = obtenerConexion();

            consulta = "UPDATE facultad SET eseliminado = true WHERE codigo = ?";
            stmt = conexion.prepareStatement(consulta);
            stmt.setString(1, codigo);

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
    public List<FacultadDto> buscar(String filtro) {
        List<FacultadDto> lista = new ArrayList<>();

        try {
            conexion = obtenerConexion();

            consulta = "SELECT * FROM facultad WHERE eseliminado = false AND (codigo LIKE ? OR nombre LIKE ?)";
            stmt = conexion.prepareStatement(consulta);
            String param = "%" + filtro + "%";
            stmt.setString(1, param);
            stmt.setString(2, param);

            rs = stmt.executeQuery();

            while (rs.next()) {
                FacultadDto facultad = new FacultadDto(
                        rs.getString("codigo"),
                        rs.getString("nombre"),
                        rs.getBoolean("eseliminado")
                );
                lista.add(facultad);
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
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conexion != null) conexion.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

```
