<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <form action="login.jsp" method="post" id="login">
                <div class="input-container">
                    <label for="email" class="label">
                        <i class="fas fa-user-alt"></i>
                        Email
                    </label>
                    <input class="input" type="email" name="email" autocomplete="off" required>
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
                    <%@ page import="java.sql.*" %>
                    <%@ page import="conexion.conectadita" %>

                    <%
                    if (request.getParameter("login")!=null) {
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    conectadita conecta = new conectadita();
                    Connection con = conecta.getConnection();

                    String query = "SELECT * FROM Usuario WHERE correoUsuario = ? AND contrasena = ?";
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, email);
                    pst.setString(2, password);

                    ResultSet rs = pst.executeQuery();

                    if (rs.next()) {
                        response.sendRedirect("principal.jsp");
                    } else {
                        response.sendRedirect("login.jsp?error=usuario o contraseña incorrectos");
                    }
                    con.close();
                        }
                        %>

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
</body>

</html>