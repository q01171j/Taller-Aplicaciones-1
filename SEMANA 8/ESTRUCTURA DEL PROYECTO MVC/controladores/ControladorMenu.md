## 🧠 Controlador: ControladorMenu

> 📁 Ubicación: `controladores/ControladorMenu.java`

---

### 🧩 Descripción

`ControladorMenu` es la clase central del sistema. Controla y coordina todas las operaciones del menú principal: gestión de usuarios, facultades, escuelas profesionales y carnets. Implementa la interfaz `IControladorMenu` y sigue el patrón MVC actuando como "C" (Controlador).

---

### 🧰 Funcionalidades Principales

| Módulo              | Funcionalidad                                                                                                        |
| ------------------- | -------------------------------------------------------------------------------------------------------------------- |
| 👤 Usuario          | Crear, actualizar, eliminar (lógicamente) y buscar usuarios. Control de acceso y visibilidad por rol.                |
| 🏛️ Facultad         | Crear, actualizar, eliminar (lógicamente), buscar facultades y cargar en combo box.                                  |
| 🏫 Escuela          | Crear, actualizar, eliminar (lógicamente), filtrar por facultad, cargar y visualizar desde combo box y tabla.        |
| 🆔 Carnet           | Registrar, actualizar, eliminar carnets con fecha de expiración, imagen y asociación con escuela y facultad.         |
| 🖼️ Imagen Carnet    | Permite seleccionar una imagen desde el sistema de archivos y asignarla a un carnet con vista previa en un `JLabel`. |
| 📅 Fecha Expiración | Usa `JDateChooser` para establecer la expiración del carnet.                                                         |

---

### 💻 Código Destacado

