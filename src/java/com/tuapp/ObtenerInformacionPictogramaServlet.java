package com.tuapp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.HashMap;
import java.io.InputStream;
import java.util.Base64;
import conexion.conectadita;

@WebServlet("/obtenerInformacionPictograma")
public class ObtenerInformacionPictogramaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            int idImagen = Integer.parseInt(request.getParameter("idImagen"));
            
            Connection connection = null;

            try {
                conectadita conecta = new conectadita();
                connection = conecta.getConnection();

                String query = "SELECT * FROM ImagenPictograma WHERE idImagen = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setInt(1, idImagen);
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
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
                    pictogramaInfo.put("imagen", "data:image/png;base64," + base64Image);
                    pictogramaInfo.put("audio", "data:audio/mp3;base64," + base64EncodedAudio);
                    pictogramaInfo.put("significado", significado);

                    String json = new Gson().toJson(pictogramaInfo);
                    out.print(json);
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("Pictograma no encontrado");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("Error en el servidor: " + e.getMessage());
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Error en el servidor: " + e.getMessage());
        } finally {
            out.flush();
            out.close();
        }
    }
}
