package presentacion;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import logica.GestorMascotas;

public class MascotaServlet extends HttpServlet {
    private final GestorMascotas gestor = new GestorMascotas();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nombre = request.getParameter("nombre");
        String dueno = request.getParameter("dueno");
        try {
            gestor.registrar(nombre, dueno);
            response.getWriter().write("Mascota registrada con éxito");
        } catch (IOException | SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            List<String> mascotas = gestor.obtenerTodas();
            response.setContentType("application/json");
            response.getWriter().write(new com.google.gson.Gson().toJson(mascotas));
        } catch (IOException | SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
