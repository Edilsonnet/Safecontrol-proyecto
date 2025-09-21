<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Recuperar usuario de la sesión
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Bienvenido - SafeControl</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1a1a1a;
            color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #2c2c2c;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.6);
            text-align: center;
            width: 400px;
        }
        h2 {
            color: #d4af37; /* dorado */
            margin-bottom: 15px;
        }
        p {
            margin-bottom: 25px;
        }
        .logout-btn {
            background-color: #d4af37;
            border: none;
            padding: 12px 24px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }
        .logout-btn:hover {
            background-color: #b8962e;
        }
        .logo {
            margin-top: 20px;
            font-size: 18px;
            color: #d4af37;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>🎉 Bienvenido, <%= user %> 🎉</h2>
    <p>Has iniciado sesión correctamente en <b>SafeControl</b>.</p>

    <form action="logout" method="post">
        <button type="submit" class="logout-btn">Cerrar sesión</button>
    </form>

    <div class="logo">
        MG GRUPO SECURITY
    </div>
</div>
</body>
</html>