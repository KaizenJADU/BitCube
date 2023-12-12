<%@ page import="java.sql.*,conexion.conectadita" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Connection connection = null;
    try {
        conectadita conecta = new conectadita();
        connection = conecta.getConnection();

        if (request.getParameter("registrar") != null) {
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String nombreUsuario = request.getParameter("nombre");
            String apePatUsuario = request.getParameter("ap_paterno");
            String apeMatUsuario = request.getParameter("ap_materno");
            String correoUsuario = request.getParameter("email");
             String telUsuario = request.getParameter("phone");
            String contrasena = request.getParameter("pass");
            String RFC = request.getParameter("rfc");
            int codigo = Integer.parseInt(request.getParameter("cod"));

            String nombreInfante = request.getParameter("nameni");
            int edadInfante = Integer.parseInt(request.getParameter("edad"));
            String apePatInfante = request.getParameter("ap_pater_ni");
            String apeMatInfante = request.getParameter("ap_mater_ni");
            String sexo = request.getParameter("sexo");

            String updateQuery = "UPDATE Usuario SET nombreUsuario=?, apePatUsuario=?, apeMatUsuario=?,"
                    + " correoUsuario=?, telUsuario=?, contrasena=?, RFC=?, codigo=? WHERE IdUsuario=?";
            PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
            updateStatement.setString(1, nombreUsuario);
            updateStatement.setString(2, apePatUsuario);
            updateStatement.setString(3, apeMatUsuario);
            updateStatement.setString(4, correoUsuario);
            updateStatement.setString(5, telUsuario);
            updateStatement.setString(6, contrasena);
            updateStatement.setString(7, RFC);
            updateStatement.setInt(8, codigo);
            updateStatement.setInt(9, idUsuario);
            updateStatement.executeUpdate();

            boolean hasInfante = request.getParameter("nameni") != null && !request.getParameter("nameni").isEmpty();
            if (hasInfante) {
                String updateInfanteQuery = "UPDATE Infante SET nombreInfante=?, edadInfante=?, apePatInfante=?, apeMatInfante=?, sexo=? WHERE idInfante=(SELECT idInfante FROM Usuario WHERE IdUsuario=?)";
                PreparedStatement updateInfanteStatement = connection.prepareStatement(updateInfanteQuery);
                updateInfanteStatement.setString(1, nombreInfante);
                updateInfanteStatement.setInt(2, edadInfante);
                updateInfanteStatement.setString(3, apePatInfante);
                updateInfanteStatement.setString(4, apeMatInfante);
                updateInfanteStatement.setString(5, sexo);
                updateInfanteStatement.setInt(6, idUsuario);
                updateInfanteStatement.executeUpdate();
            }

            response.sendRedirect("adminusuarios.jsp"); 
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
%>
