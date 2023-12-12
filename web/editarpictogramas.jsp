<%@page import="java.util.Collection"%>
<%@ page import="java.io.*, java.sql.*, conexion.conectadita, java.util.Base64" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%
Connection connection = null;
try {
    conectadita conecta = new conectadita();
    connection = conecta.getConnection();

    String idImagen = request.getParameter("pictogramaIds");
    String nuevoSignificado = request.getParameter("significadoss");

    // Obtén la imagen actual desde la base de datos
    String selectQuery = "SELECT imagen FROM ImagenPictograma WHERE idImagen=?";
    try (PreparedStatement selectStatement = connection.prepareStatement(selectQuery)) {
        selectStatement.setString(1, idImagen);
        ResultSet resultSet = selectStatement.executeQuery();

        if (resultSet.next()) {
            Blob imagenBlob = resultSet.getBlob("imagen");
            byte[] imagenBytes = imagenBlob.getBytes(1, (int) imagenBlob.length());
            // Convierte la imagen actual a Base64 para mostrarla en la página (opcional)
            String imagenBase64 = Base64.getEncoder().encodeToString(imagenBytes);
        }
    }

    // Inicializa las partes de la nueva imagen y el nuevo audio a null
    Part nuevaImagenPart = null;
    Part nuevoAudioPart = null;

    // Verifica si se enviaron nuevas imágenes
    Collection<Part> parts = request.getParts();
    for (Part part : parts) {
        String partName = part.getName();
        if (partName.equals("ima")) {
            nuevaImagenPart = part;
        } else if (partName.equals("auds")) {
            nuevoAudioPart = part;
        }
    }

    // Actualiza la imagen si se envió una nueva
    if (nuevaImagenPart != null) {
        try (InputStream nuevaImagenStream = nuevaImagenPart.getInputStream()) {
            byte[] nuevaImagenBytes = nuevaImagenStream.readAllBytes();

            String updateImagenQuery = "UPDATE ImagenPictograma SET imagen=? WHERE idImagen=?";
            try (PreparedStatement updateImagenStatement = connection.prepareStatement(updateImagenQuery)) {
                updateImagenStatement.setBlob(1, new ByteArrayInputStream(nuevaImagenBytes));
                updateImagenStatement.setString(2, idImagen);
                updateImagenStatement.executeUpdate();
                 System.out.println("Actualización exitosa");
            }
        } catch (IOException e) {
            e.printStackTrace();
            e.printStackTrace();
        System.out.println("Error durante la actualización i");
        }
    }

    // Actualiza el audio si se envió uno nuevo
    if (nuevoAudioPart != null) {
        try (InputStream nuevoAudioStream = nuevoAudioPart.getInputStream()) {
            byte[] nuevoAudioBytes = nuevoAudioStream.readAllBytes();

            String updateAudioQuery = "UPDATE ImagenPictograma SET audio=? WHERE idImagen=?";
            try (PreparedStatement updateAudioStatement = connection.prepareStatement(updateAudioQuery)) {
                updateAudioStatement.setBlob(1, new ByteArrayInputStream(nuevoAudioBytes));
                updateAudioStatement.setString(2, idImagen);
                updateAudioStatement.executeUpdate();
                 System.out.println("Actualización exitosa");
            }
        } catch (IOException e) {
            e.printStackTrace();
            e.printStackTrace();
        System.out.println("Error durante la actualización a");
        }
    }

    String updateSignificadoQuery = "UPDATE ImagenPictograma SET significado=? WHERE idImagen=?";
    try (PreparedStatement updateSignificadoStatement = connection.prepareStatement(updateSignificadoQuery)) {
    updateSignificadoStatement.setString(1, nuevoSignificado);
    updateSignificadoStatement.setString(2, idImagen);
    updateSignificadoStatement.executeUpdate();
    System.out.println("Actualización del significado exitosa");
} catch (SQLException e) {
    e.printStackTrace();
    System.out.println("Error durante la actualización del significado");
    request.setAttribute("actualizacionExitosa", false);
}
    }
finally {
    if (connection != null) {
        try {
            connection.close();
        } catch (SQLException e) {
             e.printStackTrace();
        System.out.println("Error durante la actualización s");
        }
    }
}

%>
