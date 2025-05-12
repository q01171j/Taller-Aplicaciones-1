## 🏛️ DTO: FacultadDto

> 📁 Ubicación: `modelo.dto/FacultadDto.java`

---

### 🧩 Descripción

La clase `FacultadDto` representa una facultad académica dentro del sistema. Contiene su código identificador, nombre y un indicador lógico que define si ha sido eliminada del sistema (eliminación lógica).

---

### 🧬 Atributos Principales

| Atributo      | Tipo      | Descripción                                     |
| ------------- | --------- | ----------------------------------------------- |
| `codigo`      | `String`  | Código único que identifica la facultad.        |
| `nombre`      | `String`  | Nombre descriptivo de la facultad.              |
| `esEliminado` | `boolean` | Indica si está marcada como eliminada (lógica). |

---

### 🔧 Métodos Principales

| Método          | Descripción                                          |
| --------------- | ---------------------------------------------------- |
| `getCodigo()`   | Retorna el código de la facultad.                    |
| `getNombre()`   | Retorna el nombre de la facultad.                    |
| `isEliminado()` | Devuelve `true` si fue marcada como eliminada.       |
| `toString()`    | Retorna el nombre para mostrarse en listas o combos. |

---

### 🧾 Código Fuente

```java
public class FacultadDto {

    private String codigo;
    private String nombre;
    private boolean esEliminado;

    public FacultadDto(String codigo, String nombre, boolean esEliminado) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.esEliminado = esEliminado;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public boolean isEliminado() {
        return esEliminado;
    }

    @Override
    public String toString() {
        return nombre;
    }
}
```
