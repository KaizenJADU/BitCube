<html lang="en">

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
            <form action="iniciosesion.php" method="POST" id="login">
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

                <?php
                require 'conexionbd.php';

                if (isset($_POST['login'])) {
                    $email = trim($_POST['email']);
                    $contra = trim($_POST['password']);

                    $sql = "SELECT u.IdUsuario,u.correoUsuario, u.contrasena,u.nombreUsuario,tu.idTipoUsuario, tu.nombreUsuario as rol
                    FROM Usuario u left join TipoUsuario tu ON u.idTipoUsuario = tu.idTipoUsuario
                    where correoUsuario = '$email' AND contrasena= '$contra'";
                    $resulbusc = mysqli_query($conn, $sql);
                    $row = $resulbusc->fetch_assoc();
                    if (!$resulbusc) {
                        echo "Error en la consulta: " . mysqli_error($conn);
                    } else {
                        if (mysqli_num_rows($resulbusc) > 0) {
                            session_start();
                            $_SESSION['user'] = $email;
                            $_SESSION['rol'] = $row['rol'];
                            header("Location: principal.php");
                        } else {
                            header("Location: index.html");
                        }
                    }
                }
                ?>


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