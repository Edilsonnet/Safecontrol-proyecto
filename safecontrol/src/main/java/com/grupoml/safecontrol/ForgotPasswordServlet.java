package com.grupoml.safecontrol;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Base64;

@WebServlet("/forgot")
public class ForgotPasswordServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.getRequestDispatcher("/forgot.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    String email = req.getParameter("email");
    if (email == null || email.isBlank()) {
      req.setAttribute("error", "Ingresa un correo válido.");
      req.getRequestDispatcher("/forgot.jsp").forward(req, resp);
      return;
    }

    try (Connection conn = DatabaseConnection.getConnection()) {
      Integer userId = null;
      try (PreparedStatement st = conn.prepareStatement(
          "SELECT id FROM usuarios WHERE email = ?")) {
        st.setString(1, email.trim());
        try (ResultSet rs = st.executeQuery()) {
          if (rs.next()) userId = rs.getInt("id");
        }
      }

      if (userId != null) {
        String token = generateToken();
        LocalDateTime expires = LocalDateTime.now().plusMinutes(30);
        try (PreparedStatement ins = conn.prepareStatement(
            "INSERT INTO password_reset_tokens (user_id, token, expires_at, used) VALUES (?,?,?,0)")) {
          ins.setInt(1, userId);
          ins.setString(2, token);
          ins.setTimestamp(3, Timestamp.valueOf(expires));
          ins.executeUpdate();
        }
        // Mostrar enlace de demo (en producción se enviaría por email)
        String resetLink = req.getRequestURL().toString().replace("/forgot", "/reset?token=" + token);
        req.setAttribute("resetLink", resetLink);
      }

      req.setAttribute("sent", true);
      req.getRequestDispatcher("/forgot.jsp").forward(req, resp);

    } catch (Exception e) {
      throw new ServletException("Error al generar enlace de recuperación", e);
    }
  }

  private String generateToken() {
    byte[] bytes = new byte[32];
    new SecureRandom().nextBytes(bytes);
    return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
  }
}
