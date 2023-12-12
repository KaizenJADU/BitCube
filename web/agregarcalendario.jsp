<%@ page contentType="application/json; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,conexion.conectadita, org.json.JSONObject" %>
<%
   HttpSession sesion = request.getSession();
        String usuario;
        String idTipo;
        String contra;

        if(sesion.getAttribute("user") != null && sesion.getAttribute("idTipo") != null){
            usuario = sesion.getAttribute("user").toString();
            idTipo = sesion.getAttribute("idTipo").toString();
            Connection conec = null;
            PreparedStatement pstat = null;
            ResultSet results = null;
            conectadita conecta = new conectadita();
            conec = conecta.getConnection();

            try {
                String query = "SELECT * FROM Usuario WHERE correoUsuario=?";
                pstat = conec.prepareStatement(query);
                pstat.setString(1, usuario); 

                results = pstat.executeQuery();

            if (results.next()) {
                int idUsuario = results.getInt("IdUsuario");
                String fecha = request.getParameter("fecha");
                String actividad = request.getParameter("actividad");

                try {
                    pstat.close(); 
                    results.close(); 

                    
                    String sql = "INSERT INTO Calendario (idUsuario, fechaCal, actividad) VALUES (?, ?, ?)";
                    pstat = conec.prepareStatement(sql);
                    pstat.setInt(1, idUsuario);
                    pstat.setDate(2, java.sql.Date.valueOf(fecha));
                    pstat.setString(3, actividad);

                    pstat.executeUpdate();

                    
                    JSONObject respuestaJson = new JSONObject();
                    respuestaJson.put("success", true);
                    out.println(respuestaJson.toString());
                    response.sendRedirect("Calendario.jsp");

                } catch (SQLException error) {
                    
                    JSONObject respuestaJson = new JSONObject();
                    respuestaJson.put("success", false);
                    respuestaJson.put("error", error.toString());
                    out.println(respuestaJson.toString());
            response.sendRedirect("Calendario.jsp");
                } finally {
                    if (pstat != null) {
                        pstat.close();
                    }
                }
            }

        } catch (SQLException error) {
            
            JSONObject respuestaJson = new JSONObject();
            respuestaJson.put("success", false);
            respuestaJson.put("error", error.toString());
            out.println(respuestaJson.toString());
            response.sendRedirect("Calendario.jsp");
        } finally {
            if (conec != null) {
                try {
                    conec.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    } else {
        JSONObject respuestaJson = new JSONObject();
        respuestaJson.put("success", false);
        respuestaJson.put("error", "Sesión no válida");
        out.println(respuestaJson.toString());
         response.sendRedirect("Calendario.jsp");
    }
%>
