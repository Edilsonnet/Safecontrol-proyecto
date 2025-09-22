<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Recuperar contraseña - SafeControl</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body{font-family:Arial;background:#1c1c1c;margin:0;height:100vh;display:flex;justify-content:center;align-items:center}
    .panel{width:360px;background:#2a2a2a;color:#eee;border-radius:12px;box-shadow:0 0 15px rgba(0,0,0,.6);padding:26px;text-align:center}
    .desc{color:#cfcfcf;font-size:14px;margin-bottom:16px}
    .input{width:100%;padding:10px 12px;border-radius:6px;border:1px solid #c6a648;background:#1c1c1c;color:#fff;box-sizing:border-box}
    .btn{width:100%;background:#c6a648;color:#1b1b1b;border:none;border-radius:6px;padding:12px;font-weight:bold;cursor:pointer;margin-top:12px}
    .btn:hover{background:#e0b84e}
    .alert{background:#3a2f13;border:1px solid #c6a648;color:#f2e2ad;padding:10px;border-radius:8px;text-align:left}
    .success{background:#19361f;border:1px solid #35c06b;color:#c2f0d5;padding:10px;border-radius:8px;text-align:left}
    a{color:#c6a648;text-decoration:none} a:hover{text-decoration:underline}
  </style>
</head>
<body>
<div class="panel">
  <h2>Recuperar contraseña</h2>
  <p class="desc">Ingresa tu correo registrado. Si existe, te mostraremos un enlace de restablecimiento (demo).</p>

  <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
  <% } %>

  <% Boolean sent = (Boolean) request.getAttribute("sent"); %>
  <% if (sent != null && sent) { %>
    <div class="success"><strong>¡Listo!</strong> Si el correo existe, se generó un enlace.</div>
    <% if (request.getAttribute("resetLink") != null) { %>
      <p class="desc">Enlace (demo): <a href="<%= request.getAttribute("resetLink") %>"><%= request.getAttribute("resetLink") %></a></p>
    <% } %>
    <p><a href="login">← Volver al login</a></p>
  <% } else { %>
    <form method="post" action="forgot" autocomplete="off">
      <input class="input" type="email" name="email" placeholder="Correo electrónico" required>
      <button class="btn" type="submit">Enviar instrucciones</button>
    </form>
    <p><a href="login">← Volver al login</a></p>
  <% } %>
</div>
</body>
</html>