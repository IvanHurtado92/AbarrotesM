<%-- 
    Document   : EliminarProducto
    Created on : 19/11/2013, 07:11:05 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@ page import="Beans.CarritoDAO" %>
<%@ page import="Mapeos.Carrito" %>
<%@ page import="Beans.ClienteDAO" %>
<%@ page import="Mapeos.Cliente" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>producto</title>
</head>
<body>
<h1>Portal de información del producto</h1>
<% ProductoDAO productoDAO = new ProductoDAO();
    List<Producto> listaproductos = productoDAO.obtenListaProducto();
%>
    <CENTER>
        <HR>
        <I>Para comprar un producto seleccionarlo en la columna final y se habilitará el campo de cantidad <a href="Ventas.jsp?id=<%=request.getParameter("id")%>">Regresar</a></I>.
        <h2></h2>
        </HR>
        <form>
            <table border="1">
                <thead>
                <tr>
                    <th>Numero producto</th>
                    <th>Nombre producto</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Elegir</th>
                </tr>
                </thead>
                <tbody>
                <% for (Producto a : listaproductos) { %>
                <tr>
                    <td><%= a.getIdProducto() %></td>
                    <td><%= a.getNombreProducto() %></td>
                    <td><%= a.getPrecioUni() %></td>
                    <td>
                        <input type="number" id="cantidad_<%= a.getIdProducto() %>" name="cantidad"
                               min="0" max="<%= a.getExistencias() %>" value="1" disabled>
                    </td>
                    <td>
                        <input type="checkbox" name="cbcompra" value="<%= a.getIdProducto() %>"
                               onclick="toggleCantidad(<%= a.getIdProducto() %>)">
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

            <script>
                function toggleCantidad(id) {
                    // Enable or disable the cantidad input based on the checkbox state
                    var cantidadInput = document.getElementById("cantidad_" + id);
                    cantidadInput.disabled = !cantidadInput.disabled;
                }
            </script>
            <h2></h2>
            <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
            <input type="submit" value="Comprar Seleccionados" name="comprar" />
        </form>
        <%
            if (request.getParameter("comprar") != null) {
                String[] chbcompras = request.getParameterValues("cbcompra");
                String[] cantidades = request.getParameterValues("cantidad");
                CarritoDAO DAO = new CarritoDAO();
                Carrito carrito = new Carrito();
                Integer id_cliente = Integer.parseInt(request.getParameter("id"));
                ProductoDAO DAOproducto = new ProductoDAO();
                Producto producto;
                ClienteDAO DAOcliente = new ClienteDAO();
                Cliente cliente;

                if(chbcompras != null && chbcompras.length > 0){
                    cliente = DAOcliente.obtenCliente(id_cliente);
                    Integer grupo = cliente.getCarrito() + 1;
                    for (int i = 0; i < chbcompras.length; i++) {
                        if(!cantidades[i].equals("0")){
                            producto = DAOproducto.obtenProducto(Integer.parseInt(chbcompras[i]));
                            carrito.setGrupoCarrito(grupo);
                            carrito.setIdCliente(id_cliente);
                            carrito.setIdProducto(Integer.parseInt(chbcompras[i]));
                            carrito.setCantidad(Integer.parseInt(cantidades[i]));
                            carrito.setPrecio(producto.getPrecioUni()*carrito.getCantidad());
                            producto.setExistencias(producto.getExistencias()-carrito.getCantidad());
                            DAOproducto.actualizaProducto(producto);

                            DAO.guardarCarrito(carrito);
                        }
                    }
                    cliente.setCarrito(grupo);
                    DAOcliente.actualizaCliente(cliente);
                    System.out.println(grupo);
                    out.println("Producto/s Comprado/s");
                } else {
                    out.println("<p>Debes seleccionar al menos un producto para comprarlo.</p>");
                }

            }
        %>
    </center
</body>
</html>
