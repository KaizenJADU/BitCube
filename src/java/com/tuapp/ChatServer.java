package com.tuapp;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import conexion.conectadita;
import java.sql.SQLException;
import javax.websocket.server.PathParam;

@ServerEndpoint("/chat/{userType}/{userId}")
public class ChatServer {

    private static final Map<String, Session> adminSessions = Collections.synchronizedMap(new HashMap<String, Session>());
    private static final Map<String, Session> userSessions = Collections.synchronizedMap(new HashMap<String, Session>());

   @OnOpen
public void onOpen(Session session, @PathParam("userType") String userType, @PathParam("userId") String userId) {
    String userKey = userType + "-" + userId;

     session.getUserProperties().put("userId", userId);

    if ("admin".equals(userType)) {
        adminSessions.put(userKey, session);
        System.out.println("Nuevo administrador conectado: " + userId);
    } else if ("user".equals(userType)) {
        userSessions.put(userKey, session);
        System.out.println("Nuevo usuario conectado: " + userId);
    }
}

    @OnMessage
public void onMessage(String message, Session session, @PathParam("userType") String userType) {
    String userKey = userType + "-" + getUserId(session);

    if ("admin".equals(userType) && userSessions.containsKey(userKey)) {
        sendMessageToUser(userSessions.get(userKey), message);
    } else if ("user".equals(userType) && adminSessions.size() == 1) {
        sendMessageToAdmin(message);
    }
}


    @OnClose
    public void onClose(Session session, @PathParam("userType") String userType, @PathParam("userId") String userId) {
        String userKey = userType + "-" + userId;

        if ("admin".equals(userType)) {
            adminSessions.remove(userKey);
            System.out.println("Administrador desconectado: " + session.getId());
        } else if ("user".equals(userType)) {
            userSessions.remove(userKey);
            System.out.println("Usuario desconectado: " + session.getId());
        }
    }

    private void sendMessageToUser(Session userSession, String message) {
        try {
            userSession.getBasicRemote().sendText(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void sendMessageToAdmin(String message) {
        for (Session adminSession : adminSessions.values()) {
            try {
                adminSession.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private String getUserId(Session session) {
        String userIdAttribute = (String) session.getUserProperties().get("userId");

        if (userIdAttribute != null) {
            return userIdAttribute;
        } else {
            String sessionId = session.getId();
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                conectadita conecta = new conectadita();
                connection = conecta.getConnection();
                String sql = "SELECT IdUsuario FROM Usuario WHERE nombreUsuario = ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, sessionId);

                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    String userId = resultSet.getString("IdUsuario");
                    session.getUserProperties().put("userId", userId);
                    return userId;
                } else {
                    return "unknown";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                return "unknown";
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (preparedStatement != null) preparedStatement.close();
                    if (connection != null) connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

public static String cifrar(String mensaje) {
    StringBuilder mensajeCifrado = new StringBuilder();
    String mensajeMayusculas = mensaje.toUpperCase();  // Convertir a mayúsculas

    for (int i = 0; i < mensajeMayusculas.length(); i++) {
        char c = mensajeMayusculas.charAt(i);
        if (Character.isLetter(c)) {
            char base = Character.isUpperCase(c) ? 'A' : 'a' ;
            char letraCifrada = (char) (base + ('Z' - c));
            mensajeCifrado.append(letraCifrada);
        } else {
            mensajeCifrado.append(c);
        }
    }
    return mensajeCifrado.toString();
}
public static String descifrar(String mensajeCifrado) {
    StringBuilder mensajeDescifrado = new StringBuilder();

    for (int i = 0; i < mensajeCifrado.length(); i++) {
        char c = Character.toLowerCase(mensajeCifrado.charAt(i));  // Convertir a minúsculas
        if (Character.isLetter(c)) {
            char base = Character.isUpperCase(c) ? 'A' : 'a';
            char letraDescifrada = (char) (base + ('Z' - c));
            mensajeDescifrado.append(letraDescifrada);
        } else {
            mensajeDescifrado.append(c);
        }
    }

    return mensajeDescifrado.toString();
}



}
