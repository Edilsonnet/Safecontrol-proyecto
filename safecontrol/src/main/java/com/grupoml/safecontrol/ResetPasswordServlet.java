package com.grupoml.safecontrol;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;

@WebServlet("/reset")
public class ResetPasswordServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    String token = req.getParameter("token");
    if (token == null || token.isBlank()) {
      req.setAttribute("error", "Token inválido.");
      req.getRequestDispatcher("/reset.jsp").forward(req, resp);
      return;
    }
    try (Connection conn = DatabaseConnection.getConnection()) {
      Integer userId = validateToken(conn, token);
      if (userId == null) {
        req.setAttribute("error", "El enlace no es válido o ha expirado.");
      } else {
        req.setAttribute("token", token);
      }
      req.getRequestDispatcher("/reset.jsp").forward(req, resp);
    } catch (Exception e) {
      throw new ServletException("Error al validar token", e);
    }
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    String token = req.getParameter("token");
    String newPass = req.getParameter("password");

    if (token == null || token.isBlank() || newPass == null || newPass.isBlank()) {
      req.setAttribute("error", "Datos incompletos.");
      req.setAttribute("token", token);
      req.getRequestDispatcher("/reset.jsp").forward(req, resp);
      return;
    }

    try (Connection conn = DatabaseConnection.getConnection()) {
      Integer userId = validateToken(conn, token);
      if (userId == null) {
        req.setAttribute("error", "El enlace no es válido o ha expirado.");
        req.getRequestDispatcher("/reset.jsp").forward(req, resp);
        return;
      }

      try (PreparedStatement up = conn.prepareStatement(
          "UPDATE usuarios SET password = ? WHERE id = ?")) {
        up.setString(1, newPass); // Nota: para demo en texto plano
        up.setInt(2, userId);
        up.executeUpdate();
      }

      try (PreparedStatement up = conn.prepareStatement(
          "UPDATE password_reset_tokens SET used = 1 WHERE token = ?")) {
        up.setString(1, token);
        up.executeUpdate();
      }

      // Volver al login con mensaje informativo
      req.setAttribute("error", null);
      req.setAttribute("lastUsername", null);
      req.setAttribute("info", "Tu contraseña ha sido actualizada. Inicia sesión.");
      req.getRequestDispatcher("/login.jsp").forward(req, resp);

    } catch (Exception e) {
      throw new ServletException("No se pudo actualizar la contraseña", e);
    }
  }

  private Integer validateToken(Connection conn, String token) throws Exception {
    try (PreparedStatement st = conn.prepareStatement(
        "SELECT user_id, expires_at, used FROM password_reset_tokens WHERE token = ?")) {
      st.setString(1, token);
      try (ResultSet rs = st.executeQuery()) {
        if (!rs.next()) return null;
        int used = rs.getInt("used");
        Timestamp exp = rs.getTimestamp("expires_at");
        if (used == 1) return null;
        if (exp == null || exp.toLocalDateTime().isBefore(LocalDateTime.now())) return null;
        return rs.getInt("user_id");
      }
    }
  }
}
