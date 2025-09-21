package com.grupoml.safecontrol;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/safe_control?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "Tania2018.";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Configuración de Auth0
    public static class Auth0Config {
        public static final String DOMAIN = "dev-8cq6qf84xya83ihu.us.auth0.com"; 
        public static final String CLIENT_ID = "9pPArIAgRO0VQTtsfNjBYsIQqs0WcXqG"; 
        public static final String CLIENT_SECRET = "W0OFnPqdXHOP8Or9zkj0ds4KT0KgGBY0QSGk94fxviuxgkixn3mrZocqh27wbGz0"; 
        public static final String CALLBACK_URL = "http://localhost:8081/safecontrol/callback"; 
    }
}



