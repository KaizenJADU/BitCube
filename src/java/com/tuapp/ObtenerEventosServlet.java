package com.tuapp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import conexion.conectadita;

@WebServlet(name = "ObtenerEventosServlet", urlPatterns = {"/ObtenerEventosServlet"})
public class ObtenerEventosServlet extends HttpServlet {

    @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
     }
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("application/json;charset=UTF-8");

    try (PrintWriter out = response.getWriter()) {
      
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("user") != null ) {
           
            String correo = (String) session.getAttribute("user");

            
            int idUsuario = obtenerIdUsuario(correo);
            System.out.println(idUsuario); 

            if (idUsuario != -1) {
               
                JSONArray jsonArray = obtenerEventosDesdeBD(idUsuario);
                
                out.print(jsonArray.toString());
                
            } else {
               
                JSONObject errorObject = new JSONObject();
                errorObject.put("success", false);
                errorObject.put("error", "Credenciales no válidas");
                out.print(errorObject.toString());

                 
            }
        } else {
          
            JSONObject errorObject = new JSONObject();
            errorObject.put("success", false);
            errorObject.put("error", "Sesión no válida");
            out.print(errorObject.toString());

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}

    private int obtenerIdUsuario(String correo) {
         int idUsuario = -1; 

    try (Connection conec = new conectadita().getConnection()) {
        String query = "SELECT IdUsuario FROM Usuario WHERE correoUsuario = ?";
        try (PreparedStatement pstat = conec.prepareStatement(query)) {
            pstat.setString(1, correo);

            try (ResultSet results = pstat.executeQuery()) {
                if (results.next()) {
                    idUsuario = results.getInt("IdUsuario");
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return idUsuario;
}

private JSONArray obtenerEventosDesdeBD(int idUsuario) throws SQLException {
    JSONArray jsonArray = new JSONArray();

    try (Connection conec = new conectadita().getConnection()) {
        String query = "SELECT idUsuario, fechaCal, actividad FROM Calendario WHERE idUsuario = ?";
        try (PreparedStatement pstat = conec.prepareStatement(query)) {
            pstat.setInt(1, idUsuario);

            try (ResultSet results = pstat.executeQuery()) {
                while (results.next()) {
                    String fechaCal = formatDate(results.getDate("fechaCal"));
                    String actividad = results.getString("actividad");

                  
                    JSONObject jsonEvento = new JSONObject();
                    jsonEvento.put("idUsuario", idUsuario);
                    jsonEvento.put("fechaCal", fechaCal);
                    jsonEvento.put("actividad", actividad);

                    jsonArray.put(jsonEvento);
                }
            }
        }
    }

    System.out.println(jsonArray.toString()); 

    return jsonArray;
}

private String formatDate(java.sql.Date date) {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    return sdf.format(date);
}

    @Override
    public String getServletInfo() {
        return "Servlet para obtener eventos desde la base de datos";
    }
}
