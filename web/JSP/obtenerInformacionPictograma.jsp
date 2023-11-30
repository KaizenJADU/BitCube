<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*,conexion.conectadita,java.util.Base64"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.InputStream"%>


<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    int idImagen = Integer.parseInt(request.getParameter("idImagen"));
    Connection connection = null;

    try {
        conectadita conecta = new conectadita();
        connection = conecta.getConnection();

        String query = "SELECT * FROM ImagenPictograma";
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query);

                  while (resultSet.next()) {
                Blob blob = resultSet.getBlob("imagen");
                Blob blob2 = resultSet.getBlob("audio");
                String significado = resultSet.getString("significado");
                InputStream inputStream = blob2.getBinaryStream();

                byte[] bytes = blob.getBytes(1, (int) blob.length());
                String base64Image = Base64.getEncoder().encodeToString(bytes);
                
                byte[] audioBytes = new byte[(int) blob2.length()];
                inputStream.read(audioBytes);
                inputStream.close();
                
                String base64EncodedAudio = Base64.getEncoder().encodeToString(audioBytes);

        HashMap<String, String> pictogramaInfo = new HashMap<>();
            pictogramaInfo.put("imagen", "data:image/png;base64,"+base64Image);
            pictogramaInfo.put("audio", "data:audio/*;base64,"+base64EncodedAudio);
            pictogramaInfo.put("significado", significado);


        response.setContentType("application/json");
        PrintWriter outs = response.getWriter();
        outs.print(new Gson().toJson(pictogramaInfo));
        outs.flush();
    }
    } catch (Exception e) {
        e.printStackTrace(); // O maneja la excepción según tus necesidades
    } finally {
        // Asegúrate de cerrar la conexión en un bloque finally para garantizar que se cierre incluso si hay una excepción
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
