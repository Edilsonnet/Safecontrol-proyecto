<%@ page contentType="text/html; charset=UTF-8" %>
<%
  // Proteger el módulo: requiere sesión iniciada
  String user = (String) session.getAttribute("user");
  if (user == null) { response.sendRedirect(request.getContextPath()+"/login"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Gestión de Usuarios</title>
  <!-- CSS global -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
  <div class="wrap">
    <div class="title">Gestión de Usuarios</div>

    <div class="card">
      <!-- Toolbar -->
      <div class="toolbar">
        <input id="q" class="search" type="text" placeholder="Buscar nombre/usuario/estado…">
        <button class="btn btn--brand" onclick="buscarUsuario()">Buscar</button>
        <button class="btn btn--ok" onclick="abrirModalUsuario()">Nuevo</button>
        <button class="btn btn--ghost" onclick="alert('PDF (demo)')">Generar PDF</button>
        <button class="btn btn--ghost" onclick="alert('Reporte (demo)')">Generar Reporte</button>
      </div>

      <!-- Tabla -->
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Nombre</th>
            <th>Usuario</th>
            <th>Correo</th>
            <th>Estado</th>
            <th>Rol Usuario</th>
            <th>F. Creación</th>
            <th>F. Vencimiento</th>
            <th>Acciones</th>
          </tr>
        </thead>
        <tbody id="rows">
          <!-- Fila demo para que se vea algo -->
          <tr>
            <td>1</td>
            <td>Admin</td>
            <td>admin</td>
            <td>admin@mgsecurity.com</td>
            <td>Activo</td>
            <td>Administrador</td>
            <td>2025-09-01</td>
            <td>—</td>
            <td class="actions">
              <button class="btn btn--brand" onclick="abrirModalUsuario(1)">✏️</button>
              <button class="btn btn--ghost" onclick="eliminarUsuario(1)">🗑</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Modal Usuario -->
  <div class="modal" id="userModal">
    <div class="modal-card">
      <div class="modal-hd">
        <h3 style="margin:0">REGISTRO USUARIO</h3>
        <button class="close" onclick="cerrarModalUsuario()">×</button>
      </div>

      <div class="modal-bd">
        <div class="grid">
          <div>
            <label for="u_nombre">Nombre Completo</label>
            <input id="u_nombre" type="text" placeholder="Nombre y apellido">
          </div>

          <div class="grid grid-2">
            <div>
              <label for="u_user">Nombre de Usuario</label>
              <input id="u_user" type="text" placeholder="usuario">
            </div>
            <div>
              <label for="u_pass">Contraseña</label>
              <input id="u_pass" type="password" placeholder="••••••••">
            </div>
          </div>

          <div class="grid grid-2">
            <div>
              <label for="u_correo">Correo</label>
              <input id="u_correo" type="email" placeholder="correo@dominio.com">
            </div>
            <div>
              <label for="u_estado">Estado</label>
              <select id="u_estado">
                <option>Activo</option>
                <option>Inactivo</option>
                <option>Bloqueado</option>
              </select>
            </div>
          </div>

          <div>
            <label for="u_rol">Rol del Usuario</label>
            <select id="u_rol">
              <option>Administrador</option>
              <option>Supervisor</option>
              <option>Guardia</option>
            </select>
          </div>

          <div class="grid grid-2">
            <div>
              <label for="u_fcrea">F. Creación</label>
              <input id="u_fcrea" type="date">
            </div>
            <div>
              <label for="u_fvence">F. Vencimiento</label>
              <input id="u_fvence" type="date">
            </div>
          </div>
        </div>
      </div>

      <div class="modal-ft">
        <button class="btn btn--ghost" onclick="limpiarUsuario()">Limpiar</button>
        <button class="btn btn--ok" onclick="guardarUsuario()">Guardar</button>
        <button class="btn btn--ghost" onclick="cerrarModalUsuario()">Cerrar</button>
      </div>
    </div>
  </div>

  <script>
    // ---------------- Modal ----------------
    const MODAL = document.getElementById('userModal');

    function abrirModalUsuario(id){
      // si llega id, aquí podrías cargar datos para editar
      MODAL.classList.add('open');
    }
    function cerrarModalUsuario(){ MODAL.classList.remove('open'); }

    // ---------------- Acciones demo ----------------
    function limpiarUsuario(){
      ['u_nombre','u_user','u_pass','u_correo','u_fcrea','u_fvence']
        .forEach(id => { const el = document.getElementById(id); if(el) el.value=''; });
      document.getElementById('u_estado').value = 'Activo';
      document.getElementById('u_rol').value    = 'Administrador';
    }

    function guardarUsuario(){
      const data = {
        nombre:  document.getElementById('u_nombre').value,
        usuario: document.getElementById('u_user').value,
        pass:    document.getElementById('u_pass').value,
        correo:  document.getElementById('u_correo').value,
        estado:  document.getElementById('u_estado').value,
        rol:     document.getElementById('u_rol').value,
        fcrea:   document.getElementById('u_fcrea').value,
        fvence:  document.getElementById('u_fvence').value
      };
      console.log('Guardar (demo):', data);
      alert('Guardar (demo). Ver consola.');
      cerrarModalUsuario();
    }

    function eliminarUsuario(id){
      if(confirm('¿Eliminar usuario '+id+'?')){
        alert('Eliminado (demo)');
      }
    }

    function buscarUsuario(){
      alert('Buscar (demo): ' + document.getElementById('q').value);
    }
  </script>
</body>
</html>