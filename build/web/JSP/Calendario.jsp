<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendario</title>

    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
    <link rel="stylesheet" href="../stylefooterandheader.css">
    <link rel="stylesheet" href="../stylecalendario.css">
    <script src="../calendar.js"></script>
    <script src="../scriptprincipal.js"></script>
    <style>
        
        #activityForm {
            display: none;
            max-width: 400px;
            margin: 0% 0% 3% 34.5%;
        }

        #activityForm label,
        #activityForm input {
            margin-bottom: 10px;
        }
        
        #activityForm input[type="text"],
        #activityForm input[type="date"] {
            width: 100%; 
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-left: 5%;
        }
        #activityForm label{
            margin-left: 5%;
        }

    </style>
</head>
<body>
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
                        <li class="navbar_link after-transform"><a  href="user.jsp">Principal</a>
                        </li>
                        <li class="navbar_link after-transform"><a href="Categorias.jsp">Categorías</a>
                        </li>
                        <li class="navbar_link after-transform"><a href="Pictogramas.jsp">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                        <li class="navbar_link after-transform"><a href="Videos.jsp">Videos</a></li>
                        <li class="navbar_link after-transform"><a class="active" href="Calendario.jsp">Calendario</a></li>
                        <li class="navbar_link after-transform"><a href="perfil.jsp">Perfil</a></li>
                        <li class="navbar_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="navbar-responsive">
            <ul class="navbar-responsive_nav">
                <li class="navbar-responsive_link after-transform"><a  href="user.jsp">Principal</a>
                </li>
                <li class="navbar-responsive_link after-transform"><a href="Categorias.jsp">Categorías</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Pictogramas.jsp">Pictogramas</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videos.jsp">Videos</a></li>
                <li class="navbar-responsive_link after-transform"><a class="active" href="Calendario.jsp">Calendario</a></li>
                <li class="navbar-responsive_link after-transform"><a href="perfil.jsp">Perfil</a></li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
     <h1 style="text-align: center; margin: 5% 0 5% 0">Calendario de actividades</h1>

    <div id="calendar"></div>

    <form id="activityForm" method="post" action="agregarcalendario.jsp" style="display: none;">
        <label for="dateInput">Fecha:</label>
        <input type="date" id="dateInput" name="fecha" required /><br>

        <label for="activityInput">Actividad:</label>
        <input type="text" id="activityInput" name="actividad" placeholder="Ingrese actividad" autocomplete="off" required /><br>

        <input type="submit" class="raise" value="Guardar" />
    </form>
    <button id="addActivityButton" class="raise">Agregar actividad</button>
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

  <script>
        document.addEventListener("DOMContentLoaded", function() {
            
            var userId = 'null';

            if (userId) {
                fetch( '../ObtenerEventosServlet')
                    .then(response => response.json())
                    .then(data => {
                        console.log("Datos desde el servidor:", data);

                        var eventosDesdeServidor = data.map(function(evento) {
                            return {
                                date: moment(evento.fechaCal, 'YYYY-MM-DD'),
                                idUsuario: evento.idUsuario,
                                actividad: evento.actividad
                            };
                        });

                      

                        var calendar = new Calendar('#calendar', eventosDesdeServidor);
                    })
                    .catch(error => console.error('Error al obtener eventos:', error));
            } else {
                console.error('Sesión no válida');
            }

            var activityForm = document.getElementById('activityForm');
            var addActivityButton = document.getElementById('addActivityButton');

            addActivityButton.addEventListener('click', function() {
                activityForm.style.display = 'block';
            });
        });
    </script>

</body>
</html>
