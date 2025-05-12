## 📦 DTO: EscuelaProfesionalDto

> 📁 Ubicación: `modelo.dto/EscuelaProfesionalDto.java`

---

### 🧩 Descripción

La clase `EscuelaProfesionalDto` representa una escuela profesional dentro del sistema. Esta entidad está vinculada a una facultad y se utiliza para establecer relaciones jerárquicas entre facultades y carreras profesionales.

---

### 🧬 Atributos Principales

| Atributo        | Tipo             | Descripción                                                |
|-----------------|------------------|------------------------------------------------------------|
| `codigo`        | `String`         | Código único de la escuela profesional.                    |
| `nombre`        | `String`         | Nombre de la escuela profesional.                          |
| `facultad`      | `FacultadDto`    | Facultad a la que pertenece la escuela.                    |
| `esEliminado`   | `boolean`        | Indica si la escuela está marcada como eliminada.          |

---

### 🔧 Métodos Principales

| Método                    | Descripción                                       |
|---------------------------|---------------------------------------------------|
| `getCodigo()`             | Retorna el código de la escuela.                 |
| `getNombre()`             | Retorna el nombre de la escuela.                 |
| `getFacultad()`           | Retorna el objeto `FacultadDto` asociado.        |
| `isEliminado()`           | Retorna el estado de eliminación lógica.         |
| `toString()`              | Retorna el nombre para mostrar en combos/tablas. |

---

### 🧾 Código Fuente

```java
public class EscuelaProfesionalDto {

    private String codigo;
    private String nombre;
    private FacultadDto facultad;
    private boolean esEliminado;

    public EscuelaProfesionalDto(String codigo, String nombre, FacultadDto facultad, boolean esEliminado) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.facultad = facultad;
        this.esEliminado = esEliminado;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public FacultadDto getFacultad() {
        return facultad;
    }

    public boolean isEliminado() {
        return esEliminado;
    }

    @Override
    public String toString() {
        return nombre;
    }
}
