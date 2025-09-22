package com.grupoml.safecontrol;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // GET: muestra la página de login (login.jsp)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // POST: procesa usuario/contraseña contra la BD
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT 1 FROM usuarios WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // ✅ Credenciales válidas → crear sesión y redirigir al dashboard
                        HttpSession session = request.getSession(true);
                        session.setAttribute("user", username);
                        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                        return;
                    }
                }
            }

            // ❌ Credenciales inválidas → volver al formulario con mensaje y último usuario
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.setAttribute("lastUsername", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        } catch (Exception e) {
            // ⚠️ Error en conexión/consulta → devolver 500 con causa
            throw new ServletException("Error en el inicio de sesión", e);
        }
    }
}