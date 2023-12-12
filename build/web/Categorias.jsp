<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categorias</title>
         <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="../stylecategorias.css">
    <link rel="stylesheet" href="../stylefooterandheader.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../scriptprincipal.js"></script>
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
                        <li class="navbar_link after-transform"><a class="active" href="Categorias.jsp">Categorías</a>
                        </li>
                        <li class="navbar_link after-transform"><a  href="Pictogramas.jsp">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                        <li class="navbar_link after-transform"><a href="Videos.jsp">Videos</a></li>
                        <li class="navbar_link after-transform"><a  href="Calendario.jsp">Calendario</a></li>
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
                <li class="navbar-responsive_link after-transform"><a class="active" href="Pictogramas.jsp">Pictogramas</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videos.jsp">Videos</a></li>
                <li class="navbar-responsive_link after-transform"><a  href="Calendario.jsp">Calendario</a></li>
                <li class="navbar-responsive_link after-transform"><a href="perfil.jsp">Perfil</a></li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
        <div style="position: relative; width: 40%;  margin: 5% 0 0 30%;">
    <img src="../imagenes/autismo2.png" alt="alt" style="width: 100%;">
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; color: black; font-size: 400%; font-weight: bold;">
        Categorías
    </div>
</div>
   <ul class="cards">
  <li>
    <a href="" class="card">
        <img src="../imagenes/picto1.png" class="card__image" alt="" />
      <div class="card__overlay">
        <div class="card__header">
          <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>                     
          <div class="card__header-text">
            <h3 class="card__title">Música</h3>            
          </div>
        </div>
        <p class="card__description">Pictogramas para los infantes que les gusta la música</p>
      </div>
    </a>      
  </li>
  <li>
    <a href="" class="card">
        <img src="../imagenes/picto2.png" class="card__image" alt="" />
      <div class="card__overlay">        
        <div class="card__header">
          <svg class="card__arc" xmlns="http://www.w3.org/2000/svg"><path /></svg>                 
          <div class="card__header-text">
            <h3 class="card__title">Deportes</h3>
          </div>
        </div>
        <p class="card__description">Pictogramas para los infantes con gusto por los deportes</p>
      </div>
    </a>
  </li>
</ul>
    
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

    </body>
</html>
