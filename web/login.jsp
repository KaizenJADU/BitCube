<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.operaciones"%>
<%@page  session="true"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>

    <link rel="stylesheet" href="stylefooterandheader.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <link rel="stylesheet" href="styleiniciosesion.css">


</head>

<body>
    <div class="container">
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
    <script src="scriptiniciosesion.js"></script>
     <%
        operaciones op = new operaciones();
            if (request.getParameter("login")!=null) {
                String correo = request.getParameter("username");
                String contra = request.getParameter("password");
                HttpSession sesion = request.getSession();
                
                switch(op.loguear(correo, contra)) {
                    case 1:
                        sesion.setAttribute("user", correo);
                        sesion.setAttribute("contras", contra);
                        sesion.setAttribute("idTipo", "1");
                        response.sendRedirect("JSP/useradmin.jsp");
                    break;
                    case 2:
                        sesion.setAttribute("user", correo);
                        sesion.setAttribute("contras", contra);
                        sesion.setAttribute("idTipo", "2");
                        response.sendRedirect("JSP/user.jsp");
                    break;
                    
                    default:
                        out.write("Usuario no existe o contraseña invalida");
                        break;
                }
            }
                if(request.getParameter("cerrar")!= null){
                session.invalidate();
              }
        
        %>
</body>

</html>