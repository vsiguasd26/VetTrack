package logica;

import datos.MascotaDAO;
import java.sql.SQLException;
import java.util.List;

public class GestorMascotas {
    private final MascotaDAO dao = new MascotaDAO();

    public void registrar(String nombre, String dueno) throws SQLException {
        dao.registrarMascota(nombre, dueno);
    }

    public List<String> obtenerTodas() throws SQLException {
        return dao.listarMascotas();
    }
}
