<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="conexion.conectadita"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Soporte</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="styleprincipal.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="stylefooterandheader.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="scriptprincipal.js"></script>
    <script src="https://kit.fontawesome.com/cb6271a172.js" crossorigin="anonymous"></script>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
   
    <style>
        body {
    min-height: 100vh;
    position: relative;
    background-color: #FAECE1;
    font-family: "Roboto Condensed", sans-serif;
}
#chat-container {
    height: calc(90vh - 200px);
    overflow-y: auto;
    border: 1px solid #ccc;
    padding: 20px;
    margin: 50px;
    border-radius: 20px;
}

#message-input {
    width: calc(100% - 100px); 
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 20px;
    margin: 0 1% 0 2%;
}

#send-button {
    padding: 10px;
    border: 0px solid #00b3ff;
    border-radius: 20px;
    background-color: #fff;
    color: #fff;
    cursor: pointer;
}

#send-button:hover{
    border: 1px solid #00b3ff;
}
.mensaje-rojo {
    color: red;
}
    </style>
</head>
<body>
    <%
     HttpSession sesion = request.getSession();
     int ultimoIdMostrado = (int) (sesion.getAttribute("ultimoIdMostrado") != null ? sesion.getAttribute("ultimoIdMostrado") : 0);
        String usuario;
        String idTipo;
        String contra;

        if(sesion.getAttribute("user") != null && sesion.getAttribute("idTipo") != null){
            usuario = sesion.getAttribute("user").toString();
            idTipo = sesion.getAttribute("idTipo").toString();
            Connection conec = null;
            PreparedStatement pstat = null;
            ResultSet results = null;
            conectadita conecta = new conectadita();
            conec = conecta.getConnection();

            try {
                String query = "SELECT * FROM Usuario WHERE correoUsuario=?";
                pstat = conec.prepareStatement(query);
                pstat.setString(1, usuario); 

                results = pstat.executeQuery();

                while (results.next()) {
                int idUsuario = results.getInt("idUsuario"); 
                String nombrusuario = results.getString("nombreUsuario");
        %>
        
     <header>
        <div class="navbar">
            <div class="navbar_wrapper">
                <nav class="navbar_menu">
                    <a class="navbar_brand" href="index.html">
                        <img src="../imagenes/logo_bitcube.png" alt="Logo Bit-Cube">
                    </a>
                    <div id="nav-icon3">
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                    <ul class="navbar_nav">
                        <li class="navbar_link after-transform"><a href="useradmin.jsp">Principal</a></li>
                        <li class="navbar_link after-transform"><a href="adminusuarios.jsp">Usuarios</a></li>
                        <li class="navbar_link after-transform"><a href="adminpictograma.jsp">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a class="active"  href="soporteadmin.jsp">Soporte</a></li>
                        <li class="navbar_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="navbar-responsive">
            <ul class="navbar-responsive_nav">
                <li class="navbar-responsive_link after-transform"><a class="active" href='useradmin.jsp'>Principal</a></li>
                <li class="navbar-responsive_link after-transform"><a href='adminusuarios.jsp'>Usuarios</a></li>
                <li class="navbar-responsive_link after-transform"><a href="adminpictograma.jsp">Pictogramas</a>
                <li class="navbar-responsive_link after-transform"><a class="active" href="soporteadmin.jsp">Soporte</a>
                </li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
   
    <div id="chat-container">
       <%
try (Connection connection = new conectadita().getConnection()) {
    String selectQuery = "SELECT idComentario, texto FROM Comentario WHERE idComentario > ?";
    try (PreparedStatement preparedStatement = connection.prepareStatement(selectQuery)) {
        preparedStatement.setInt(1, ultimoIdMostrado);
        try (ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                int idComentario = resultSet.getInt("idComentario");
                out.println("<p>" + resultSet.getString("texto") + "</p>");

                // Actualizar el último ID de comentario mostrado en la sesión
                if (idComentario > ultimoIdMostrado) {
                    sesion.setAttribute("ultimoIdMostrado", idComentario);
                }
            }
        }
    }
} catch (SQLException e) {
    e.printStackTrace();
}
%>

    </div>

<form onsubmit="sendMessage(); return false;" style="margin: 0 0 5%;
">
        <select id="nombre-usuario-combo" required="" style="margin: 0 0 3% 5%">
    <option value="" disabled selected>Selecciona un usuario</option>
    <%
        try (Connection connection = new conectadita().getConnection()) {
            String querys = "SELECT nombreUsuario FROM Usuario where idTipoUsuario=2";
            try (PreparedStatement preparedStatement = connection.prepareStatement(querys)) {
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
    %>
                        <option value="<%= resultSet.getString("nombreUsuario") %>"><%= resultSet.getString("nombreUsuario") %></option>
    <%
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</select>
        <input type="text" id="message-input" required>
        <button type="submit" id="send-button" ><i class="fa-solid fa-paper-plane" style="color: #00b3ff; font-size: 15px"></i></button>
    </form>
    
<footer>
       <div>
            <span class="logo">Bit-Cube</span>
       </div>
       <div class="row"> 
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                    <span class="footer-toggle"></span>
                    <span class="footer-cat">Links Populares</span>
                </div>
                <ul class="footer-cat-links">
                    <li><a href="Pictogramas.jsp"><span>Pictogramas</span></a></li>
                    <li><a href="Videojuegos.jsp"><span>Videojuegos</span></a></li>
                    <li><a href="Videos.jsp"><span>Videos</span></a></li>
                    <li><a href="Categorias.jsp"><span>Categorias</span></a></li>
                </ul>
            </div>
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                    <span class="footer-toggle"></span>
                    <span class="footer-cat">Links Rapidos</span>
                </div>
                <ul class="footer-cat-links">
                    <li><a href="user.jsp"><span>Principal</span></a></li>
                    <li><a href="perfil.jsp"><span>Perfil</span></a></li>
                    <li><a href="Calendario.jsp"><span>Calendario</span></a></li><br><br><br><br><br>
                </ul>
            </div>
            <div class="col-3" id="newsletter">
                <div class="social-links social-2">
                    <a href="https://www.facebook.com/profile.php?id=100092619345456&mibextid=ZbWKwL"><i class="fab fa-facebook-f"></i></a>
                    <a href=""><i class="fab fa-twitter"></i></a>
                    <a href=""><i class="fab fa-instagram"></i></a>
                    <a href="https://github.com/KaizenJADU"><i class="fab fa-github"></i></a>
                </div><br><br>

                <div id="address">
                    <span>Localización de las oficinas</span>
                    <ul>
                        <li>
                            <i class="far fa-building"></i>
                            <div>Ciudad de México<br/>
                            Centro Estudios Científicos y Tecnológicos "Juan de Dios Bátiz"</div>
                        </li>    
                    </ul>
                </div>
            </div>
            <div class="social-links social-1 col-6">
                <a href="https://www.facebook.com/profile.php?id=100092619345456&mibextid=ZbWKwL"><i class="fab fa-facebook-f"></i></a>
                <a href=""><i class="fab fa-twitter"></i></a>
                <a href=""><i class="fab fa-instagram"></i></a>
                <a href="https://github.com/KaizenJADU"><i class="fab fa-github"></i></a>
                <br><br>
            </div>
       </div>
       <div id="copyright">
           &copy; Todos los drechos reservados 2023-2024
       </div>
       <div id="owner">
           <span>
               Hecho por <a href="http://kaizen.gerdoc.com">Kaizen</a>
           </span>
       </div>
        <script src="../scriptfooter.js"></script>
    </footer>
 <script>
         const socket = new WebSocket("ws://kaizen.gerdoc.com:8080/Bit-Cube/chat/gerdoc");
        
       
        socket.onmessage = function (event) {
        const mensaje = event.data;
        appendMessage(mensaje);
        console.log("Mensaje recibido:", mensaje);
    };

    function sendMessage() {
        const nombreUsuarioCombo = document.getElementById("nombre-usuario-combo");
        const nombreUsuario = nombreUsuarioCombo.value;
        const messageInput = document.getElementById("message-input");
        const message = messageInput.value.trim();

        if (message !== "") {
            socket.send(nombreUsuario + ": " + message); 
            messageInput.value = "";
        }
          const chatContainer = document.getElementById("chat-container");
        const messageElement = document.createElement("p");
        messageElement.textContent = message;
        messageElement.classList.add("mensaje-rojo");
        chatContainer.appendChild(messageElement);
    }

    function appendMessage(message) {
        const chatContainer = document.getElementById("chat-container");
        const messageElement = document.createElement("div");
        messageElement.textContent = message;
        chatContainer.appendChild(messageElement);
    }
    </script>
        
    <%
          }
           }
          catch (SQLException error) {
                out.print(error.toString());
            }
            conec.close();
          }
            else{
            out.println("<script>location.replace('login.jsp');</script>");
            }
        %>
</body>
</html>
