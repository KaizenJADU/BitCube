package com.tuapp;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import conexion.conectadita;
import java.io.ByteArrayInputStream;
import javax.servlet.annotation.MultipartConfig;

@WebServlet("/EditarpictogramasServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class EditarpictogramasServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = null;
        try {
            conectadita conecta = new conectadita();
            connection = conecta.getConnection();

            String idPictogramaEliminar = request.getParameter("idpic");

            String deleteQuery = "DELETE FROM ImagenPictograma WHERE idImagen=?";
            try (PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery)) {
                deleteStatement.setString(1, idPictogramaEliminar);
                deleteStatement.executeUpdate();
            }

            String nuevoSignificado = request.getParameter("significadoss");

            Part nuevaImagenPart = request.getPart("ima");
            Part nuevoAudioPart = request.getPart("auds");

            try (InputStream nuevaImagenStream = nuevaImagenPart.getInputStream();
                 InputStream nuevoAudioStream = nuevoAudioPart.getInputStream()) {

                byte[] nuevaImagenBytes = nuevaImagenStream.readAllBytes();
                byte[] nuevoAudioBytes = nuevoAudioStream.readAllBytes();

                String insertQuery = "INSERT INTO ImagenPictograma (imagen, audio, significado) VALUES (?, ?, ?)";
                try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                    insertStatement.setBlob(1, new ByteArrayInputStream(nuevaImagenBytes));
                    insertStatement.setBlob(2, new ByteArrayInputStream(nuevoAudioBytes));
                    insertStatement.setString(3, nuevoSignificado);
                    insertStatement.executeUpdate();
                }

                request.setAttribute("actualizacionExitosa", true);
            } catch (IOException e) {
                e.printStackTrace();
                request.setAttribute("actualizacionExitosa", false);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("actualizacionExitosa", false);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/JSP/adminpictograma.jsp");
    }
}