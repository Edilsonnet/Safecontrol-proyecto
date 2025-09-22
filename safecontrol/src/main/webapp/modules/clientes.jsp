<%@ page contentType="text/html; charset=UTF-8" %>
<%
  // Requiere sesión activa
  String user = (String) session.getAttribute("user");
  if (user == null) { response.sendRedirect(request.getContextPath()+"/login"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <title>Módulo — Clientes</title>
  <!-- Usa tu CSS global -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
  <div class="wrap">
    <div class="card">
      <div class="toolbar">
        <input id="cl_buscar" type="text" class="search" placeholder="Buscar nombre/identificación/correo…">
        <button class="btn"        onclick="buscarCliente()">Buscar</button>
        <button class="btn"        onclick="abrirCliente()">Nuevo</button>
        <button class="btn gray"   onclick="alert('PDF (demo)')">Generar PDF</button>
        <button class="btn gray"   onclick="alert('Reporte (demo)')">Generar Reporte</button>
      </div>

      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Nombre</th>
            <th>Identificación</th>
            <th>Correo</th>
            <th>Estado</th>
            <th>F. Creación</th>
            <th>F. Expiración</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody id="cl_rows">
          <!-- Fila demo -->
          <tr>
            <td>1</td>
            <td>Cliente Demo</td>
            <td>0801-1990-00000</td>
            <td>demo@correo.com</td>
            <td>Activo</td>
            <td>2025-09-01</td>
            <td>—</td>
            <td class="actions">
              <button class="btn"      onclick="abrirCliente(1)">✏️</button>
              <button class="btn gray" onclick="eliminarCliente(1)">🗑</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Modal Cliente (blanca, campos como en tu captura) -->
  <div class="modal" id="cl_modal">
    <div class="modal-card">
      <h3 style="margin:0 0 10px">REGISTRO CLIENTE</h3>

      <div class="grid">
        <div class="fld">
          <label for="cl_nombre">Nombre Completo:</label>
          <input id="cl_nombre" type="text" placeholder="Nombre del cliente">
        </div>

        <div class="fld">
          <label for="cl_identidad">Número de Identificación:</label>
          <input id="cl_identidad" type="text" placeholder="Ej. 0801-0000-00000">
        </div>

        <div class="fld">
          <label for="cl_correo">Correo Electrónico:</label>
          <input id="cl_correo" type="email" placeholder="correo@dominio.com">
        </div>

        <div class="fld">
          <label for="cl_estado">Estado:</label>
          <select id="cl_estado">
            <option>Activo</option>
            <option>Inactivo</option>
            <option>Bloqueado</option>
          </select>
        </div>

        <div class="fld">
          <label for="cl_dir">Dirección:</label>
          <input id="cl_dir" type="text" placeholder="Barrio, colonia, ciudad…">
        </div>

        <div class="grid grid-2">
          <div class="fld">
            <label for="cl_fcrea">Fecha de Creación:</label>
            <input id="cl_fcrea" type="date">
          </div>
          <div class="fld">
            <label for="cl_fexp">Fecha de Expiración:</label>
            <input id="cl_fexp" type="date">
          </div>
        </div>
      </div>

      <div class="modal-foot">
        <button class="btn gray" onclick="limpiarCliente()">Limpiar</button>
        <button class="btn"      onclick="guardarCliente()">Guardar</button>
        <button class="btn gray" onclick="cerrarCliente()">Cerrar</button>
      </div>
    </div>
  </div>

  <script>
    // ====== Modal ======
    const CL_MODAL = document.getElementById('cl_modal');

    function abrirCliente(id){
      // si viene id podrías precargar datos (demo)
      CL_MODAL.classList.add('open');
    }
    function cerrarCliente(){ CL_MODAL.classList.remove('open'); }

    // ====== Acciones ======
    function limpiarCliente(){
      ['cl_nombre','cl_identidad','cl_correo','cl_dir','cl_fcrea','cl_fexp']
        .forEach(id => { const el = document.getElementById(id); if (el) el.value = ''; });
      document.getElementById('cl_estado').value = 'Activo';
    }

    function guardarCliente(){
      const data = {
        nombre:     document.getElementById('cl_nombre').value,
        identidad:  document.getElementById('cl_identidad').value,
        correo:     document.getElementById('cl_correo').value,
        estado:     document.getElementById('cl_estado').value,
        direccion:  document.getElementById('cl_dir').value,
        fcrea:      document.getElementById('cl_fcrea').value,
        fexp:       document.getElementById('cl_fexp').value
      };
      console.log('Guardar cliente (demo):', data);
      alert('Guardar cliente (demo). Revisa la consola del navegador.');
      cerrarCliente();
    }

    function eliminarCliente(id){
      if (confirm('¿Eliminar cliente ' + id + '?')) {
        alert('Eliminado (demo)');
      }
    }

    function buscarCliente(){
      alert('Buscar: ' + (document.getElementById('cl_buscar').value || '(vacío)'));
    }
  </script>
</body>
</html>