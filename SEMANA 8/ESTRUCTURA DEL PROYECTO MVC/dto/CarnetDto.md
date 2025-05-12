## 📦 DTO: CarnetDto

> 📁 Ubicación: `modelo.dto/CarnetDto.java`

---

### 🧩 Descripción

El objeto `CarnetDto` representa los datos asociados a un carnet de estudiante dentro del sistema. Incluye la relación con el estudiante correspondiente, su fecha de expiración y un indicador de borrado lógico.

---

### 🧬 Atributos Principales

| Atributo          | Tipo            | Descripción                                         |
| ----------------- | --------------- | --------------------------------------------------- |
| `estudiante`      | `EstudianteDto` | Referencia al estudiante dueño del carnet.          |
| `fechaExpiracion` | `Date`          | Fecha en la que el carnet dejará de ser válido.     |
| `esEliminado`     | `boolean`       | Indica si el carnet ha sido marcado como eliminado. |

---

### 🧾 Código Fuente

```java
public class CarnetDto {

    private EstudianteDto estudiante;
    private Date fechaExpiracion;
    private boolean esEliminado;

    public CarnetDto(EstudianteDto estudiante, Date fechaExpiracion, boolean esEliminado) {
        this.estudiante = estudiante;
        this.fechaExpiracion = fechaExpiracion;
        this.esEliminado = esEliminado;
    }

    public EstudianteDto getEstudiante() {
        return estudiante;
    }

    public Date getFechaExpiracion() {
        return fechaExpiracion;
    }

    public boolean isEliminado() {
        return esEliminado;
    }

    @Override
    public String toString() {
        return estudiante.getDni();
    }
}
```
