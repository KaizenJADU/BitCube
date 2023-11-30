<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login niño</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            background-color: #FAECE1;
            font-family: "Roboto Condensed", sans-serif
        }

        .aviso-container {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #D8F8D7;
            color: #721c24;
            padding: 10px;
            text-align: center;
            z-index: 1000;
        }

        #mensaje-exito, #mensaje-exitos {
            text-align: center;
            background-color: rgba(255, 255, 255, 0.5);
            padding: 8% 3% 8% 3%;
            border-radius: 10px;
            width: 50%;
        }

        #mensaje-exito p, #mensaje-exitos p {
            color: #333;
            font-size: 130%;
        }

        #mensaje-exito button {
            margin: 10px;
            font-size: 16px;
        }

        .aviso1, .aviso2 {
            padding: 8px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: #fff;
        }

        .aviso1 {
            background-color: #007BFF;
        }

        .aviso2 {
            background-color: #DC3545;
        }

        .aviso1:hover {
            background-color: #0056b3;
        }

        .aviso2:hover {
            background-color: #a52a2a;
        }
    </style>

</head>
<body>
<%@ page import="java.sql.*,org.mindrot.jbcrypt.BCrypt,conexion.conectadita" %>

<%
int idUsuario = 0;
int idTipo = 0;
String nombre = request.getParameter("nombre");
String apePat = request.getParameter("ap_paterno");
String apeMat = request.getParameter("ap_materno");
String telefono = request.getParameter("phone");
String correo = request.getParameter("email");
String contra = request.getParameter("pass");
String rfc = request.getParameter("rfc");
int cod = Integer.parseInt(request.getParameter("cod"));
int idInfante = 0;
String nameni = request.getParameter("nameni");
String ap_pater_ni = request.getParameter("ap_pater_ni");
String ap_mater_ni = request.getParameter("ap_mater_ni");
int edad = Integer.parseInt(request.getParameter("edad"));
String sexo = request.getParameter("sexo");

Connection con = null;
ResultSet results = null;
PreparedStatement pst = null;
conectadita conecta = new conectadita();
con = conecta.getConnection();
boolean usuarioExiste = false;

String consultaVerificacion = "SELECT * FROM Usuario WHERE correoUsuario = ? OR RFC = ? OR telUsuario = ?";
try (PreparedStatement stmtVerificacion = con.prepareStatement(consultaVerificacion)) {
    stmtVerificacion.setString(1, correo);
    stmtVerificacion.setString(2, rfc);
    stmtVerificacion.setString(3, telefono);
    ResultSet resultSet = stmtVerificacion.executeQuery();

    if (resultSet.next()) {
        usuarioExiste = true;
    }
}

if (!usuarioExiste) {
    String querystring1 = "INSERT INTO Infante (idInfante,nombreInfante,apePatInfante,apeMatInfante,edadInfante,sexo) VALUES (?,?,?,?,?,?)";
    pst = con.prepareStatement(querystring1);
    pst.setInt(1, idInfante);
    pst.setString(2, nameni);
    pst.setString(3, ap_pater_ni);
    pst.setString(4, ap_mater_ni);
    pst.setInt(5, edad);
    pst.setString(6, sexo);
    pst.executeUpdate();

    String hashedPassword = BCrypt.hashpw(contra, BCrypt.gensalt());

    String querystring = "INSERT INTO Usuario "
            + "(IdUsuario,idTipoUsuario,idInfante,nombreUsuario,apePatUsuario,apeMatUsuario,correoUsuario,telUsuario,contrasena,"
            + "RFC,codigo) select ?,TT.idTipoUsuario,I.idInfante,?,?,?,?,?,?,?,? FROM Infante I JOIN TipoUsuario TT "
            + "WHERE I.nombreInfante = ? and TT.idTipoUsuario = '2'";
    pst = con.prepareStatement(querystring);
    pst.setInt(1, idUsuario);
    pst.setString(2, nombre);
    pst.setString(3, apePat);
    pst.setString(4, apeMat);
    pst.setString(5, correo);
    pst.setString(6, telefono);
    pst.setString(7, hashedPassword);
    pst.setString(8, rfc);
    pst.setInt(9, cod);
    pst.setString(10, nameni);
    pst.executeUpdate();

    session.setAttribute("mensajeExito", "Registro exitoso. Ahora puede iniciar sesión.");
    %>
    <div id="mensaje-exit" class="aviso-container">
        <p style="color: black;">Registro exitoso. Ahora puede iniciar sesión.</p>
    </div>
    <div id="mensaje-exitos">
    <p>Si quiere recibir un archivo a su correo sobre el progreso del niño en la pagina oprima el boton especificaciones del niño,
        sino oprima realizar mas tarde</p>
    <button class="aviso1" onclick="window.location.href='registroniño.html'">Especificaciones del niño</button>
    <button class="aviso2" onclick="window.location.href='login.jsp?registroExitoso=true'">Realizar más tarde</button>
</div>
    <%
} else {
    session.setAttribute("mensajeError", "Ya existe un usuario con el mismo correo, RFC o número de teléfono");
}
con.close();
%>

<div id="aviso" class="aviso-container">
    <%
    String mensajeError = (String) session.getAttribute("mensajeError");
    if (mensajeError != null) {
        out.println(" <a href='registrarse.html' style='margin: 0% 100% 45% 0;  font-size: 30px;' title='Regresar'>"
                + "<i class='bx bx-left-arrow-alt' style='color: #246DF6'></i></a>");
        out.println("<p style='color: red;'>" + mensajeError + "</p>");
        session.removeAttribute("mensajeError");
    }
    %>

</div>


<script>
    document.addEventListener("DOMContentLoaded", function () {
        mostrarAviso();
    });

    function mostrarAviso() {
        var aviso = document.getElementById("aviso");
        var mensajeExito = document.getElementById("mensaje-exit");
        var mensajeExitos = document.getElementById("mensaje-exitos");

       var registroExitoso = !<%= usuarioExiste %>;

if (registroExitoso) {
    aviso.style.display = "none";
    mensajeExito.style.display = "block";
    mensajeExitos.style.display = "block";
} else {
    aviso.style.display = "block";
    mensajeExito.style.display = "none";
    mensajeExitos.style.display = "none";
}
    }
</script>
</body>
</html>
