<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="java.sql.*,conexion.conectadita" %>
        <%
            int idUsuario=0;
            int idTipo=0;
            String nombre = request.getParameter("nombre");
            String apePat = request.getParameter("ap_paterno");
            String apeMat = request.getParameter("ap_materno");
            int telefono= Integer.parseInt(request.getParameter("phone"));
            String correo = request.getParameter("email");
            String contra = request.getParameter("pass");
            String dir=request.getParameter("dir");
            String rfc=request.getParameter("rfc");
            String curp=request.getParameter("curp");
            int cod= Integer.parseInt(request.getParameter("cod"));
            int idInfante=0;
            String nameni=request.getParameter("nameni");
            String ap_pater_ni=request.getParameter("ap_pater_ni");
            String ap_mater_ni=request.getParameter("ap_mater_ni");
            int edad= Integer.parseInt(request.getParameter("edad"));
            
            Connection con = null;
            ResultSet results = null;
            PreparedStatement pst = null;
            conectadita conecta = new conectadita();
            con = conecta.getConnection();
            String querystring1= "INSERT INTO Infante (idInfante,nombreInfante,apePatInfante,apeMatInfante,edadInfante) VALUES (?,?,?,?,?)";
            pst = con.prepareStatement(querystring1);
            pst.setInt(1,idInfante);
            pst.setString(2,nameni);
            pst.setString(3,ap_pater_ni);
            pst.setString(4,ap_mater_ni);
            pst.setInt(5,edad);
            pst.executeUpdate();
            
            String querystring = "INSERT INTO Usuario "
                    + "(IdUsuario,idTipoUsuario,idInfante,nombreUsuario,apePatUsuario,apeMatUsuario,correoUsuario,telUsuario,contrasena,"
                    + "direccionTutor,RFC,CURP,codigo) select ?,TT.idTipoUsuario,I.idInfante,?,?,?,?,?,?,?,?,?,? FROM Infante I JOIN TipoUsuario TT "
                    + "WHERE I.nombreInfante = ? and TT.idTipoUsuario = '2'";
            pst = con.prepareStatement(querystring);
            pst.setInt(1,idUsuario);
            pst.setString(2,nombre);
            pst.setString(3,apePat);
            pst.setString(4,apeMat);
            pst.setString(5,correo);
            pst.setInt(6,telefono);
            pst.setString(7,contra);
            pst.setString(8,dir);
            pst.setString(9,rfc);
            pst.setString(10,curp);
            pst.setInt(11,cod);
            pst.setString(12,nameni);
            pst.executeUpdate();
          
            con.close();
            %>
              <script>
            window.alert("Registro Exitoso, ahora puede iniciar sesión");
            window.location="login.jsp";
            </script>
    </body>
</html>
