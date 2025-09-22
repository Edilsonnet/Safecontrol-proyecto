<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Requiere sesión
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8" />
<title>SafeControl — Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<header>
  <div class="brand">🟡 <span>SafeControl</span></div>
  <div>Dashboard · Bienvenido, <strong><%= user %></strong></div>
  <form action="<%= request.getContextPath() %>/logout" method="post" style="margin:0">
    <button class="logout">Cerrar sesión</button>
  </form>
</header>

<div class="layout">
  <!-- Menú lateral -->
  <aside>
    <div class="m-title">MÓDULOS</div>
    <nav id="menu" class="menu">
      <!-- Usa SOLO el nombre del archivo. El script agrega /modules/ -->
      <a href="#" data-url="usuarios.jsp" class="active">Gestión de Usuarios</a>
      <a href="#" data-url="clientes.jsp">Gestión de Clientes</a>
      <a href="#" data-url="empleados.jsp">Gestión de Empleados</a>
      <a href="#" data-url="turnos.jsp">Gestión de Turnos</a>
      <a href="#" data-url="asignaciones.jsp">Gestión de Asignaciones</a>
      <a href="#" data-url="asistencia.jsp">Gestión de Asistencia</a>
      <a href="#" data-url="incidentes.jsp">Gestión de Incidentes</a>
      <a href="#" data-url="facturacion.jsp">Gestión de Facturación</a>
      <a href="#" data-url="bitacora.jsp">Gestión de Bitácora</a>
      <a href="#" data-url="mantenimiento.jsp">Gestión de Mantenimiento</a>
      <a href="#" data-url="auditorias.jsp">Gestión de Auditorías</a>
      <a href="#" data-url="permisos.jsp">Gestión de Permisos</a>
    </nav>
  </aside>

  <!-- Panel principal -->
  <main>
    <div class="panel">
      <h2>Selecciona un módulo para cargar su formulario.</h2>
      <div id="loader">Cargando…</div>
      <iframe id="panelFrame" title="Panel"></iframe>
    </div>
  </main>
</div>

<script>
(function(){
  const ctx    = '<%= request.getContextPath() %>';
  const menu   = document.getElementById('menu');
  const frame  = document.getElementById('panelFrame');
  const loader = document.getElementById('loader');

  function loadModule(page){
    loader.style.display = 'block';
    // prefijo /modules/ agregado UNA SOLA VEZ, más bust de caché
    frame.src = ctx + '/modules/' + page + '?v=' + Date.now();
  }

  frame.addEventListener('load', () => loader.style.display = 'none');

  // Manejo de clicks del menú (delegado)
  menu.addEventListener('click', (e) => {
    const a = e.target.closest('a[data-url]');
    if (!a) return;
    e.preventDefault();
    menu.querySelectorAll('a').forEach(x => x.classList.remove('active'));
    a.classList.add('active');
    loadModule(a.dataset.url); // solo el nombre del .jsp
  });

  // Autocargar el primer módulo (Usuarios)
  const first = menu.querySelector('a[data-url]');
  if (first) {
    first.classList.add('active');
    loadModule(first.dataset.url);
  }
})();
</script>

</body>
</html>