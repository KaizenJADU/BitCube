package com.tuapp;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import conexion.conectadita;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint(value = "/chat/{username}")
public class WebSocket {
  private static final Map<String, Session> sessions = new ConcurrentHashMap<>();
      @OnOpen
    public void onOpen(Session session) {
        String username = session.getPathParameters().get("username");
        sessions.put(username, session);

    System.out.println("Usuario conectado: " + username);
    }


@OnMessage
public void onMessage(Session session, String message) {
    String[] parts = message.split(":");
    if (parts.length == 2) {
        // Mensaje enviado desde un usuario al admin
        String targetUsername = parts[0].trim();
        String userMessage = parts[1].trim();
        sendUserMessage(targetUsername, userMessage, session.getPathParameters().get("username"));
    } else {
        // Mensaje normal enviado por el usuario
        String username = session.getPathParameters().get("username");
        guardarComentarioEnBD(username, message);
        broadcastMessage(message);
    }
}


private void sendUserMessage(String targetUsername, String userMessage, String senderUsername) {
    Session targetSession = sessions.get(targetUsername);
    if (targetSession != null) {
        try {
            targetSession.getBasicRemote().sendText(senderUsername + ": " + userMessage);
            System.out.println("Mensaje enviado a " + targetUsername + ": " + userMessage);
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error al enviar mensaje a " + targetUsername);
        }
    }
}

private void sendAdminMessage(String targetUsername, String adminMessage) {
    Session targetSession = sessions.get(targetUsername);
    if (targetSession != null) {
        try {
            targetSession.getBasicRemote().sendText("Admin: " + adminMessage);
            System.out.println("Mensaje enviado a " + targetUsername + ": " + adminMessage);
        } catch (IOException e) {
            e.printStackTrace();
            System.err.println("Error al enviar mensaje a " + targetUsername);
        }
    }
}

    private void broadcastMessage(String message) {
        for (Session clientSession : sessions.values()) {
            try {
                clientSession.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void guardarComentarioEnBD(String username, String message) {
    try (Connection connection = new conectadita().getConnection()) {
        // Obtener el ID del usuario
        int idUsuario = obtenerIdUsuario(connection, username);

        String insertComentarioQuery = "INSERT INTO Comentario (fechaComen, texto) VALUES (CURRENT_TIMESTAMP, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertComentarioQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, message);
            preparedStatement.executeUpdate();

            int idComentario = obtenerIdGenerado(preparedStatement);

            String insertRelacionQuery = "INSERT INTO RelUsuComent (idUsuario, idComentario) VALUES (?, ?)";
            try (PreparedStatement relUsuComentStatement = connection.prepareStatement(insertRelacionQuery)) {
                relUsuComentStatement.setInt(1, idUsuario);
                relUsuComentStatement.setInt(2, idComentario);
                relUsuComentStatement.executeUpdate();
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    private int obtenerIdUsuario(Connection connection, String username) throws SQLException {
    String selectQuery = "SELECT idUsuario FROM Usuario WHERE nombreUsuario=?";
    try (PreparedStatement preparedStatement = connection.prepareStatement(selectQuery)) {
        preparedStatement.setString(1, username);
        try (ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt("idUsuario");
            } else {
                // Devolver un valor diferente, por ejemplo, -1, cuando el usuario no existe
                return -1;
            }
        }
    }
}


    private int obtenerIdGenerado(PreparedStatement preparedStatement) throws SQLException {
        try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            }
        }
        return -1; // Retorno de valor predeterminado en caso de error
    }

    @OnClose
    public void onClose(Session session) {
        // Implementación si es necesario
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        // Implementación si es necesario
    }
}
