package datos;

import java.sql.*;
import java.util.*;

public class MascotaDAO {
    private final String url = "jdbc:mysql://100.24.67.113:4503/vettrackdb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private final String user = "vetuser";
    private final String password = "admin";

    public MascotaDAO() {
        try {
            // Cargar el driver explícitamente para evitar problemas
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Puedes manejar mejor la excepción o lanzar un runtime exception
        }
    }

    public void registrarMascota(String nombre, String dueno) throws SQLException {
        String sql = "INSERT INTO mascotas (nombre, dueno) VALUES (?, ?)";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nombre);
            stmt.setString(2, dueno);
            stmt.executeUpdate();
        }
    }

    public List<String> listarMascotas() throws SQLException {
        List<String> mascotas = new ArrayList<>();
        String sql = "SELECT nombre, dueno FROM mascotas";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                mascotas.add(rs.getString("nombre") + " - " + rs.getString("dueno"));
            }
        }
        return mascotas;
    }
}

