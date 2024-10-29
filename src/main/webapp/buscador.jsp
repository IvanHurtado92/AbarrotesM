<%@ page import="Beans.ProductoDAO" %>
<%@ page import="Mapeos.Producto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <link rel="stylesheet" type="text/css" href="css.css" title="style">
    <body>
        <h1>Portal de búsqueda de producto/s</h1>
        <div id="menu">
            <ul>
                <li><a href="Conocenos.jsp"  class = "normalMenu">Conocenos</a></li>
                <li><a href="Productos.jsp"  class = "normalMenu">Productos </a></li>
                <li><a href="Contacto.jsp"  class = "normalMenu">Contacto</a></li>
                <li><a href="Acceso.jsp"  class = "normalMenu">Ingresar</a></li>
                <li> <a href="registro.jsp"  class = "normalMenu">Registrate_Aquí</a></li>
            </ul>
        </div>
        <h1></h1>
        <h3><a href="Productos.jsp"> Regresar</a></h3>
        <center>
        <form>
            <h2>Ingrese el nombre del producto que desea buscar:</h2>
            <input type="text" name="palabra" value="">
            <br>
            <input type="submit" value="Buscar" name="busca">
            <h2></h2>
            <div id="resultados">
                <%
                    if(request.getParameter("busca") != null && !request.getParameter("palabra").isEmpty()){
                        ProductoDAO DAO = new ProductoDAO();
                        List<Producto> listaProductos = DAO.obtenListaProducto();
                        String buscado = request.getParameter("palabra");
                        List<Producto> productos = new ArrayList<>();

                        for(Producto p : listaProductos){
                            if(p.getNombreProducto().toLowerCase().contains(buscado.toLowerCase())){
                                productos.add(p);
                            }
                        }
                        if(!productos.isEmpty()){
                %>

                    <table border="1">
                        <thead>
                        <tr>
                            <th>Nombre producto</th>
                            <th>Presentacion</th>
                            <th>Caducidad</th>
                            <th>P. Unitario</th>
                            <th>Fecha</th>
                            <th>Marca</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%for(Producto p : productos){%>
                        <tr>
                            <td><%= p.getNombreProducto() %></td>
                            <td><%= p.getPresentacion() %></td>
                            <td><%= p.getCaducidad() %></td>
                            <td><%= p.getPrecioUni() %></td>
                            <td><%= p.getFech() %></td>
                            <td><%= p.getMarca() %></td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                <%
                    }
                    else {%>
                        <h2>No se encontraron resultados con ese texto</h2>
                    <%}
                    }%>
            </div>
            <h1><a href="Principal.html">Pagina Principal</a></h1>
        </form>
        </center>
    </body>
</html>