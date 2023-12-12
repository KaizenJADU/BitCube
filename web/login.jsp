<%@page import="modelo.operaciones.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.operaciones, org.mindrot.jbcrypt.BCrypt"%>
<%@page session="true"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>

    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="stylefooterandheader.css">
    <link rel="stylesheet" href="styleiniciosesion.css">
     <script src="https://kit.fontawesome.com/cb6271a172.js" crossorigin="anonymous"></script>

    <style>

        
        .aviso-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            background-color: #D8F8D7;
            color: #721c24;
            padding: 10px;
            text-align: center;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        
    </style>
</head>
<body>
    <div class="container">
        <a href="index.html" style="margin: 1.2% 0 0 .2%;" ><i class="fa-solid fa-house fa-lg" style="color: #ffffff;  font-size: 35px"></i></a>
        <div class="form-container">
            <h3 class="title">Ya casi llegamos</h3>
            <p>Inserta tus datos para acceder</p>
            <form action="login.jsp" method="post">
    <div class="input-container">
        <label for="email" class="label">
            <i class="fas fa-user-alt"></i>
            Email
        </label>
        <input class="input" type="email" name="username" autocomplete="off" required> <!-- Cambia el name a "username" -->
    </div>
    <div class="input-container">
        <label for="password" class="label">
            <i class="fas fa-key"></i>
            Password
        </label>
        <input class="input" type="password" name="password" required>
    </div>
    <input type="submit" class="btn" name="login" id="logear" value="Iniciar sesión">
    <a href="" class="forgot-link">¿Olvidaste tu contraseña?</a>
</form>
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
                    <li><a href="Pictogramas.html"><span>Pictogramas</span></a></li>
                    <li><a href="videojuegos.html"><span>Videojuegos</span></a></li>
                    <li><a href="videos.html"><span>Videos</span></a></li>
                    <li><a href="categorias.html"><span>Categorias</span></a></li>
                </ul>
            </div>
            <div class="col-3">
                <div class="link-cat" onclick="footerToggle(this)">
                    <span class="footer-toggle"></span>
                    <span class="footer-cat">Links Rapidos</span>
                </div>
                <ul class="footer-cat-links">
                    <li><a href="index.html"><span>Home</span></a></li>
                    <li><a href="registrarse.html"><span>Regístrate</span></a></li>
                    <li><a href="login.jsp"><span>Inicia Sesión</span></a></li>
                    <li><a href="principal.html"><span>Principal</span></a></li>
                    <li><a href="perfil.html"><span>Perfil</span></a></li>
                    <li><a href="calendario.html"><span>Calendario</span></a></li>
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
        <script src="scriptfooter.js"></script>
    </footer>
    <script src="scriptiniciosesion.js"></script>
    
    <%
    String registroExitosoParam = request.getParameter("registroExitoso");
    if ("true".equals(registroExitosoParam) || "true".equals(request.getAttribute("registroExitoso"))) {
%>
        <div id="aviso" class="aviso-container">
            <i class="cerrar-icono bx bx-x" onclick="cerrarAviso()" style="color:red; cursor: pointer; font-size: 24px; margin-right: 100%"></i>
            <p style="margin: 0; padding-bottom: 2px; color: black;">Registro exitoso. Ahora puede iniciar sesión.</p>
        </div>
<%
    }
%>
<%
    operaciones op = new operaciones();

    if (request.getParameter("login") != null) {
        String correo = request.getParameter("username");
        String contra = request.getParameter("password");
        HttpSession sesion = request.getSession();

        Usuario usuario = op.loguear(correo, contra);

        if (usuario != null) {
            int idTipoUsuario = usuario.getIdTipoUsuario();
            String hashAlmacenado = usuario.getHashAlmacenado();

            if ((idTipoUsuario == 1 && contra.equals(hashAlmacenado)) || (idTipoUsuario == 2 && BCrypt.checkpw(contra, hashAlmacenado))) {
                sesion.setAttribute("user", correo);
                sesion.setAttribute("idTipo", String.valueOf(idTipoUsuario));

                switch (idTipoUsuario) {
                    case 1:
                        response.sendRedirect("useradmin.jsp");
                        break;
                    case 2:
                        response.sendRedirect("user.jsp");
                        break;
                    default:
                        out.write("Usuario no existe o contraseña inválida");
                        break;
                }
            } else {
                out.write("Usuario no existe o contraseña inválida");
            }
        } else {
            out.write("Ocurrió un error durante la autenticación");
        }
    }

    if (request.getParameter("cerrar") != null) {
        session.invalidate();
    }
%>


        <script>
        document.addEventListener("DOMContentLoaded", function () {
            mostrarAviso();
        });

        function mostrarAviso() {
            var aviso = document.getElementById("aviso");
            aviso.style.display = "block";
        }
        function cerrarAviso() {
            var aviso = document.getElementById("aviso");
            aviso.style.display = "none";
        }
    </script>
</body>

</html>