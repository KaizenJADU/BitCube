<%@page import="java.io.InputStream"%>
<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita,java.util.Base64" %>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar Pictograma</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="../styleprincipal.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="../stylefooterandheader.css">
    <link rel="stylesheet" href="../stylepictogramasadmin.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="../scriptprincipal.js"></script>
    <script src="https://kit.fontawesome.com/cb6271a172.js" crossorigin="anonymous"></script>
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
                        <li class="navbar_link after-transform"><a href="useradmin.jsp">Principal</a></li>
                        <li class="navbar_link after-transform"><a href="adminusuarios.jsp">Usuarios</a></li>
                        <li class="navbar_link after-transform"><a class="active" href="adminpictograma.jsp">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a href="soporteadmin.jsp">Soporte</a></li>
                        <li class="navbar_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="navbar-responsive">
            <ul class="navbar-responsive_nav">
                <li class="navbar-responsive_link after-transform"><a class="active" href='useradmin.jsp.jsp'>Principal</a></li>
                <li class="navbar-responsive_link after-transform"><a href='adminusuarios.jsp'>Usuarios</a></li>
                <li class="navbar-responsive_link after-transform"><a class="active" href="adminpictograma.jsp">Pictogramas</a>
                <li class="navbar-responsive_link after-transform"><a href="soporteadmin.jsp">Soporte</a>
                </li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
        
        <table border="1">
        <tr>
            <th>ID</th>
            <th>Imagen</th>
            <th>Audio</th>
            <th>Significado</th>
            <th>Acciones</th>
        </tr>
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
                Blob blob = resultSet.getBlob("imagen");
                Blob blob2 = resultSet.getBlob("audio");
                String significado = resultSet.getString("significado");
                InputStream inputStream = blob2.getBinaryStream();

                byte[] bytes = blob.getBytes(1, (int) blob.length());
                String base64Image = Base64.getEncoder().encodeToString(bytes);
                
                byte[] audioBytes = new byte[(int) blob2.length()];
                inputStream.read(audioBytes);
                inputStream.close();
                
                String base64EncodedAudio = Base64.getEncoder().encodeToString(audioBytes);
        %>
        <tr>
                    <td><%= idImagen %></td>
                    <td><img src="data:image/png;base64,<%= base64Image %>" alt="<%= significado %>"></td>
                    <td>
                        <audio controls>
                            <source src="data:audio/*;base64,<%= base64EncodedAudio %>" type="audio/mp3">
                        </audio>
                    </td>
                    <td><%= significado %></td>
                    <td class="action-buttons">
                        <button class="edit" onclick="mostrarModaledit(<%= idImagen %>)"><i class="fa-solid fa-pen-to-square" style="color: #ffffff;"></i></button>
                        <button class="delet" onclick="mostrarModal(<%= idImagen %>)"><i class="fa-solid fa-trash" style="color: #ffffff;"></i></button>

                    </td>
                </tr>   
                <div id="editemployeemodal_<%= idImagen %>" class="modal-fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form action="../EditarpictogramasServlet" method="post" enctype="multipart/form-data">
                                <label for="ima">Selecciona una imagen(PNG):</label>
                                <input type="file" name="ima" id="imagenss" value="<% out.print(resultSet.getBlob("imagen")); %>" accept="image/png">
                                <label for="auds">Selecciona un audio(MP3):</label>
                                <input type="file" name="auds" id="aud" value="<% out.print(resultSet.getBlob("audio")); %>" accept="audio/mp3">

                                <label for="significadoss">Escribe el significado:</label>
                                <input type="text"  class="text" name="significadoss" id="significad" 
                                       value="<% out.print(resultSet.getString("significado")); %>" autocomplete="off" />

                                <input type="hidden" name="idpic" id="pictogramaIds" value="<% out.print(resultSet.getInt("idImagen"));%>" />

                                <input type="button" id="cancelar" class="btn btn-default" onclick="cerrarModaledit(<%= idImagen %>)" value="Cancelar">
                                <button type="submit" class="edit"><i class="fa-solid fa-pen-to-square" style="color: #ffffff;"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
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
        <tr>
            <td style="border-bottom: 0;"></td>
            <td style="border-bottom: 0;">
                <form action="../SubirImagenServlet" method="post" enctype="multipart/form-data">
                    <br><input type="file" name="imagen" id="imagen" accept="image/*" required>
            </td>
            <td style="border-bottom: 0;">
                     <br><input type="file" name="audio" id="audio" accept="audio/*" required>
            </td>
            <td style="border-bottom: 0;">
                <br><input type="text" class="text" name="significado" id="significados" placeholder="P. ej., Escuchando música" required="required" />
            </td>
            <td style="border-bottom: 0;">
                <button class="btn" type="submit" ><i class="fa-solid fa-plus" style="color: #fff;"></i></button>
                </form>
            </td>
        </tr>
        </table>
        <div id="deleteEmployeeModal" class="modal-fade" >
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="eliminarjsp.jsp" method="post">
    <div class="modal-header">
        <h1 class="modal-title">Eliminar Pictograma</h1>
    </div>
    <div class="modal-body">
        <p>¿Estás seguro de que deseas eliminar este pictograma?</p>
        <p class="text-warning"><small>Esta acción no se puede deshacer.</small></p>
    </div>
    <input type="hidden" name="pictogramaId" id="pictogramaId" />
    <div class="modal-footer">
        <input type="button" id="cancelar" class="btn btn-default" onclick="cerrarModal()" value="Cancelar">
        <input type="submit" id="cerrarAviso" class="btn btn-danger" value="Eliminar">
    </div>
</form>

        </div>
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
    function mostrarModaledit(id) {
      document.getElementById('editemployeemodal_'+id).style.display = 'block';
    document.getElementById('pictogramaIds').value = id;
}

        function editarPictgrama() {
            document.getElementById('pictogramaIds').value = currentId;
            document.getElementById('editForm').submit();
        }
        function cerrarModaledit(id) {
            document.getElementById('editemployeemodal_'+id).style.display = 'none';
        }
        function mostrarModal(id) {
              document.getElementById('deleteEmployeeModal').style.display = 'block';
            document.getElementById('pictogramaId').value = id;
        }
        function cerrarModal() {
            document.getElementById('deleteEmployeeModal').style.display = 'none';
        }

        function eliminarPictograma() {
            document.getElementById('pictogramaId').value = currentId;
            document.getElementById('deleteForm').submit();
        }
    </script>
</body>
</html>

