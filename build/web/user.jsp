<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Principal</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="styleprincipal.css">
    <link rel="stylesheet" href="stylefooterandheader.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="scriptprincipal.js"></script>
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
                        <li class="navbar_link after-transform"><a class="active" href="user.jsp">Principal</a>
                        </li>
                        <li class="navbar_link after-transform"><a href="Categorias.jsp">Categorías</a>
                        </li>
                        <li class="navbar_link after-transform"><a href="Pictogramas.jsp">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                        <li class="navbar_link after-transform"><a href="Videos.jsp">Videos</a></li>
                        <li class="navbar_link after-transform"><a href="Calendario.jsp">Calendario</a></li>
                        <li class="navbar_link after-transform"><a href="perfil.jsp">Perfil</a></li>
                        <li class="navbar_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="navbar-responsive">
            <ul class="navbar-responsive_nav">
                <li class="navbar-responsive_link after-transform"><a class="active" href="user.jsp">Principal</a>
                </li>
                <li class="navbar-responsive_link after-transform"><a href="Categorias.jsp">Categorías</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Pictogramas.jsp">Pictogramas</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videos.jsp">Videos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Calendario.jsp">Calendario</a></li>
                <li class="navbar-responsive_link after-transform"><a href="perfil.jsp">Perfil</a></li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
       
        <div class="bienvenida" style="padding:  7% 0% 0% 15%">
             <h1>Bienvenid@ a Bit-Cube <% out.print(results.getString("nombreUsuario")); %> </h1> 
        <p style="font-size: 1.5em; line-height: 1.6; margin-right: 20%; text-align: justify;">Bit-Cube es un sistema web y móvil dirigido a los niños con Asperger, enfocándonos en su desarrollo social y cognitivo. Los niños con esta especialidad tienden a tener menos atención a tempranas edades, por lo que el crecer tienen muchos problemas sociales, es por eso que decidimos enfocarnos en ellos. 
        Empleando como uso administrativo principal al tutor del infante, para llevar acabo un mejor seguimiento de su tratamiento y progreso médico.
        </p>
        </div>
        <div class="quienes-somos" style="padding: 20% 0% 0% 40%; ">
            <h1>¿Quienes Somos</h1>
        </div>
            <p style="font-size: 1.5em; line-height: 1.6; margin: 0% 20% 10% 20%; text-align: justify;">Somos un equipo formado por cuatro apasionados estudiantes de programación del CECYT 9, que se esfuerzan por marcar la diferencia en el mundo a través de nuestros proyectos con un impacto social significativo, como lo es este.</p>
            <h1 style="text-align: center">¿Qué tiene Bit-Cube?</h1>
            <p style="font-size: 1.5em; line-height: 1.6; margin: 0% 20% 10% 20%; text-align: justify;">Contamos con videojuegos, pictogramas, calendario y estadísticas de crecimiento que nos permiten ver la mejora progresiva del infante. 
Diversas categorías de interés para que infante tenga una amplia variedad de temas para que pueda desarrollar sus gustos y explotar los temas que prefiera.
</p>
                <div class="grupo fundadores " style="padding: 0% 10% 0 10%">
                            <div class="grupo">
                                <img src="imagenes/" alt="alt"/>
                                    <h3 class="titulo">
                                            Pictogramas
                                            <i class="decoracion"></i>
                                    </h3>
                                <p>Los videos adaptados para personas con autismo son secuencias visuales diseñadas considerando las necesidades específicas de este público. Estos videos pueden incluir colores y sonidos suaves, evitar estímulos sensoriales intensos y presentar información de manera clara y estructurada.</p>
                            </div>
                            <div class="grupo">
                                <img src="imagenes/" alt="alt"/>
                                    <h3 class="titulo">
                                            Videos
                                            <i class="decoracion"></i>
                                    </h3>
                                <P>Los pictogramas adaptados para personas con autismo son representaciones visuales simplificadas diseñadas para facilitar la comprensión y comunicación. Estos símbolos pueden ser utilizados en entornos como escuelas y hogares para proporcionar instrucciones claras, apoyar la estructuración del tiempo y ayudar en la expresión de emociones.</P>
                            </div>
                            <div class="grupo">
                                <img src="imagenes/" alt="alt"/>
                                    <h3 class="titulo">
                                            Videojuegos
                                            <i class="decoracion"></i>
                                    </h3>
                                <p>Los videojuegos diseñados con inclusividad para personas con autismo buscan crear experiencias de juego accesibles y adaptadas. Estos juegos pueden incorporar elementos visuales y auditivos que sean amigables para personas con sensibilidades sensoriales, ofrecer opciones de personalización y proporcionar una estructura clara en el juego. </p>
                            </div>
                    </div>
          
    </div>
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
                    <li><a href="soporte.jsp"><span>Soporte</span></a></li>
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