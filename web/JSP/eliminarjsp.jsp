<%@page import="java.sql.*,conexion.conectadita"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*"%>

<%
    String pictogramaId = request.getParameter("pictogramaId");

    Connection connection = null;
    try {
        conectadita conecta = new conectadita();
        connection = conecta.getConnection();

        String deleteQuery = "DELETE FROM ImagenPictograma WHERE idImagen = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
        preparedStatement.setInt(1, Integer.parseInt(pictogramaId));
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Pictograma eliminado exitosamente.");
        } else {
            out.println("Error al eliminar el pictograma.");
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    response.sendRedirect(request.getHeader("referer"));
%>
