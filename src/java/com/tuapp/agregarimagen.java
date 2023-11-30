package com.tuapp;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import conexion.conectadita;

@WebServlet("/SubirImagenServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) 
public class agregarimagen extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection conec = new conectadita().getConnection();
            String significado = request.getParameter("significado");

            Part imagenPart = request.getPart("imagen");
            InputStream imagenInputStream = imagenPart.getInputStream();

            String audioFileName = getSubmittedFileName(imagenPart);

            Part audioPart = request.getPart("audio");
            InputStream audioInputStream = audioPart.getInputStream();

            String sql = "INSERT INTO ImagenPictograma (imagen, audio, significado) VALUES (?, ?, ?)";
            try (PreparedStatement preparedStatement = conec.prepareStatement(sql)) {
                preparedStatement.setBlob(1, imagenInputStream);
                preparedStatement.setBlob(2, audioInputStream);
                preparedStatement.setString(3, significado);
                preparedStatement.executeUpdate();
            }

            response.getWriter().println("Imagen y audio subidos con éxito.");
            response.sendRedirect(request.getContextPath() + "/JSP/adminpictograma.jsp");
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
