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
    <header>
        <div class="navbar">
            <div class="navbar_wrapper">
                <nav class="navbar_menu">
                    <a class="navbar_brand" href="index.html">
                        <img src="imagenes/logo_bitcube.png" alt="Logo Bit-Cube">
                    </a>
                    <div id="nav-icon3">
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                    <ul class="navbar_nav">
                        <li class="navbar_link after-transform"><a href="index.html">Home</a></li>
                        <li class="navbar_link after-transform"><a href="registro.php">Registrarse</a></li>
                        <li class="navbar_link after-transform"><a href="iniciosesion.php">Iniciar sesión</a></li>
                        <li class="navbar_link after-transform"><a class="active" href="principal.html">Principal</a>
                        </li>
                        <li class="navbar_link after-transform"><a href="categorias.html">Categorías</a>
                        </li>
                        <li class="navbar_link after-transform"><a href="Pictogramas.html">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a href="videojuegos.html">Videojuegos</a></li>
                        <li class="navbar_link after-transform"><a href="calendario.html">Calendario</a></li>
                        <li class="navbar_link after-transform"><a href="perfil.html">Perfil</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="navbar-responsive">
            <ul class="navbar-responsive_nav">
                <li class="navbar-responsive_link after-transform"><a href="index.html">Home</a></li>
                <li class="navbar-responsive_link after-transform"><a href="registro.php">Registrarse</a></li>
                <li class="navbar-responsive_link after-transform"><a href="iniciosesion.php">Iniciar sesión</a></li>
                <li class="navbar-responsive_link after-transform"><a class="active" href="principal.html">Principal</a>
                </li>
                <li class="navbar-responsive_link after-transform"><a href="categorias.html">Categorías</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Pictogramas.html">Pictogramas</a></li>
                <li class="navbar-responsive_link after-transform"><a href="videojuegos.html">Videojuegos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="calendario.html">Calendario</a></li>
                <li class="navbar-responsive_link after-transform"><a href="perfil.html">Perfil</a></li>
            </ul>
        </div>
    </header>
    <div class="body">
        <h1>Bienvenido a Bit-Cube</h1>
        <p>aaa</p>
    </div>
    <footer>
        <div>
            <span class="logo">Bit-Cube</span>
        </div>
        <div class="row">
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                    <span class="footer-toggle"></span>
                    <span class="footer-cat">Acerca de nosotros</span>
                </div>
                
            </div>
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                    <span class="footer-toggle"></span>
                    <span class="footer-cat">Dirección</span>
                </div>
                
            </div>
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                    <span class="footer-toggle"></span>
                    <span class="footer-cat">Contacto</span>
                </div>
                
            </div>
            
            <div class="col-3" id="newsletter">

                <div class="social-links social-2">
                    <a href=""><i class="fab fa-facebook-f"></i></a>
                    <a href=""><i class="fab fa-instagram"></i></a>
                </div>


            </div>
            <div class="social-links social-1 col-6">
                <a href=""><i class="fab fa-facebook-f"></i></a>
                <a href=""><i class="fab fa-instagram"></i></a>
                
            </div>
        </div>
        <div id="copyright">
            &copy; Bit-Cube
        </div>
        <div id="owner">
            <span>
                Designed by <a href="http://kaizen.gerdoc.com/">Kaizen</a>
            </span>
        </div>
    </footer>
</body>

</html>