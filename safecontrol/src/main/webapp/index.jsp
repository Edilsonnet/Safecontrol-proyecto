<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Si ya hay sesión activa → manda directo a welcome.jsp
    if (session != null && session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/welcome.jsp");
        return;
    } else {
        // Si no hay sesión, redirige al login servlet
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

