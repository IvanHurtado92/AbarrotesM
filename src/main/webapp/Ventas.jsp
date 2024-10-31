<%-- 
    Document   : Ventas
    Created on : 3/01/2014, 12:53:47 PM
    Author     : Search
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="Mapeos.Cliente"%> 
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page import="Beans.ClienteDAO"%>
<%@ page import="Beans.CarritoDAO" %>
<%@ page import="Mapeos.Carrito" %>
<jsp:useBean id="var1" scope="page" class="Mapeos.Producto" />
<jsp:useBean id="var2" scope="page" class="Mapeos.Cliente" />
<link rel="stylesheet" type="text/css" href="css.css" title="style">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>producto</title>
    </head>
    <body>
        <h1>Portal de información del producto</h1>
                <div id="menu">
                    <ul>
                            <li><a href="Conocenos.jsp"  class = "normalMenu">Conocenos</a></li>
                            <li><a href="Productos.jsp"  class = "normalMenu">Productos </a></li>
                            <li><a href="Contacto.jsp"  class = "normalMenu">Contacto</a></li>
                            <li><a href="Acceso.jsp"  class = "normalMenu">Ingresar</a></li>
                            <li> <a href="registro.jsp"  class = "normalMenu">Registrate_Aquí</a></li>
                    </ul>
                </div>

        <% ProductoDAO productoDAO = new ProductoDAO();

            ClienteDAO clienteDAO = new ClienteDAO();
            Cliente cliente = clienteDAO.obtenCliente(Integer.parseInt(request.getParameter("id")));
            Integer id_cliente = cliente.getIdCliente();

            CarritoDAO DAO = new CarritoDAO();
            List<Carrito> listacarrito = DAO.obtenCarritoPorCliente(id_cliente);
            Float total = 0f;
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Selecciona en la columna final el producto que deseas comprar.</I>.
                </HR>
                <I>----------  </I><tr><I>BIENBENID@ <%= cliente.getNombre()%></I></tr>
                    <I>----------  </I><th><I>HISTORIAL DE COMPRAS</I></th>
                <I>----------  </I><a href="Acceso.jsp">Cerrar Sesion</a>

                <table border="1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre producto</th>
                            <th>Presentacion</th>
                            <th>Caducidad</th>
                            <th>P. Unitario</th>
                            <th>Cantidad</th>
                            <th>Costo</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for(Carrito c : listacarrito){
                            ProductoDAO DAOproducto = new ProductoDAO();
                            Producto a = DAOproducto.obtenProducto(c.getIdProducto());
                            total += c.getPrecio();
                    %>
                    <tr>
                        <td><%= c.getIdCarrito()%></td>
                        <td><%= a.getNombreProducto()%></td>
                        <td><%= a.getPresentacion()%></td>
                        <td><%= a.getCaducidad()%></td>
                        <td><%= a.getPrecioUni()%></td>
                        <td><%= c.getCantidad()%></td>
                        <td><%= c.getPrecio()%></td>
                    </tr>
                        <%}%>
                    </tbody>
                </table>
                <h2>Gasto total: <%= total%></h2>
                <input type="button" onclick=" location.href = 'compra.jsp?id=<%=id_cliente%>'" value="Comprar mas" name="Comprar" />

            </CENTER>
        </form>
    </body>
</html>
