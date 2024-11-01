<%@page import="java.util.List"%>
<%@page import="Beans.ClienteDAO" %>
<%@page import="Mapeos.Cliente" %>
<jsp:useBean id="uname" scope="page" class="Mapeos.Cliente" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css.css" title="style">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <form>
            <center>
                <h1>Acceso del cliente</h1>
                <div id="menu">
                    <ul>
                            <li><a href="Conocenos.jsp"  class = "normalMenu">Conocenos</a></li>
                            <li><a href="Productos.jsp"  class = "normalMenu">Productos </a></li>
                            <li><a href="Contacto.jsp"  class = "normalMenu">Contacto</a></li>
                            <li><a href="Acceso.jsp"  class = "normalMenu">Ingresar</a></li>
                            <li> <a href="registro.jsp"  class = "normalMenu">Registrate_Aquí</a></li>
                    </ul>
                </div>
                <div  id="formulario">
                <h2>Login</h2>
                    <table border="1" width="30%" cellpadding="3">
                        <tbody>
                            <tr>
                                <td>Nombre</td>
                                <td><input type="text" name="nombre" value="" /></td>
                            </tr>
                            <tr>
                                <td>Password</td>
                                <td><input type="password" name="password" value="" /></td>
                            </tr>
                            <tr>
                                <td><input type="submit" name="enviar" value="Entrar" /></td>
                                <td><input type="reset" value="Limpiar" /></td>
                            </tr>

                        </tbody>
                    </table>
                    <h4>No tienes cuenta? <a href="InsertarCliente.html">Crear cuenta</a></h4>
                    <a href="Principal.html">Pagina Principal</a>
                </div>
            </center>
        </form>
        <% if (request.getParameter("enviar") != null) {%>

        <jsp:setProperty name="uname" property="*" />
        <%
            boolean us = false;
            ClienteDAO DAOcliente = new ClienteDAO();
            Cliente cliente = DAOcliente.encontrarUsuario(uname.getNombre(), uname.getPassword());
            if(cliente != null){%>
                <center>
                    <h3>Bienvenido <% out.println(uname.getNombre().toString());%></h3>
                    <input type="button" onclick=" location.href = 'Ventas.jsp?id=<%=cliente.getIdCliente()%>'" value="Ir al carrito" name="boton" />
                </center>
            <%}
            else {%>
                <center>
                    <h3>NO TIENES UNA CUENTA, CREALA AHORA MISMO...</h3>
                    <a href="InsertarCliente.html">Crear cuenta</a>
                </center>
            <%}
        }
        %>
</body>
</html>
