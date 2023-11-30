<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="../styleprincipal.css">
    <link rel="stylesheet" href="../stylefooterandheader.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                        <li class="navbar_link after-transform"><a class="active" href="adminusuarios.jsp">Usuarios</a></li>
                        <li class="navbar_link after-transform"><a href="adminpictograma.jsp">Pictogramas</a></li>
                        <li class="navbar_link after-transform"><a href="comentarios.jsp">Comentarios</a></li>
                        <li class="navbar_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
                    </ul>
                </nav>
            </div>
        </div>
        <div class="navbar-responsive">
            <ul class="navbar-responsive_nav">
                <li class="navbar-responsive_link after-transform"><a href='useradmin.jsp.jsp'>Principal</a></li>
                <li class="navbar-responsive_link after-transform"><a class="active" href='adminusuarios.jsp'>Usuarios</a></li>
                <li class="navbar-responsive_link after-transform"><a href="adminpictograma.jsp">Principal</a>
                <li class="navbar-responsive_link after-transform"><a href="comentarios.jsp">Comenatrios</a>
                </li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
        <table border="1">
        <tr>
            <th>ID</th>
            <th>Usuario</th>
            <th>Paterno Usuario</th>
            <th>Materno Usuario</th>
            <th>Infante</th>
            <th>Paterno Infante</th>
            <th>Materno Infante</th>
            <th>Correo del Usuario</th>
            <th>Telefeno del Usuario</th>
            <th>Contraseña</th>
            <th>RFC</th>
            <th>Código</th>
            <th>Acciones</th>
        </tr>
        <%
            Connection connection = null;
            try {
                conectadita conecta = new conectadita();
                connection = conecta.getConnection();

               String query = "SELECT u.IdUsuario, u.nombreUsuario, u.apePatUsuario, u.apeMatUsuario, i.nombreInfante, i.apePatInfante, i.apeMatInfante, i.edadInfante, i.sexo, u.correoUsuario, u.telUsuario, u.contrasena, u.RFC, u.codigo FROM Usuario u LEFT JOIN Infante i ON u.idInfante = i.idInfante WHERE u.idTipoUsuario = 2";

                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query);

                 while (resultSet.next()) {
    int idUsuario = resultSet.getInt("IdUsuario");
    String nombreUsuario = resultSet.getString("nombreUsuario");
    String apePatUsuario = resultSet.getString("apePatUsuario");
    String apeMatUsuario = resultSet.getString("apeMatUsuario");
    String nombreInfante = resultSet.getString("nombreInfante");
    String apePatInfante = resultSet.getString("apePatInfante");
    String apeMatInfante = resultSet.getString("apeMatInfante");
    int edadInfante = resultSet.getInt("edadInfante");
    String sexo = resultSet.getString("sexo");
    String correoUsuario = resultSet.getString("correoUsuario");
    String telUsuario = resultSet.getString("telUsuario");
    String contrasena = resultSet.getString("contrasena");
    String RFC = resultSet.getString("RFC");
    int codigo = resultSet.getInt("codigo");


        %>
        <tr>
    <td><%= idUsuario %></td>
    <td><%= nombreUsuario %></td>
    <td><%= apePatUsuario %></td>
    <td><%= apeMatUsuario %></td>
    <td><%= nombreInfante %></td>
    <td><%= apePatInfante %></td>
    <td><%= apeMatInfante %></td>
    <td><%= correoUsuario %></td>
    <td><%= telUsuario %></td>
    <td><%= contrasena %></td>
    <td><%= RFC %></td>
    <td><%= codigo %></td>
    <td class="action-buttons">
        <button class="edit" onclick="mostraredit(<%= idUsuario %>, '<%= sexo %>')">
    <i class="fa-solid fa-pen-to-square" style="color: #ffffff;"></i>
</button>
        <button class="delet" onclick="mostrarModal(<%= idUsuario %>)"><i class="fa-solid fa-trash" style="color: #ffffff;"></i></button>
    </td>
</tr>
  <div id="editemployeemodal_<%= idUsuario %>" class="modal-fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="editarUsuarios.jsp" method="post" onsubmit="validateCaptcha()" id="registro">
                            <div class="input-row">
                                    <div class="input-group">
                                            <label for="nombre">Nombre:</label>
                                            <input type="text" id="nombre" name="nombre"
                                                   value="<% out.print(resultSet.getString("nombreUsuario")); %>"placeholder="P. ej., Julia" autocomplete="off" required/>
                                    </div>
                                    <div class="input-group">
                                            <label for="ap_paterno">Apellido paterno:</label>
                                            <input type="text" id="ap_paterno"
                                                   value="<% out.print(resultSet.getString("apePatUsuario")); %>" name="ap_paterno" placeholder="P. ej., García" autocomplete="off" required/>
                                    </div>
                            </div>
                            <div class="input-row">
                                    <div class="input-group">
                                            <label for="ap_materno">Apellido materno:</label>
                                            <input type="text" id="ap_materno" value="<% out.print(resultSet.getString("apeMatUsuario")); %>" name="ap_materno" placeholder="P. ej., García" autocomplete="off" required/>
                                    </div>
                                    <div class="input-group">
                                            <label for="email">Email:</label>
                                            <input type="email" id="email" name="email" value="<% out.print(resultSet.getString("correoUsuario")); %>"
                                                   placeholder="P. ej., email@ejemplo.com" autocomplete="off"/>
                                    </div>
                            </div>
                            <div class="input-row">
                                    <div class="input-group">
                                            <label for="telefono">Teléfono:</label>
                                            <input type="number" id="telefono"
                                                   value="<% out.print(resultSet.getString("telUsuario")); %>" name="phone" placeholder="P. ej., 555-555-555" autocomplete="off"/>
                                    </div>
                                    <div class="input-group">
                                            <label for="contrasena">Contraseña:</label>
                                            <input type="password" id="contrasena" name="pass" 
                                                   value="<% out.print(resultSet.getString("contrasena")); %>" placeholder="Contraseña" autocomplete="off" required/>
                                    </div>
                            </div>
                            <div class="input-row">
                                    <div class="input-group">
                                            <label for="rfc">RFC:</label>
                                            <input type="text" id="rfc" name="rfc" placeholder="RFC" 
                                                   value="<% out.print(resultSet.getString("RFC")); %>" autocomplete="off" required/>
                                    </div>
                                    <div class="input-group">
                                            <label for="codigo">Código:</label>
                                            <input type="password" id="codigo" value="<% out.print(resultSet.getString("codigo")); %>" name="cod" placeholder="Ingresa un codigo" autocomplete="off" required/>
                                        </div>
                            </div>
                           
                            <div class="ninos">
                                    <h2 style="margin-top: 10px; margin-bottom: 0px;">Datos del niño</h2>
                                    <div class="input-row">
                                            <div class="input-group">
                                                <input type="text" name="nameni" value="<% out.print(resultSet.getString("nombreInfante")); %>" placeholder="Nombre del niño" autocomplete="off" required/>
                                                <input type="number" name="edad" value="<% out.print(resultSet.getInt("edadInfante")); %>" placeholder="Edad" />
                                            </div>
                                        <div class="input-group">
                                            <input type="text" name="ap_pater_ni" value="<% out.print(resultSet.getString("apePatInfante")); %>" placeholder="Apellido paterno del niño" autocomplete="off" required/>
                                            <input type="text" name="ap_mater_ni"  value="<% out.print(resultSet.getString("apeMatInfante")); %>" placeholder="Apellido materno del niño" autocomplete="off" required/>
                                        </div>
                                    </div>
                                    </div>
                                     <div class="input-row">
        <div class="input-group">
            <input type="radio" name="sexo" id="hombre_<%= idUsuario %>" value="Hombre" required/>
            <label class="radio" for="hombre_<%= idUsuario %>">Hombre</label>
        </div>
        <div class="input-group" style="margin-bottom: 3%;">
            <input type="radio" name="sexo" id="mujer_<%= idUsuario %>" value="Mujer" required/>
            <label class="radio" for="mujer_<%= idUsuario %>">Mujer</label>
        </div>
    </div>
                                            <input type="hidden" name="idUsuario" value="<% out.print(resultSet.getInt("IdUsuario"));%>" >
                            <input type="submit" id="enviar" name="registrar" value="Registrarse">
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
        
    </table>
        <div id="deleteEmployeeModal" class="modal-fade" >
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="eliminarusuarios.jsp" method="post">
    <div class="modal-header">
        <h1 class="modal-title">Eliminar Usuario</h1>
    </div>
    <div class="modal-body">
        <p>¿Estás seguro de que deseas eliminar este Usuario?</p>
        <p class="text-warning"><small>Esta acción no se puede deshacer.</small></p>
    </div>
    <input type="hidden" name="idUsuario" id="idUsuario" />
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

function mostraredit(id,sexo){
            document.getElementById('editemployeemodal_' + id).style.display = 'block';
            document.getElementsByName('idUsuario').value = id;
     if (sexo === 'Hombre') {
            document.getElementById('hombre_' + id).checked = true;
        } else if (sexo === 'Mujer') {
            document.getElementById('mujer_' + id).checked = true;
        }
    }
        function cerrarModaledit() {
            document.getElementById('editemployeemodal').style.display = 'none';
        }
        function mostrarModal(id) {
              document.getElementById('deleteEmployeeModal').style.display = 'block';
            document.getElementById('idUsuario').value = id;
        }
        function cerrarModal() {
            document.getElementById('deleteEmployeeModal').style.display = 'none';
        }

    </script>
    </body>
</html>
