<%@page session="true"%>
<%@page import="java.sql.*,conexion.conectadita" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Lato|Nanum+Gothic:700|Raleway&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="../stylefooterandheader.css">
        <link rel="stylesheet" href="../styleperfil.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="../scriptprincipal.js"></script>
        <script src="https://kit.fontawesome.com/cb6271a172.js" crossorigin="anonymous"></script>

    </head>
    <body>
          <%
        HttpSession sesion = request.getSession();
        String usuario;
        String idTipo;
        String contra;

        if(sesion.getAttribute("user") != null && sesion.getAttribute("idTipo") != null){
            usuario = sesion.getAttribute("user").toString();
            idTipo = sesion.getAttribute("idTipo").toString();
            Connection conec = null;
            PreparedStatement pstat = null;
            ResultSet results = null;
            conectadita conecta = new conectadita();
            conec = conecta.getConnection();

            try {
                String query = "SELECT u.IdUsuario, u.nombreUsuario,u.apePatUsuario, u.apeMatUsuario, i.nombreInfante, i.apePatInfante,"
                + "i.apeMatInfante, i.edadInfante,i.sexo,u.correoUsuario,u.telUsuario,u.contrasena, u.RFC,u.codigo,"
                + "d.idAntecedentes,d.fechaDiagnostico,d.condicionesMedicas,d.tratamientosMedicos,d.alergias,d.registroVisitas,d.listaMedicamentos"
                + " FROM Usuario u LEFT JOIN Infante i ON u.idInfante = i.idInfante LEFT JOIN "
                + "Diagnostico d ON i.idAntecedentes = d.idAntecedentes WHERE u.correoUsuario=?";
                pstat = conec.prepareStatement(query);
                pstat.setString(1, usuario); 

                results = pstat.executeQuery();

                while (results.next()) {
    %>
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
                        <li class="navbar_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                        <li class="navbar_link after-transform"><a href="Videos.jsp">Videos</a></li>
                        <li class="navbar_link after-transform"><a href="Calendario.jsp">Calendario</a></li>
                        <li class="navbar_link after-transform"><a class="active" href="perfil.jsp">Perfil</a></li>
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
                <li class="navbar-responsive_link after-transform"><a href="Videojuegos.jsp">Videojuegos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Videos.jsp">Videos</a></li>
                <li class="navbar-responsive_link after-transform"><a href="Calendario.jsp">Calendario</a></li>
                <li class="navbar-responsive_link after-transform"><a class="active" href="perfil.jsp">Perfil</a></li>
                <li class="navbar-responsive_link after-transform"><a href='../login.jsp?cerrar=true'>Cerrar Sesión</a></li>
            </ul>
        </div>
    </header>
         <div class="container">
  <div id="logos"><h1 class="logos"><% out.print(results.getString("u.nombreUsuario")); %> </h1>
    <div class="CTA">
      <h1></h1>
      </div>
  </div>
  <div class="leftbox">
      <nav class="navba">
      <a id="profile" class="activee"><i class="fa-solid fa-user" style="color: #ffffff;"></i></a>
      <a id="payment"><i class="fa-solid fa-child-reaching" style="color: #ffffff;"></i></a>
      <a id="subscription"><i class="fa-solid fa-stethoscope" style="color: #ffffff;"></i></a>
      <a id="privacy"><i class="fa-solid fa-chart-simple" style="color: #ffffff;"></i></a>
      <a id="settings"><i class="fa-solid fa-gear" style="color: #ffffff;"></i></a>
    </nav>
  </div>
  <div class="rightbox">
    <div class="profile">
      <h1>Información Tutor</h1>
      <h2>Nombre</h2>
      <input type="text" class="p" value="<% out.print(results.getString("u.nombreUsuario")); %>"> 
      <h2>Apellido Paterno</h2>
      <input type="text" class="p" value="<% out.print(results.getString("u.apePatUsuario")); %>"> 
      <h2>Apellido Materno</h2>
      <input type="text" class="p" value="<% out.print(results.getString("u.apeMatUsuario")); %>"> 
      <h2>Correo</h2>
       <input type="text" class="p" value="<% out.print(results.getString("u.correoUsuario")); %>"> 
      <h2>Teléfono</h2>
        <input type="number" class="p" value="<% out.print(results.getInt("u.telUsuario")); %>"> 
      <h2>RFC</h2>
        <input type="text" class="p" value="<% out.print(results.getString("u.RFC")); %>">
      <h2>Código</h2>
      <input type="password" class="p" value="<% out.print(results.getInt("u.Codigo")); %>">
      <h2>Contraseña</h2>
      <input type="password" class="p" value="<% out.print(results.getString("u.contrasena")); %>">
    </div>
    
    <div class="payment noshow">
      <h1>Información Infante</h1>
      <h2>Nombre</h2>
      <input type="text" class="p" value="<% out.print(results.getString("i.nombreInfante")); %>"> 
      <h2>Apellido Paterno</h2>
        <input type="text" class="p" value="<% out.print(results.getString("i.apePatInfante")); %>"> 
      <h2>Apellido Materno</h2>
        <input type="text" class="p" value="<% out.print(results.getString("i.apeMatInfante")); %>"> 
      <h2>Edad</h2>
      <input type="number" class="p" value="<% out.print(results.getInt("i.edadInfante")); %>">
      <h2></h2>
        <input type="radio" name="sexo" id="hombre_" value="Hombre" <%= "Hombre".equals(results.getString("i.sexo")) ? "checked" : "" %> />
<label class="radio" for="hombre_">Hombre</label>
<input type="radio" name="sexo" id="mujer_" value="Mujer" <%= "Mujer".equals(results.getString("i.sexo")) ? "checked" : "" %> />
<label class="radio" for="mujer_">Mujer</label>
    </div>

    <div class="subscription noshow">
      <h1>Diagnóstico</h1>
      <h2>Fecha</h2>
      <input type="date" class="p" value="<% out.print(results.getDate("d.fechaDiagnostico")); %>">
      <h2>Condiciones</h2>
        <input type="text" class="p" value="<% out.print(results.getString("d.condicionesMedicas")); %>"> 
      <h2>Tratamientos</h2>
        <input type="text" class="p" value="<% out.print(results.getString("d.tratamientosMedicos")); %>"> 
      <h2>Alergias</h2>
        <input type="text" class="p" value="<% out.print(results.getString("d.alergias")); %>"> 
      <h2>Visitas</h2>
        <input type="text" class="p" value="<% out.print(results.getString("d.registroVisitas")); %>"> 
      <h2>Medicamentos</h2>
        <input type="text" class="p" value="<% out.print(results.getString("d.listaMedicamentos")); %>"> 
    </div>

    <div class="privacy noshow">
      <h1>Progreso</h1>
      <h1>Proximamente...</h1>
      <h2><button class="btn"></button></h2>
      <p></p>
      <h2><button class="btn"></button></h2>
      <p></p>
      <h2><button class="btn"></button></h2>
      <p></p>
      <h2><button class="btn"></button></h2>
      <p></p>
      <h2><button class="btn"></button></h2>
      <p></p>
    </div>
 <div class="settings noshow">
      <h1>Configuración</h1>
      <h2><button class="btn"></button></h2>
     <div class="toggle-switch">
    <label>
      <span class="label-one">Modo Infante</span>
      <input type="checkbox" id="chec" onclick="cambiarColor()">
      <span class="toggle-switch-placeholder">
        <span class="on-off"></span>
      </span>
    </label>
  </div>
      <h2><button class="btn"></button></h2>
      <p></p>
      <h2><button class="btn"></button></h2>
      <p></p>
      <h2><button class="btn"></button></h2>
      <p></p>
      <h2><button class="btn"></button></h2>
   <p></p>
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
           <script src="../scriptperfi.js"></script>
           <script>
function cambiarColor() {
    var checkbox = document.getElementById('chec');
    var texto = document.querySelector('.label-one');

    if (checkbox.checked) {
        texto.style.color = '#00BE74';
    } else {
        texto.style.color = 'black';
    }
     texto.style.transition = 'color 0.3s ease';
}
</script>
                 <%
        }
           }
          catch (SQLException error) {
                out.print(error.toString());
            }
            conec.close();
          }
            else{
            out.println("<script>location.replace('login.jsp');</script>");
            }
        %>
    </footer>
    </body>
</html>
