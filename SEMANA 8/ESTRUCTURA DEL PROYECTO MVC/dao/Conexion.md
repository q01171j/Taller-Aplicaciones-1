## 🔌 Clase: Conexion

> 📁 Ubicación: `modelo.dao/Conexion.java`

---

### 🧩 Descripción

La clase abstracta `Conexion` centraliza la lógica de conexión con la base de datos **MySQL** utilizando JDBC. Esta clase es heredada por todos los DAO del sistema (como `UsuarioDao`, `CarnetDao`, etc.), permitiendo una reutilización eficiente del código.

---

### ⚙️ Propiedades de Conexión

| Atributo     | Valor                          | Descripción                   |
| ------------ | ------------------------------ | ----------------------------- |
| `LINK`       | `jdbc:mysql://localhost:3306/` | Dirección del servidor MySQL. |
| `BD`         | `CarnetDB`                     | Nombre de la base de datos.   |
| `USUARIO`    | `root`                         | Usuario para acceder a MySQL. |
| `CONTRASENA` | `root123`                      | Contraseña del usuario MySQL. |

---

### 🔧 Método

| Método              | Descripción                                                    |
| ------------------- | -------------------------------------------------------------- |
| `obtenerConexion()` | Retorna una conexión abierta con la base de datos configurada. |

---

### 🧾 Código Fuente

```java
package modelo.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class Conexion {

    private final String LINK = "jdbc:mysql://localhost:3306/";
    private final String BD = "CarnetDB";
    private final String USUARIO = "root";
    private final String CONTRASENA = "root123";

    protected Connection obtenerConexion() throws SQLException {
        return DriverManager.getConnection((LINK + BD), USUARIO, CONTRASENA);
    }
}
```