```java
package controladores;

import gui.GuiMenu;
import interfaces.IControladorMenu;
import java.awt.Image;
import java.util.List;
import modelo.dao.EscuelaProfesionalDao;
import modelo.dao.FacultadDao;
import modelo.dao.UsuarioDao;
import modelo.dto.EscuelaProfesionalDto;
import modelo.dto.FacultadDto;
import modelo.dto.UsuarioDto;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Date;

import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import javax.swing.table.DefaultTableModel;
import modelo.dao.CarnetDao;
import modelo.dao.EstudianteDao;
import modelo.dto.CarnetDto;
import modelo.dto.EstudianteDto;

public class ControladorMenu implements IControladorMenu {

    private enum ModoOperacion {
        VISUALIZAR, CREAR, ACTUALIZAR
    }

    private final GuiMenu vista;
    private final UsuarioDao daoUsuario;
    private final EscuelaProfesionalDao daoEscuela;
    private final FacultadDao daoFacultad;
    private final CarnetDao daoCarnet;
    private final EstudianteDao daoEstudiante;

    private DefaultTableModel modelo;
    private ModoOperacion modoActual;

    public ControladorMenu(
            GuiMenu vista,
            UsuarioDao daoUsuario,
            EscuelaProfesionalDao daoEscuela,
            FacultadDao daoFacultad,
            CarnetDao daoCarnet,
            EstudianteDao daoEstudiante
    ) {
        this.vista = vista;
        this.daoUsuario = daoUsuario;
        this.daoEscuela = daoEscuela;
        this.daoFacultad = daoFacultad;
        this.daoCarnet = daoCarnet;
        this.daoEstudiante = daoEstudiante;

        // ==================== USUARIOS ====================
        inicializar();
        buscarUsuarios();

        // ==================== FACULTADES ====================
        buscarFacultades();
        inicializarFacultad();

        // ==================== ESCUELAS ====================
        buscarEscuelas();
        inicializarEscuela();
        cargarFacultadesEnCombo(); // para cmbFacultadEscuela

        // ==================== CARNETS ====================
        buscarCarnets();
        inicializarCarnet();
        cargarFacultadesCarnet(); // para cmbFacultadCarnet
    }

    @Override
    public void inicializar() {
        modoActual = ModoOperacion.VISUALIZAR;
        limpiarCampos();
        habilitarCampos(false);
        configurarSegunRol();
        desactivarBotones();
    }

    private void configurarSegunRol() {
        if (vista.usuarioLogueado.getRol().equals("Administrador")) {
            vista.chbAccesoUsuario.setVisible(true);
        } else {
            vista.chbAccesoUsuario.setVisible(false);
            vista.btnActualizarUsuario.setVisible(false);
            vista.btnCrearUsuario.setVisible(false);
            vista.btnEliminarUsuario.setVisible(false);
        }
    }

    private void habilitarCampos(boolean estado) {
        vista.txtDniUsuario.setEnabled(estado);
        vista.txtNombreUsuario.setEnabled(estado);
        vista.txtContrasenaUsuario.setEnabled(estado);
        vista.cmbRolUsuario.setEnabled(estado);
        vista.chbAccesoUsuario.setEnabled(estado);
    }

    private void limpiarCampos() {
        vista.txtDniUsuario.setText("");
        vista.txtNombreUsuario.setText("");
        vista.txtContrasenaUsuario.setText("");
        vista.cmbRolUsuario.setSelectedItem("Normal");
        vista.chbAccesoUsuario.setSelected(true);
    }

    private void desactivarBotones() {
        vista.btnActualizarUsuario.setEnabled(false);
        vista.btnEliminarUsuario.setEnabled(false);
    }

    private void resetVista() {
        vista.lblTitulo.setText("Visualizar Usuario");
        vista.btnActualizarUsuario.setText("Actualizar");
        vista.btnEliminarUsuario.setText("Eliminar");
        vista.btnCrearUsuario.setEnabled(true);
        vista.txtBuscarUsuario.setEnabled(true);
        limpiarCampos();
        habilitarCampos(false);
        desactivarBotones();
        modoActual = ModoOperacion.VISUALIZAR;
    }

    @Override
    public void buscarUsuarios() {
        List<UsuarioDto> lista = daoUsuario.buscarUsuario(vista.txtBuscarUsuario.getText());

        modelo = (DefaultTableModel) vista.tblUsuarios.getModel();
        modelo.setRowCount(0);

        for (UsuarioDto u : lista) {
            modelo.addRow(new Object[]{u, u.getNombre(), u.getRol(), u.tieneAcceso()});
        }

        vista.tblUsuarios.clearSelection();
        limpiarCampos();
        habilitarCampos(false);
        desactivarBotones();
    }

    @Override
    public void seleccionarUsuario() {
        int fila = vista.tblUsuarios.getSelectedRow();
        if (fila == -1) {
            return;
        }

        UsuarioDto usuario = (UsuarioDto) vista.tblUsuarios.getValueAt(fila, 0);
        vista.txtDniUsuario.setText(usuario.getDni());
        vista.txtNombreUsuario.setText(usuario.getNombre());
        vista.txtContrasenaUsuario.setText(usuario.getContrasena());
        vista.cmbRolUsuario.setSelectedItem(usuario.getRol());
        vista.chbAccesoUsuario.setSelected(usuario.tieneAcceso());

        habilitarCampos(true);
        vista.txtDniUsuario.setEnabled(false); // DNI no se modifica
        vista.btnActualizarUsuario.setEnabled(true);
        vista.btnEliminarUsuario.setEnabled(true);
        modoActual = ModoOperacion.VISUALIZAR;
    }

    @Override
    public void crearUsuario() {
        vista.lblTitulo.setText("Crear Usuario");
        vista.btnActualizarUsuario.setText("Guardar");
        vista.btnEliminarUsuario.setText("Cancelar");
        vista.btnActualizarUsuario.setEnabled(true);
        vista.btnEliminarUsuario.setEnabled(true);
        vista.btnCrearUsuario.setEnabled(false);
        vista.txtBuscarUsuario.setEnabled(false);
        limpiarCampos();
        habilitarCampos(true);
        modoActual = ModoOperacion.CREAR;
    }

    @Override
    public void actualizarUsuario() {
        if (modoActual == ModoOperacion.VISUALIZAR) {
            vista.lblTitulo.setText("Actualizar Usuario");
            vista.btnActualizarUsuario.setText("Guardar");
            vista.btnEliminarUsuario.setText("Cancelar");
            vista.btnCrearUsuario.setEnabled(false);
            vista.txtBuscarUsuario.setEnabled(false);
            habilitarCampos(true);
            vista.txtDniUsuario.setEnabled(false); // no editable
            modoActual = ModoOperacion.ACTUALIZAR;
        }
    }

    @Override
    public void guardarUsuario() {
        String dni = vista.txtDniUsuario.getText().trim();
        String nombre = vista.txtNombreUsuario.getText().trim();
        String contrasena = vista.txtContrasenaUsuario.getText().trim();
        String rol = (String) vista.cmbRolUsuario.getSelectedItem();
        boolean acceso = vista.chbAccesoUsuario.isSelected();

        if (dni.isEmpty() || nombre.isEmpty() || contrasena.isEmpty()) {
            JOptionPane.showMessageDialog(vista, "Complete todos los campos.", "ValidaciÃ³n", JOptionPane.WARNING_MESSAGE);
            return;
        }

        boolean respuesta = false;

        if (modoActual == ModoOperacion.CREAR) {
            UsuarioDto obj = new UsuarioDto(dni, nombre, contrasena, rol, acceso, false);
            respuesta = daoUsuario.crearUsuario(obj);

        } else if (modoActual == ModoOperacion.ACTUALIZAR) {
            UsuarioDto obj = new UsuarioDto(dni, nombre, contrasena, rol, acceso, false);
            respuesta = daoUsuario.actualizarUsuario(obj);
        }

        if (respuesta) {
            resetVista();
            buscarUsuarios();
        }
    }

    @Override
    public void cancelarUsuario() {
        resetVista();
    }

    @Override
    public void eliminarUsuario() {
        if (modoActual != ModoOperacion.VISUALIZAR) {
            return;
        }

        int confirm = JOptionPane.showConfirmDialog(vista, "Â¿Seguro de eliminar este usuario?", "Confirmar", JOptionPane.YES_NO_OPTION);
        if (confirm != JOptionPane.YES_OPTION) {
            return;
        }

        String dni = vista.txtDniUsuario.getText();
        boolean respuesta = daoUsuario.eliminarUsuario(dni);

        if (respuesta) {
            buscarUsuarios();
            resetVista();
        }
    }

    // ========================== FACULTAD ==========================
    private enum ModoFacultad {
        VISUALIZAR, CREAR, ACTUALIZAR
    }
    private ModoFacultad modoFacultad = ModoFacultad.VISUALIZAR;

    private void inicializarFacultad() {
        limpiarCamposFacultad();
        vista.txtCodigoFacultad.setEnabled(false);
        vista.txtNombreFacultad.setEnabled(false);
        vista.btnActualizarFacultad.setEnabled(false);
        vista.btnEliminarFacultad.setEnabled(false);
        vista.btnActualizarFacultad.setText("Actualizar");
        vista.btnEliminarFacultad.setText("Eliminar");
    }

    public void buscarFacultades() {
        List<FacultadDto> lista = daoFacultad.buscar(vista.txtBuscarFacultad.getText());
        DefaultTableModel modelo = (DefaultTableModel) vista.tblFacultad.getModel();
        modelo.setRowCount(0);

        for (FacultadDto f : lista) {
            modelo.addRow(new Object[]{f.getCodigo(), f}); // f.toString() muestra nombre
        }

        vista.tblFacultad.clearSelection();
        inicializarFacultad();
    }

    public void seleccionarFacultad() {
        int fila = vista.tblFacultad.getSelectedRow();
        if (fila == -1) {
            return;
        }

        FacultadDto facultad = (FacultadDto) vista.tblFacultad.getValueAt(fila, 1);
        vista.txtCodigoFacultad.setText(facultad.getCodigo());
        vista.txtNombreFacultad.setText(facultad.getNombre());

        vista.txtCodigoFacultad.setEnabled(false);
        vista.txtNombreFacultad.setEnabled(false);
        vista.btnActualizarFacultad.setEnabled(true);
        vista.btnEliminarFacultad.setEnabled(true);
        vista.btnActualizarFacultad.setText("Actualizar");
        vista.btnEliminarFacultad.setText("Eliminar");

        modoFacultad = ModoFacultad.VISUALIZAR;
    }

    public void crearFacultad() {
        limpiarCamposFacultad();
        vista.txtCodigoFacultad.setEnabled(true);
        vista.txtNombreFacultad.setEnabled(true);
        vista.btnActualizarFacultad.setEnabled(true);
        vista.btnActualizarFacultad.setText("Guardar");
        vista.btnEliminarFacultad.setEnabled(true);
        vista.btnEliminarFacultad.setText("Cancelar");

        modoFacultad = ModoFacultad.CREAR;
    }

    public void cargarFacultadesEnCombo() {
        List<FacultadDto> lista = daoFacultad.buscar("");
        vista.cmbFacultadEscuela.removeAllItems();
        for (FacultadDto f : lista) {
            vista.cmbFacultadEscuela.addItem(f); // el toString() mostrarÃ¡ el nombre
        }
        vista.cmbFacultadEscuela.setSelectedIndex(-1);
    }

    public void guardarFacultad() {
        String codigo = vista.txtCodigoFacultad.getText().trim();
        String nombre = vista.txtNombreFacultad.getText().trim();

        if (codigo.isEmpty() || nombre.isEmpty()) {
            JOptionPane.showMessageDialog(vista, "Complete todos los campos.", "ValidaciÃ³n", JOptionPane.WARNING_MESSAGE);
            return;
        }

        FacultadDto dto = new FacultadDto(codigo, nombre, false);
        boolean respuesta = false;

        if (modoFacultad == ModoFacultad.CREAR) {
            respuesta = daoFacultad.crear(dto);
        } else if (modoFacultad == ModoFacultad.ACTUALIZAR) {
            respuesta = daoFacultad.actualizar(dto);
        }

        if (respuesta) {
            buscarFacultades();
            cargarFacultadesEnCombo();
            inicializarFacultad();
        }
    }

    public void actualizarFacultad() {
        if (modoFacultad == ModoFacultad.VISUALIZAR) {
            vista.txtNombreFacultad.setEnabled(true);
            vista.btnActualizarFacultad.setText("Guardar");
            vista.btnEliminarFacultad.setText("Cancelar");
            modoFacultad = ModoFacultad.ACTUALIZAR;
        } else {
            guardarFacultad();
        }
    }

    public void eliminarFacultad() {
        if (vista.btnEliminarFacultad.getText().equals("Cancelar")) {
            buscarFacultades();
            return;
        }

        String codigo = vista.txtCodigoFacultad.getText().trim();
        if (daoFacultad.eliminar(codigo)) {
            buscarFacultades();
            cargarFacultadesEnCombo();
            inicializarFacultad();
        }
    }

    private void limpiarCamposFacultad() {
        vista.txtCodigoFacultad.setText("");
        vista.txtNombreFacultad.setText("");
        vista.btnActualizarFacultad.setText("Actualizar");
        vista.btnEliminarFacultad.setText("Eliminar");
    }

// ========================== ESCUELA ==========================
    private enum ModoEscuela {
        VISUALIZAR, CREAR, ACTUALIZAR
    }
    private ModoEscuela modoEscuela = ModoEscuela.VISUALIZAR;

    private void inicializarEscuela() {
        limpiarCamposEscuela();
        vista.txtCodigoEscuela.setEnabled(false);
        vista.txtNombreEscuela.setEnabled(false);
        vista.cmbFacultadEscuela.setEnabled(false);
        vista.btnActualizarEscuela.setEnabled(false);
        vista.btnEliminarEscuela.setEnabled(false);
        vista.btnActualizarEscuela.setText("Actualizar");
        vista.btnEliminarEscuela.setText("Eliminar");
    }

    public void buscarEscuelas() {
        List<EscuelaProfesionalDto> lista = daoEscuela.buscar(vista.txtBuscarEscuela.getText());
        DefaultTableModel modelo = (DefaultTableModel) vista.tblEscuela.getModel();
        modelo.setRowCount(0);

        for (EscuelaProfesionalDto e : lista) {
            modelo.addRow(new Object[]{e.getCodigo(), e, e.getFacultad()}); // objetos
        }

        vista.tblEscuela.clearSelection();
        inicializarEscuela();
    }

    public void seleccionarEscuela() {
        int fila = vista.tblEscuela.getSelectedRow();
        if (fila == -1) {
            return;
        }

        EscuelaProfesionalDto escuela = (EscuelaProfesionalDto) vista.tblEscuela.getValueAt(fila, 1);
        vista.txtCodigoEscuela.setText(escuela.getCodigo());
        vista.txtNombreEscuela.setText(escuela.getNombre());

        FacultadDto facultad = escuela.getFacultad();
        for (int i = 0; i < vista.cmbFacultadEscuela.getItemCount(); i++) {
            FacultadDto f = (FacultadDto) vista.cmbFacultadEscuela.getItemAt(i);
            if (f.getCodigo().equals(facultad.getCodigo())) {
                vista.cmbFacultadEscuela.setSelectedIndex(i);
                break;
            }
        }

        vista.txtCodigoEscuela.setEnabled(false);
        vista.txtNombreEscuela.setEnabled(false);
        vista.cmbFacultadEscuela.setEnabled(false);
        vista.btnActualizarEscuela.setEnabled(true);
        vista.btnEliminarEscuela.setEnabled(true);
        vista.btnActualizarEscuela.setText("Actualizar");
        vista.btnEliminarEscuela.setText("Eliminar");

        modoEscuela = ModoEscuela.VISUALIZAR;
    }

    public void crearEscuela() {
        limpiarCamposEscuela();
        vista.txtCodigoEscuela.setEnabled(true);
        vista.txtNombreEscuela.setEnabled(true);
        vista.cmbFacultadEscuela.setEnabled(true);
        vista.btnActualizarEscuela.setEnabled(true);
        vista.btnActualizarEscuela.setText("Guardar");
        vista.btnEliminarEscuela.setEnabled(true);
        vista.btnEliminarEscuela.setText("Cancelar");

        modoEscuela = ModoEscuela.CREAR;
    }

    public void guardarEscuela() {
        String codigo = vista.txtCodigoEscuela.getText().trim();
        String nombre = vista.txtNombreEscuela.getText().trim();
        FacultadDto facultad = (FacultadDto) vista.cmbFacultadEscuela.getSelectedItem();

        if (codigo.isEmpty() || nombre.isEmpty() || facultad == null) {
            JOptionPane.showMessageDialog(vista, "Complete todos los campos.", "ValidaciÃ³n", JOptionPane.WARNING_MESSAGE);
            return;
        }

        EscuelaProfesionalDto dto = new EscuelaProfesionalDto(codigo, nombre, facultad, false);
        boolean respuesta = false;

        if (modoEscuela == ModoEscuela.CREAR) {
            respuesta = daoEscuela.crear(dto);
        } else if (modoEscuela == ModoEscuela.ACTUALIZAR) {
            respuesta = daoEscuela.actualizar(dto);
        }

        if (respuesta) {
            buscarEscuelas();
            inicializarEscuela();
        }
    }

    public void actualizarEscuela() {
        if (modoEscuela == ModoEscuela.VISUALIZAR) {
            vista.txtNombreEscuela.setEnabled(true);
            vista.cmbFacultadEscuela.setEnabled(true);
            vista.btnActualizarEscuela.setText("Guardar");
            vista.btnEliminarEscuela.setText("Cancelar");
            modoEscuela = ModoEscuela.ACTUALIZAR;
        } else {
            guardarEscuela();
        }
    }

    public void eliminarEscuela() {
        if (vista.btnEliminarEscuela.getText().equals("Cancelar")) {
            buscarEscuelas();
            return;
        }

        String codigo = vista.txtCodigoEscuela.getText().trim();
        if (daoEscuela.eliminar(codigo)) {
            buscarEscuelas();
            inicializarEscuela();
        }
    }

    private void limpiarCamposEscuela() {
        vista.txtCodigoEscuela.setText("");
        vista.txtNombreEscuela.setText("");
        vista.cmbFacultadEscuela.setSelectedIndex(-1);
        vista.btnActualizarEscuela.setText("Actualizar");
        vista.btnEliminarEscuela.setText("Eliminar");
    }

    // ========================== CARNET ==========================
    private enum ModoCarnet {
        VISUALIZAR, CREAR, ACTUALIZAR
    }
    private ModoCarnet modoCarnet = ModoCarnet.VISUALIZAR;
    private byte[] imagenCarnet;

    private void inicializarCarnet() {
        limpiarCamposCarnet();
        vista.txtDniCarnet.setEnabled(false);
        vista.txtCodigoCarnet.setEnabled(false);
        vista.txtNombreCarnet.setEnabled(false);
        vista.txtApellidosCarnet.setEnabled(false);
        vista.cmbFacultadCarnet.setEnabled(false);
        vista.cmbEscuelaCarnet.setEnabled(false);
        vista.lblImage.setIcon(null);
        vista.btnActualizarCarnet.setEnabled(false);
        vista.btnEliminarCarnet.setEnabled(false);
        vista.btnActualizarCarnet.setText("Actualizar");
        vista.btnEliminarCarnet.setText("Eliminar");
        imagenCarnet = null;
    }

    public void buscarCarnets() {
        List<CarnetDto> lista = daoCarnet.buscar(vista.txtBuscarCarnet.getText());
        DefaultTableModel modelo = (DefaultTableModel) vista.tblCarnet.getModel();
        modelo.setRowCount(0);

        for (CarnetDto c : lista) {
            EstudianteDto est = c.getEstudiante();
            modelo.addRow(new Object[]{
                est, // columna Dni (Object - muestra con toString)
                est.getCodigo(),
                est.getNombres(),
                c.getFechaExpiracion(),
                est.getEscuelaProfesional().getNombre(),
                est.getEscuelaProfesional().getFacultad().getNombre()
            });
        }

        vista.tblCarnet.clearSelection();
        inicializarCarnet();
    }

    public void seleccionarCarnet() {
        int fila = vista.tblCarnet.getSelectedRow();
        if (fila == -1) {
            return;
        }

        EstudianteDto est = (EstudianteDto) vista.tblCarnet.getValueAt(fila, 0);

        vista.txtDniCarnet.setText(est.getDni());
        vista.txtCodigoCarnet.setText(est.getCodigo());
        vista.txtNombreCarnet.setText(est.getNombres());
        vista.txtApellidosCarnet.setText(est.getApellidos());

        cargarFacultadesYSeleccionar(est.getEscuelaProfesional().getFacultad());
        cargarEscuelasYSeleccionar(est.getEscuelaProfesional());

        imagenCarnet = est.getFoto();
        if (imagenCarnet != null) {
            ImageIcon icon = new ImageIcon(new ImageIcon(imagenCarnet).getImage().getScaledInstance(120, 150, Image.SCALE_SMOOTH));
            vista.lblImage.setIcon(icon);
        }

        vista.btnActualizarCarnet.setEnabled(true);
        vista.btnEliminarCarnet.setEnabled(true);
        modoCarnet = ModoCarnet.VISUALIZAR;
    }

    public void crearCarnet() {
        limpiarCamposCarnet();
        vista.txtDniCarnet.setEnabled(true);
        vista.txtCodigoCarnet.setEnabled(true);
        vista.txtNombreCarnet.setEnabled(true);
        vista.txtApellidosCarnet.setEnabled(true);
        vista.cmbFacultadCarnet.setEnabled(true);
        vista.cmbEscuelaCarnet.setEnabled(true);
        vista.btnActualizarCarnet.setEnabled(true);
        vista.btnActualizarCarnet.setText("Guardar");
        vista.btnEliminarCarnet.setEnabled(true);
        vista.btnEliminarCarnet.setText("Cancelar");
        modoCarnet = ModoCarnet.CREAR;
    }

    public void actualizarCarnet() {
        if (modoCarnet == ModoCarnet.VISUALIZAR) {
            vista.txtNombreCarnet.setEnabled(true);
            vista.txtApellidosCarnet.setEnabled(true);
            vista.cmbFacultadCarnet.setEnabled(true);
            vista.cmbEscuelaCarnet.setEnabled(true);
            vista.dtFecha.setEnabled(true);
            vista.lblImage.setEnabled(true);
            vista.btnActualizarCarnet.setText("Guardar");
            vista.btnEliminarCarnet.setText("Cancelar");
            modoCarnet = ModoCarnet.ACTUALIZAR;
        } else {
            guardarCarnet();  // Ya actualiza si estÃ¡ en modo ACTUALIZAR
        }
    }

    public void guardarCarnet() {
        String dni = vista.txtDniCarnet.getText().trim();
        String codigo = vista.txtCodigoCarnet.getText().trim();
        String nombres = vista.txtNombreCarnet.getText().trim();
        String apellidos = vista.txtApellidosCarnet.getText().trim();
        EscuelaProfesionalDto escuela = (EscuelaProfesionalDto) vista.cmbEscuelaCarnet.getSelectedItem();
        Date fechaExp = vista.dtFecha.getDate(); // JDateChooser

        if (dni.isEmpty() || codigo.isEmpty() || nombres.isEmpty() || apellidos.isEmpty()
                || escuela == null || imagenCarnet == null || fechaExp == null) {
            JOptionPane.showMessageDialog(vista, "Complete todos los campos y seleccione una imagen y fecha.", "ValidaciÃ³n", JOptionPane.WARNING_MESSAGE);
            return;
        }

        EstudianteDto estudiante = new EstudianteDto(dni, codigo, nombres, apellidos, imagenCarnet, escuela, false);
        CarnetDto carnet = new CarnetDto(estudiante, fechaExp, false);

        boolean resultadoEst = false;
        boolean resultadoCarnet = false;

        if (modoCarnet == ModoCarnet.CREAR) {
            resultadoEst = daoEstudiante.crear(estudiante);
            if (resultadoEst) {
                resultadoCarnet = daoCarnet.crear(carnet);
            }
        } else if (modoCarnet == ModoCarnet.ACTUALIZAR) {
            resultadoEst = daoEstudiante.actualizar(estudiante);
            if (resultadoEst) {
                resultadoCarnet = daoCarnet.actualizar(carnet);
            }
        }

        if (resultadoEst && resultadoCarnet) {
            JOptionPane.showMessageDialog(vista, "Carnet guardado correctamente.");
            buscarCarnets();
            inicializarCarnet();
        } else {
            JOptionPane.showMessageDialog(vista, "Error al guardar el carnet.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public void eliminarCarnet() {
        if (vista.btnEliminarCarnet.getText().equals("Cancelar")) {
            buscarCarnets();
            return;
        }

        String dni = vista.txtDniCarnet.getText().trim();
        if (dni.isEmpty()) {
            JOptionPane.showMessageDialog(vista, "Seleccione un carnet a eliminar.", "Aviso", JOptionPane.WARNING_MESSAGE);
            return;
        }

        int confirm = JOptionPane.showConfirmDialog(vista, "Â¿EstÃ¡ seguro de eliminar este carnet?", "Confirmar", JOptionPane.YES_NO_OPTION);
        if (confirm != JOptionPane.YES_OPTION) {
            return;
        }

        boolean eliminadoCarnet = daoCarnet.eliminar(dni);
        boolean eliminadoEstudiante = daoEstudiante.eliminar(dni);

        if (eliminadoCarnet && eliminadoEstudiante) {
            JOptionPane.showMessageDialog(vista, "Carnet eliminado correctamente.");
            buscarCarnets();
            inicializarCarnet();
        } else {
            JOptionPane.showMessageDialog(vista, "Error al eliminar el carnet.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void limpiarCamposCarnet() {
        vista.txtDniCarnet.setText("");
        vista.txtCodigoCarnet.setText("");
        vista.txtNombreCarnet.setText("");
        vista.txtApellidosCarnet.setText("");
        vista.cmbFacultadCarnet.setSelectedIndex(-1);
        vista.cmbEscuelaCarnet.setSelectedIndex(-1);
        vista.lblImage.setIcon(null);
        vista.btnActualizarCarnet.setText("Actualizar");
        vista.btnEliminarCarnet.setText("Eliminar");
        imagenCarnet = null;
    }

    private void cargarFacultadesYSeleccionar(FacultadDto seleccionada) {
        List<FacultadDto> lista = daoFacultad.buscar("");
        vista.cmbFacultadCarnet.removeAllItems();
        for (FacultadDto f : lista) {
            vista.cmbFacultadCarnet.addItem(f);
            if (f.getCodigo().equals(seleccionada.getCodigo())) {
                vista.cmbFacultadCarnet.setSelectedItem(f);
            }
        }
    }

    private void cargarEscuelasYSeleccionar(EscuelaProfesionalDto seleccionada) {
        List<EscuelaProfesionalDto> lista = daoEscuela.buscar("");
        vista.cmbEscuelaCarnet.removeAllItems();
        for (EscuelaProfesionalDto e : lista) {
            vista.cmbEscuelaCarnet.addItem(e);
            if (e.getCodigo().equals(seleccionada.getCodigo())) {
                vista.cmbEscuelaCarnet.setSelectedItem(e);
            }
        }
    }

    public void seleccionarImagenCarnet() {
        JFileChooser fileChooser = new JFileChooser();
        fileChooser.setFileFilter(new javax.swing.filechooser.FileNameExtensionFilter("ImÃ¡genes", "jpg", "jpeg", "png"));
        int resultado = fileChooser.showOpenDialog(vista);
        if (resultado == JFileChooser.APPROVE_OPTION) {
            File archivo = fileChooser.getSelectedFile();
            try {
                imagenCarnet = Files.readAllBytes(archivo.toPath());
                ImageIcon icon = new ImageIcon(new ImageIcon(imagenCarnet).getImage().getScaledInstance(120, 150, Image.SCALE_SMOOTH));
                vista.lblImage.setIcon(icon);
            } catch (IOException ex) {
                JOptionPane.showMessageDialog(vista, "Error al cargar imagen: " + ex.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    public void cargarFacultadesCarnet() {
        List<FacultadDto> lista = daoFacultad.buscar("");
        vista.cmbFacultadCarnet.removeAllItems();
        for (FacultadDto f : lista) {
            vista.cmbFacultadCarnet.addItem(f); // se muestra por toString()
        }
        vista.cmbFacultadCarnet.setSelectedIndex(-1);
    }

    public void cargarEscuelasCarnetPorFacultad() {
        FacultadDto facultadSeleccionada = (FacultadDto) vista.cmbFacultadCarnet.getSelectedItem();
        if (facultadSeleccionada == null) {
            return;
        }

        List<EscuelaProfesionalDto> lista = daoEscuela.buscar("");
        vista.cmbEscuelaCarnet.removeAllItems();

        for (EscuelaProfesionalDto ep : lista) {
            if (ep.getFacultad().getCodigo().equals(facultadSeleccionada.getCodigo())) {
                vista.cmbEscuelaCarnet.addItem(ep);
            }
        }

        vista.cmbEscuelaCarnet.setSelectedIndex(-1);
    }

}
```
