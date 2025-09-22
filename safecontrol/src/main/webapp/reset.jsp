<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Restablecer contraseña - SafeControl</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body{font-family:Arial;background:#1c1c1c;margin:0;height:100vh;display:flex;justify-content:center;align-items:center}
    .panel{width:360px;background:#2a2a2a;color:#eee;border-radius:12px;box-shadow:0 0 15px rgba(0,0,0,.6);padding:26px;text-align:center}
    .input{width:100%;padding:10px 12px;border-radius:6px;border:1px solid #c6a648;background:#1c1c1c;color:#fff;box-sizing:border-box}
    .btn{width:100%;background:#c6a648;color:#1b1b1b;border:none;border-radius:6px;padding:12px;font-weight:bold;cursor:pointer;margin-top:12px}
    .btn:hover{background:#e0b84e}
    .alert{background:#3a2f13;border:1px solid #c6a648;color:#f2e2ad;padding:10px;border-radius:8px;text-align:left}
    a{color:#c6a648;text-decoration:none} a:hover{text-decoration:underline}
  </style>
</head>
<body>
<div class="panel">
  <h2>Restablecer contraseña</h2>

  <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
  <% } %>

  <% String token = (String) request.getAttribute("token"); %>
  <% if (token == null) { %>
    <p>El enlace no es válido o ha expirado.</p>
    <p><a href="forgot">Solicitar un nuevo enlace</a></p>
  <% } else { %>
    <form method="post" action="reset" autocomplete="off">
      <input type="hidden" name="token" value="<%= token %>">
      <input class="input" type="password" name="password" placeholder="Nueva contraseña" required>
      <button class="btn" type="submit">Guardar contraseña</button>
    </form>
  <% } %>
</div>
</body>
</html>