package modelo;

import conexion.conectadita;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class operaciones {
  
    public int loguear(String us, String contra){
         int idTipo = 0;

    conectadita connectionManager = new conectadita();
    try {
        Connection con = connectionManager.getConnection();

        String sql = "select idTipoUsuario from Usuario where correoUsuario=? and contrasena=?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, us);
        pst.setString(2, contra);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            idTipo = rs.getInt(1);
        }

        con.close();

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return idTipo;
}
}
