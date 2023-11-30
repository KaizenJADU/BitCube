package modelo;


import conexion.conectadita;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class operaciones {

   public class ResultadoLogin {
        private final String contrasenaSinCifrar;
        private final int idTipoUsuario;

        public ResultadoLogin(String contrasenaSinCifrar, int idTipoUsuario) {
            this.contrasenaSinCifrar = contrasenaSinCifrar;
            this.idTipoUsuario = idTipoUsuario;
        }

        public String getContrasenaSinCifrar() {
            return contrasenaSinCifrar;
        }

        public int getIdTipoUsuario() {
            return idTipoUsuario;
        }
    }
   public class Usuario {
    private String hashAlmacenado;
    private int idTipoUsuario;

    public Usuario(String hashAlmacenado, int idTipoUsuario) {
        this.hashAlmacenado = hashAlmacenado;
        this.idTipoUsuario = idTipoUsuario;
    }

    public String getHashAlmacenado() {
        return hashAlmacenado;
    }

    public int getIdTipoUsuario() {
        return idTipoUsuario;
    }
}

   public Usuario  loguear(String us, String contra) {
        Usuario usuario = null;

        conectadita connectionManager = new conectadita();
        try {
            Connection con = connectionManager.getConnection();

            String sql = "select contrasena, idTipoUsuario from Usuario where correoUsuario=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, us);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                String hashAlmacenado = rs.getString("contrasena");
                int idTipo = rs.getInt("idTipoUsuario");

                usuario = new Usuario(hashAlmacenado, idTipo);
            }

            con.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return usuario;
    }

    
}
