<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - SafeControl</title>
    <!-- FontAwesome para los íconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1c1c1c;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #2a2a2a;
            padding: 30px;
            border-radius: 12px;
            width: 340px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.6);
            text-align: center;
        }
        .login-container h2 {
            color: white;
            margin-bottom: 20px;
        }
        .input-group {
            position: relative;
            margin: 15px 0;
        }
        .input-group i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #c6a648;
            font-size: 16px;
        }
        .input-group input {
            width: 100%;
            padding: 10px 10px 10px 35px; /* espacio para el ícono */
            border-radius: 6px;
            border: 1px solid #c6a648;
            background-color: #1c1c1c;
            color: white;
            box-sizing: border-box;
        }
        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0 20px 0;
            font-size: 14px;
        }
        .options label {
            color: white;
        }
        .options a {
            color: #c6a648;
            text-decoration: none;
        }
        .options a:hover {
            text-decoration: underline;
        }
        .btn {
            background-color: #c6a648;
            border: none;
            padding: 12px;
            border-radius: 6px;
            width: 100%;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn:hover {
            background-color: #e0b84e;
        }
        .logo {
            margin-top: 20px;
            color: #c6a648;
            font-weight: bold;
            font-size: 18px;
        }
        /* mensaje de error */
        .error {
            color: red;
            margin-bottom: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>LOGIN</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="post">
            <div class="input-group">
                <i class="fa fa-user"></i>
                <input type="text" id="username" name="username"
                       placeholder="Usuario"
                       value="<%= (request.getAttribute("lastUsername") != null) ? (String) request.getAttribute("lastUsername") : "" %>"
                       required>
            </div>
            <div class="input-group">
                <i class="fa fa-lock"></i>
                <input type="password" id="password" name="password" placeholder="Contraseña" required>
            </div>

            <div class="options">
                <label><input type="checkbox" name="remember"> Recordarme</label>
                <a href="forgot">¿Olvidaste tu contraseña?</a>
            </div>

            <button type="submit" class="btn">INICIAR SESIÓN</button>
        </form>

        <div class="logo">
            MG GRUPO SECURITY
        </div>
    </div>
</body>
</html>