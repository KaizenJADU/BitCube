<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrarse</title>

    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="styleregistrarse.css">
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="stylefooterandheader.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>

<body>

    <?php
    if (!empty($message)):
        ?>
        <p>
            <?= $message ?>
        </p>
    <?php endif; ?>
    <div class="container" id="container">
        <div class="overlay">
        </div>
        <div class="overlay-container">
            <form action="registro.php" method="post" onsubmit="validateCaptcha()" id="registro">
                <h1>Regístrate</h1>
                <p>Únete a Bit-Cube y da alas a los sueños de niños con Autismo.</p>
                <h2>Datos del Tutor</h2>
                <div class="input-row">
                    <div class="input-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" placeholder="P. ej., Julia" autocomplete="off"
                            required />
                    </div>
                    <div class="input-group">
                        <label for="ap_paterno">Apellido paterno:</label>
                        <input type="text" id="ap_paterno" name="apepaterno" placeholder="P. ej., García"
                            autocomplete="off" required />
                    </div>
                </div>
                <div class="input-row">
                    <div class="input-group">
                        <label for="ap_materno">Apellido materno:</label>
                        <input type="text" id="ap_materno" name="apematerno" placeholder="P. ej., García"
                            autocomplete="off" required />
                    </div>
                    <div class="input-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" placeholder="P. ej., email@ejemplo.com"
                            autocomplete="off" />
                    </div>
                </div>
                <div class="input-row">
                    <div class="input-group">
                        <label for="telefono">Teléfono:</label>
                        <input type="number" id="telefono" name="tel" placeholder="P. ej., 555-555-555"
                            autocomplete="off" />
                    </div>
                    <div class="input-group">
                        <label for="contrasena">Contraseña:</label>
                        <input type="password" id="contrasena" name="contrasena" placeholder="Ingresa una contraseña"
                            autocomplete="off" required />
                    </div>
                </div>
                <div class="input-row">
                    <div class="input-group">
                        <label for="direccion">Dirección:</label>
                        <input type="text" id="direccion" name="dir" placeholder="P. ej., calle num.ext, num.int"
                            autocomplete="off" />
                    </div>
                    <div class="input-group">
                        <label for="rfc">RFC:</label>
                        <input type="text" id="rfc" name="rfc" placeholder="Ingresa tu RFC" autocomplete="off"
                            required />
                    </div>
                </div>
                <div class="input-row">
                    <div class="input-group">
                        <label for="curp">CURP:</label>
                        <input type="text" id="curp" name="curp" placeholder="Ingresa tu CURP" autocomplete="off" />
                    </div>
                    <div class="input-group">
                        <label for="codigo">Código:</label>
                        <input type="password" name="codigo" id="codigo" placeholder="Ingresa codigo" autocomplete="off"
                            required />
                    </div>
                </div>
                <div class="ninos">
                    <h2 style="margin-top: 10px; margin-bottom: 0px;">Datos del niño</h2>
                    <div class="input-row">
                        <div class="input-group">
                            <input type="text" name="nomnino" placeholder="Ingresa el nombre del niño"
                                autocomplete="off" required />
                            <input type="text" id="apepaternonino" name="apepaternonino"
                                placeholder="Ingresa el apellido paterno del niño" autocomplete="off" required />
                            <input type="text" id="apematernonino" name="apematernonino"
                                placeholder="Ingresa el apellido materno del niño" autocomplete="off" required />
                            <input type="number" name="edadnino" placeholder="Edad" />
                        </div>
                        <div class="input-group">
                            <div id="captcha">
                            </div>

                            <input type="submit" id="enviar" name="registrar" value="Registrarse">

                        </div>
                    </div>
                </div>
                <?php
                require 'conexionbd.php';
                $message = '';

                if (isset($_POST['registrar'])) {
                    $nombre = trim($_POST['nombre']);
                    $apepaterno = trim($_POST['apepaterno']);
                    $apematerno = trim($_POST['apematerno']);
                    $email = trim($_POST['email']);
                    $telefono = ($_POST['tel']);
                    $contra = trim($_POST['contrasena']);
                    $direccion = trim($_POST['dir']);
                    $rfc = trim($_POST['rfc']);
                    $curp = trim($_POST['curp']);
                    $codigo = trim($_POST['codigo']);
                    $nombreni = trim($_POST['nomnino']);
                    $apepaternoni = trim($_POST['apepaternonino']);
                    $apematernoni = trim($_POST['apematernonino']);
                    $edad = trim($_POST['edadnino']);
                    $sql2 = "INSERT INTO Infante(nombreInfante,apePatInfante,apeMatInfante,edadInfante) 
                        VALUES ('$nombreni','$apepaternoni','$apematernoni','$edad')";
                    $resul2 = mysqli_query($conn, $sql2);
                    $sqlbusc = "SELECT idInfante fROM Infante WHERE apePatInfante ='$apepaternoni' and apeMatInfante = '$apematernoni'";
                    $resulbusc = mysqli_query($conn, $sqlbusc);
                    $idinfante = mysqli_fetch_column($resulbusc);
                    $sqlbusc2 = "SELECT idTipoUsuario fROM TipoUsuario WHERE nombreUsuario = 'Usuario'";
                    $resulbusc2 = mysqli_query($conn, $sqlbusc2);
                    $idtipousu = mysqli_fetch_column($resulbusc2);
                    $sql1 = "INSERT INTO Usuario(idTipoUsuario,idInfante,nombreUsuario,apePatUsuario,apeMatUsuario,correoUsuario,
                                                    telUsuario,contrasena,direccionTutor,RFC,CURP,codigo) 
                        VALUES ('$idtipousu','$idinfante','$nombre', '$apepaterno','$apematerno','$email','$telefono','$contra','$direccion','$rfc',
                        '$curp','$codigo')";
                    $resul = mysqli_query($conn, $sql1);
                    if ($resul && $resul2) {
                        echo "Registro exitoso";
                    } else {
                        echo "Error al registrar: " . mysqli_error($conn);
                    }
                } else {
                    echo "Completa todos los campos del formulario";
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


</body>

</html>