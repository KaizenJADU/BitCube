<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Videojuegos</title>

    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" href="../stylevideojuegos.css">
    <link rel="stylesheet" href="../stylefooterandheader.css">
    <script src="../scriptprincipal.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    
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
                        <li class="navbar_link after-transform"><a class="active" href="Videojuegos.jsp">Videojuegos</a></li>
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
                <li class="navbar-responsive_link after-transform"><a href="Pictogramas.jsp">Pictogramas</a></li>
                <li class="navbar-responsive_link after-transform"><a class="active" href="Videojuegos.jsp">Videojuegos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videos.jsp">Videos</a></li>
                <li class="navbar-responsive_link after-transform"><a  href="Calendario.jsp">Calendario</a></li>
                <li class="navbar-responsive_link after-transform"><a href="perfil.jsp">Perfil</a></li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
     <div class="videojuegos" style="padding:  7% 0% 0% 15%">
        <h1 >Videojuegos</h1>
        <p style="font-size: 1.5em; line-height: 1.6; margin: 2% 20% 10% 0%; text-align: justify;">Aquí podrás probar y desarrollar tus habilidades a través de mini juegos muy divertidos que pondrán a prueba tu habilidad, se obtendrá un progreso conforme más vayas jugando.</p>
     </div><br>
    <div class="swiper">
        <div class="swiper-wrapper">
          <div class="swiper-slide">
            <img
                src="../imagenes/videojuego.jpg"
              alt="" />
            <div class="content">
              <div class="title">
                <h1>
                  <span class="white-point"></span> Gato(Tic Tac Toe)
                  <span class="white-point"></span>
                </h1>
              </div>
              <p>
                Tic Tac Toe, también conocido como "Tres en línea", es un clásico juego de estrategia y habilidad que ha perdurado a lo largo del tiempo como uno de los pasatiempos más populares. Este sencillo, pero cautivador, juego de mesa se ha trasladado al mundo digital con una interpretación fiel y emocionante.
              </p>
              <a href="gato.jsp"  class="submit action-button" target="_top" style="font-size: 1em">Jugar</a>
            </div>
          </div>

          <div class="swiper-slide">
            <img
              src=""
              alt="" />
            <div class="content">
              <div class="title">
                <h1>
                  <span class="white-point"></span> Proximamente 
                  <span class="white-point"></span>
                </h1>
                <h3></h3>
              </div>
              <p>
                ...
              </p>
            </div>
          </div>

          <div class="swiper-slide">
            <img
              src=""
              alt="" />
            <div class="content">
              <div class="title">
                <h1>
                  <span class="white-point"></span> Proximamente 
                  <span class="white-point"></span>
                </h1>
              </div>
              <p>
                ...
              </p>
            </div>
          </div>

          <div class="swiper-slide">
            <img
              src=""
              alt="" />
            <div class="content">
              <div class="title">
                <h1>
                  <span class="white-point"></span> Proximamente
                  <span class="white-point"></span>
                </h1>
              </div>
              <p>
                
              </p>
            </div>
          </div>

          <div class="swiper-slide">
            <img
              src=""
              alt="" />
            <div class="content">
              <div class="title">
                <h1>
                  <span class="white-point"></span> Proximamente
                  <span class="white-point"></span>
                </h1>
              </div>
              <p>
                ...
              </p>
            </div>
          </div>
          
        </div>
        <div class="swiper-pagination"></div>
      </div>
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
     
        var swiper = new Swiper(".swiper", {
  spaceBetween: 30,
  centeredSlides: true,
  loop: true,
  autoplay: {
    delay: 4000,
    disableOnInteraction: false,
  },
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },
});
    </script>
</body>
</html>
