<%@ page import="java.sql.*" %>
<%@ page import="conexion.conectadita" %>

<%
    int idUsuarioEliminar = Integer.parseInt(request.getParameter("idUsuario"));

    Connection connection = null;
try {
    conectadita conecta = new conectadita();
    connection = conecta.getConnection();

    String selectInfanteIdQuery = "SELECT idInfante FROM Usuario WHERE IdUsuario = ?";
    try (PreparedStatement selectInfanteIdStatement = connection.prepareStatement(selectInfanteIdQuery)) {
        selectInfanteIdStatement.setInt(1, idUsuarioEliminar);
        ResultSet resultSet = selectInfanteIdStatement.executeQuery();

        if (resultSet.next()) {
            int idInfanteEliminar = resultSet.getInt("idInfante");

            String deleteUsuarioQuery = "DELETE FROM Usuario WHERE IdUsuario = ?";
            try (PreparedStatement deleteUsuarioStatement = connection.prepareStatement(deleteUsuarioQuery)) {
                deleteUsuarioStatement.setInt(1, idUsuarioEliminar);
                deleteUsuarioStatement.executeUpdate();
            }

            String deleteInfanteQuery = "DELETE FROM Infante WHERE idInfante = ?";
            try (PreparedStatement deleteInfanteStatement = connection.prepareStatement(deleteInfanteQuery)) {
                deleteInfanteStatement.setInt(1, idInfanteEliminar);
                deleteInfanteStatement.executeUpdate();
            }

            connection.commit();

            response.sendRedirect("adminusuarios.jsp");
        }
    } catch (SQLException e) {
        connection.rollback();
        e.printStackTrace();
    } finally {
        connection.setAutoCommit(true);
    }

} catch (SQLException e) {
    // Manejar la excepción según tus necesidades
    e.printStackTrace();
} finally {
    // Cerrar la conexión en el bloque finally para asegurarse de que siempre se cierre
    try {
        if (connection != null) {
            connection.close();
        }
    } catch (SQLException e) {
        // Manejar la excepción según tus necesidades
        e.printStackTrace();
    }
}


%>
