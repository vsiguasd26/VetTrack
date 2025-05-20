<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="logica.GestorMascotas" %>
<%@ page import="java.util.List" %>
<%
    GestorMascotas gestor = new GestorMascotas();
    List<String> mascotas = null;
    String error = "";
    try {
        mascotas = gestor.obtenerTodas();
    } catch (Exception e) {
        error = "Error al obtener mascotas: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Mascotas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h1 class="text-center mb-4">Lista de Mascotas</h1>
        <% if (!error.isEmpty()) { %>
            <div class="alert alert-danger text-center"><%= error %></div>
        <% } else if (mascotas != null && !mascotas.isEmpty()) { %>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr><th>Nombre</th><th>Dueño</th></tr>
                </thead>
                <tbody>
                <% for (String m : mascotas) {
                    String[] partes = m.split(" - ");
                %>
                    <tr>
                        <td><%= partes[0] %></td>
                        <td><%= partes[1] %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="alert alert-warning text-center">No hay mascotas registradas.</div>
        <% } %>
        <div class="text-center mt-3">
            <a href="index.jsp" class="btn btn-secondary">Volver al Inicio</a>
        </div>
    </div>
</body>
</html>
