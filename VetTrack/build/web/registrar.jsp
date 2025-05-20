<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="logica.GestorMascotas" %>
<%
    String mensaje = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String dueno = request.getParameter("dueno");

        if (nombre != null && dueno != null && !nombre.isEmpty() && !dueno.isEmpty()) {
            GestorMascotas gestor = new GestorMascotas();
            try {
                gestor.registrar(nombre, dueno);
                mensaje = "Mascota registrada con éxito.";
            } catch (Exception e) {
                mensaje = "Error al registrar: " + e.getMessage();
            }
        } else {
            mensaje = "Completa todos los campos.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Registrar Mascota</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h1 class="text-center mb-4">Registrar Mascota</h1>
        <div class="card p-4 mx-auto" style="max-width: 500px;">
            <form method="post">
                <div class="mb-3">
                    <label class="form-label">Nombre de la Mascota:</label>
                    <input type="text" name="nombre" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Nombre del Dueño:</label>
                    <input type="text" name="dueno" class="form-control" required>
                </div>
                <input type="submit" value="Registrar" class="btn btn-primary w-100">
            </form>
            <% if (!mensaje.isEmpty()) { %>
                <div class="alert alert-info mt-3 text-center"><%= mensaje %></div>
            <% } %>
            <a href="index.jsp" class="btn btn-secondary mt-3 w-100">Volver al Inicio</a>
        </div>
    </div>
</body>
</html>
