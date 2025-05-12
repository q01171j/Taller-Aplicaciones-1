## 🎓 DTO: EstudianteDto

> 📁 Ubicación: `modelo.dto/EstudianteDto.java`

---

### 🧩 Descripción

La clase `EstudianteDto` representa a un estudiante dentro del sistema. Contiene sus datos personales y la relación con la escuela profesional a la que pertenece. También almacena su fotografía y estado lógico de eliminación.

---

### 🧬 Atributos Principales

| Atributo             | Tipo                    | Descripción                                                |
| -------------------- | ----------------------- | ---------------------------------------------------------- |
| `dni`                | `String`                | Documento Nacional de Identidad del estudiante.            |
| `codigo`             | `String`                | Código interno o matrícula del estudiante.                 |
| `nombres`            | `String`                | Nombres del estudiante.                                    |
| `apellidos`          | `String`                | Apellidos del estudiante.                                  |
| `foto`               | `byte[]`                | Imagen en formato binario (para mostrar en la interfaz).   |
| `escuelaProfesional` | `EscuelaProfesionalDto` | Escuela a la que pertenece el estudiante.                  |
| `esEliminado`        | `boolean`               | Indica si está marcado como eliminado (lógica de negocio). |

---

### 🔧 Métodos Principales

| Método                    | Descripción                                    |
| ------------------------- | ---------------------------------------------- |
| `getDni()`                | Devuelve el DNI del estudiante.                |
| `getCodigo()`             | Devuelve el código interno.                    |
| `getNombres()`            | Devuelve los nombres.                          |
| `getApellidos()`          | Devuelve los apellidos.                        |
| `getFoto()`               | Devuelve la foto como arreglo de bytes.        |
| `getEscuelaProfesional()` | Devuelve el objeto `EscuelaProfesionalDto`.    |
| `isEliminado()`           | Retorna `true` si está marcado como eliminado. |

---

### 🧾 Código Fuente

```java
public class EstudianteDto {

    private String dni;
    private String codigo;
    private String nombres;
    private String apellidos;
    private byte[] foto;
    private EscuelaProfesionalDto escuelaProfesional;
    private boolean esEliminado;

    public EstudianteDto(String dni, String codigo, String nombres, String apellidos, byte[] foto, EscuelaProfesionalDto escuelaProfesional, boolean esEliminado) {
        this.dni = dni;
        this.codigo = codigo;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.foto = foto;
        this.escuelaProfesional = escuelaProfesional;
        this.esEliminado = esEliminado;
    }

    public String getDni() {
        return dni;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getNombres() {
        return nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public byte[] getFoto() {
        return foto;
    }

    public EscuelaProfesionalDto getEscuelaProfesional() {
        return escuelaProfesional;
    }

    public boolean isEliminado() {
        return esEliminado;
    }
}
```
