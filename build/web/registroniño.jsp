<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.*,conexion.conectadita" %>
        <%@ page import="java.sql.*,java.io.*,java.util.*" %>

        <%
            String fechaDiagnostico = request.getParameter("fechaDiagnostico");
            String condicionesMedicas = request.getParameter("condicionesMedicas");
            String tratamientosMedicos = request.getParameter("tratamientosMedicos");
            String[] alergias = request.getParameterValues("alergias");
            String otraAlergia = request.getParameter("otraAlergia");
            String registroVisitas = request.getParameter("registroVisitas");
             String[] medicamentos = request.getParameterValues("medi");

            Connection con = null;
            PreparedStatement pstDiagnostico = null;
            PreparedStatement pstGetLastInfanteId = null;
            ResultSet rsLastInfanteId = null;
            ResultSet generatedKeys = null;

            try {
                conectadita conecta = new conectadita();
                con = conecta.getConnection();

                // Insertar en la tabla Diagnostico
                String queryAntecedentes = "INSERT INTO Diagnostico (fechaDiagnostico, condicionesMedicas, tratamientosMedicos, alergias, registroVisitas, listaMedicamentos) VALUES (?, ?, ?, ?, ?, ?)";
                pstDiagnostico = con.prepareStatement(queryAntecedentes, Statement.RETURN_GENERATED_KEYS);

                pstDiagnostico.setString(1, fechaDiagnostico);
                pstDiagnostico.setString(2, condicionesMedicas);
                pstDiagnostico.setString(3, tratamientosMedicos);
                String listaAlergias = String.join(",", alergias);
                pstDiagnostico.setString(4, listaAlergias);
                pstDiagnostico.setString(5, registroVisitas);
                String listaMedicamentosStr = String.join(",", medicamentos);
                pstDiagnostico.setString(6, listaMedicamentosStr);

                int rowsAffectedDiagnostico = pstDiagnostico.executeUpdate();

                if (rowsAffectedDiagnostico > 0) {
                    generatedKeys = pstDiagnostico.getGeneratedKeys();

                    if (generatedKeys.next()) {
                        int idAntecedentes = generatedKeys.getInt(1);

                        // Obtener el último ID de Infante
                        String queryLastInfanteId = "SELECT MAX(idInfante) AS lastId FROM Infante";
                        pstGetLastInfanteId = con.prepareStatement(queryLastInfanteId);
                        rsLastInfanteId = pstGetLastInfanteId.executeQuery();

                        int lastInfanteId = 0;

                        if (rsLastInfanteId.next()) {
                            lastInfanteId = rsLastInfanteId.getInt("lastId");
                        }

                        String queryActualizarInfante = "UPDATE Infante SET idAntecedentes = ? WHERE idInfante = ?";
                        pstDiagnostico = con.prepareStatement(queryActualizarInfante);

                        pstDiagnostico.setInt(1, idAntecedentes);
                        pstDiagnostico.setInt(2, lastInfanteId);

                        int rowsAffectedActualizarInfante = pstDiagnostico.executeUpdate();

                        if (rowsAffectedActualizarInfante > 0) {
                           request.setAttribute("registroExitoso", "true");
                           RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
                           dispatcher.forward(request, response);
                       } else {
                           out.println("<p>Error al intentar actualizar la información en la tabla de Infante.</p>");
                       }
                    }
                } else {
                    out.println("<p>Error al intentar guardar la información en la tabla de Diagnostico.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (pstDiagnostico != null) {
                        pstDiagnostico.close();
                    }
                    if (pstGetLastInfanteId != null) {
                        pstGetLastInfanteId.close();
                    }
                    if (rsLastInfanteId != null) {
                        rsLastInfanteId.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                    if (generatedKeys != null) {
                        generatedKeys.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </body>
</html>
