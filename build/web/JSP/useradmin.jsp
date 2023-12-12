<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Principal Admin</title>

    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="../styleprincipal.css">
    <link rel="stylesheet" href="../stylefooterandheader.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../scriptprincipal.js"></script>
</head>
    <body>
        <%
        HttpSession sesion = request.getSession();
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
                        <li class="navbar_link after-transform"><a class="active" href="useradmin.jsp">Principal</a></li>
                        <li class="navbar_link after-transform"><a href="adminusuarios.jsp">Usuarios</a></li>
                        <li class="navbar_link after-transform"><a href="adminpictograma.jsp">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a href="../soporteadmin.jsp">Soporte</a></li>
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
                <li class="navbar-responsive_link after-transform"><a href="../soporteadmin.jsp">Soporte</a>
                </li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
        <div class="bienvenida" style="display: grid; margin: 10% 0% 10% 9%;">
    <h1 style="font-size: 10em">Bienvenido <% out.print(results.getString("nombreUsuario")); %></h1>
        </div>
         <footer>
       <div>
            <span class="logo">Bit-Cube</span>
       </div>
       <div class="row"> 
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                </div>
               
            </div>
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                    <span class="footer-toggle"></span>
                    <span class="footer-cat">Links Rapidos</span>
                </div>
                <ul class="footer-cat-links">
                    <li><a href="useradmin.jsp"><span>Principal</span></a></li>
                    <li><a href="adminusuarios.jsp"><span>Usuarios</span></a></li>
                    <li><a href="adminpictograma.jsp"><span>Pictogramas</span></a></li>
                    <li><a href="comentarios.jsp"><span>Comenatrios</span></a></li><br><br><br><br><br>
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
