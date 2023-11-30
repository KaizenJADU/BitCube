<%@page import="java.io.IOException"%>
<%@page import="java.io.InputStream"%>
<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita,java.util.Base64,java.net.URLEncoder" %>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
     <%!
    public String base64EncodedAudio(int idImagen) {
        Connection connection = null;
        try {
            conectadita conecta = new conectadita();
            connection = conecta.getConnection();

            String query = "SELECT audio FROM ImagenPictograma WHERE idImagen = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, idImagen);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Blob blobAudio = resultSet.getBlob("audio");

                if (blobAudio != null) {
                    InputStream inputStream = blobAudio.getBinaryStream();
                    byte[] audioBytes = new byte[(int) blobAudio.length()];
                    inputStream.read(audioBytes);
                    inputStream.close();

                    return Base64.getEncoder().encodeToString(audioBytes);
                }
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return "";
    }
    %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pictogramas</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="../stylefooterandheader.css">
        <link rel="stylesheet" href="../stylepictogramas.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="../scriptprincipal.js"></script>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
                        <li class="navbar_link after-transform"><a class="active" href="Pictogramas.jsp">Pictogramas</a></li>
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
        <div style="position: relative; width: 40%;  margin: 5% 0 10% 20%;">
        <img src="../imagenes/autismo3.png" alt="alt" style="width: 100%;">
    <div style="position: absolute; background:#C8BDB4; width:80%; height: 80%; top: 70%; left: 100%;
         transform: translate(-50%, -50%);  padding: 3% 0 0 3%; color: black; font-size: 24px; ">
        <h2 style="font-weight: bold;">Pictogramas </h2>
        <p style="font-size: 1em; line-height: 1.6; margin: 1% 5% 0% 3%; text-align: justify;">Métodos interactivos para desarrollar la comunicación y el uso de palabras asociado con imágenes, de modo que desarrolle con facilidad la interacción con un mayor vocabulario en su entorno social.
        </p>
    </div>
</div>
          <table class="invisible-table">
    <%
    Connection connection = null;
    try {
        conectadita conecta = new conectadita();
        connection = conecta.getConnection();

        String query = "SELECT * FROM ImagenPictograma";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        while (resultSet.next()) {
            int idImagen = resultSet.getInt("idImagen");
            Blob blobImagen = resultSet.getBlob("imagen");
             Blob blob2 = resultSet.getBlob("audio");
            String significado = resultSet.getString("significado");
            InputStream inputStream = blob2.getBinaryStream();

            byte[] bytesImagen = blobImagen.getBytes(1, (int) blobImagen.length());
            String base64Image = Base64.getEncoder().encodeToString(bytesImagen);
            

            %>
            <tr data-audio="data:audio/mp3;base64,<%= base64EncodedAudio(idImagen) %>">
                <td>
                    <img src="data:image/png;base64,<%= base64Image %>" onclick="mostrarImagen(this)" alt="<%= significado %>">
                </td>
            </tr>
        <%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>
</table>

<div id="selectedImageContainer" class="image-container">
    <i class="cerrar-icono bx bx-x" title="Cerrar" onclick="cerrarAviso()"  style="font-size: 25px;"></i>
    <img id="selectedImage" src="" alt="Imagen seleccionada"><br>
    <audio id="selectedAudio" controls >
        <source src="" type="audio/*">
    </audio>
    <button class="llenar1" onclick="mostrarPopup()">Llenar</button>
    <div id="fillPopup" class="popup">
        <label for="missingWord">Palabra que falta:</label>
        <input type="text" id="missingWord" name="missingWord" required>
        <button onclick="llenarPalabra()">Llenar</button>
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
    function mostrarImagen(imgElement) {
        var imageUrl = imgElement.src;
        var audioUrl = imgElement.closest('tr').getAttribute('data-audio');

        document.getElementById('selectedImage').src = imageUrl;
        document.getElementById('selectedAudio').src = audioUrl;

        document.getElementById('selectedImageContainer').style.display = 'block';
        reproducirAudio();
    }

    function reproducirAudio() {
        var audioElement = document.getElementById('selectedAudio');
        audioElement.load();
    }

    function cerrarAviso() {
        ocultarElemento('selectedImageContainer');
        ocultarElemento('fillPopup');
    }

    function llenarPalabra() {
        var missingWord = document.getElementById('missingWord').value;
        alert('Palabra ingresada: ' + missingWord);
        ocultarElemento('fillPopup');
    }

    function mostrarPopup() {
        mostrarElemento('fillPopup');
    }

    function ocultarElemento(elementId) {
        var elemento = document.getElementById(elementId);
        if (elemento) {
            elemento.style.display = 'none';
        }
    }

    function mostrarElemento(elementId) {
        var elemento = document.getElementById(elementId);
        if (elemento) {
            elemento.style.display = 'block';
        }
    }
</script>
    </body>
    
</html>

