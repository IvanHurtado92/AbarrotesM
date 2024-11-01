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
<%@ page import="java.util.Collections" %>
<%@ page import="Beans.CarritoActDAO" %>
<%@ page import="Mapeos.CarritoAct" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>producto</title>
</head>
<body>
<h1>Portal de información del producto</h1>
<%
    ProductoDAO DAOproducto = new ProductoDAO();
    CarritoActDAO DAOcarritoAct = new CarritoActDAO();
    ClienteDAO DAOcliente = new ClienteDAO();
    Integer id_cliente = Integer.parseInt(request.getParameter("id"));
    Float total = 0f;

    List<CarritoAct> listaCarritoAct = DAOcarritoAct.obtenListaCarrito();
%>
    <CENTER>
        <HR>
        <I>Para comprar un producto seleccionarlo en la columna final y se habilitará el campo de cantidad <a href="Ventas.jsp?id=<%=request.getParameter("id")%>">Regresar</a></I>.
        <h2></h2>
        </HR>
        <form>
            <h2>Buscador</h2>
            <h3>Ingresa la id del producto que buscas</h3>
            <input type="hidden" name="id" value="<%=id_cliente%>">
            <input type="number" id="idprod" name="idprod" min="1" max="<%= DAOproducto.contarProductos() %>">
            <input type="submit" name="buscar" value="busca">
        </form>
            <%
            if(request.getParameter("buscar") != null){

                Producto a = DAOproducto.obtenProducto(Integer.parseInt(request.getParameter("idprod")));
                %>
        <br>
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
                <tr>
                    <td><%= a.getIdProducto() %></td>
                    <td><%= a.getNombreProducto() %></td>
                    <td><%= a.getPrecioUni() %></td>
                    <td>
                        <input type="number" id="cantidad_<%= a.getIdProducto() %>" name="cantidad"
                               min="0" max="<%= a.getExistencias() %>" disabled>
                    </td>
                    <td>
                        <input type="checkbox" name="habilitar" value="<%= a.getIdProducto() %>"
                               onclick="toggleCantidad(<%= a.getIdProducto() %>)">
                    </td>
                </tr>
                </tbody>
            </table>

            <script>
                function toggleCantidad(id) {
                    // Enable or disable the cantidad input based on the checkbox state
                    var cantidadInput = document.getElementById("cantidad_" + id);
                    cantidadInput.disabled = !cantidadInput.disabled;
                }
            </script>
            <input type="hidden" name="idprod" value="<%=a.getIdProducto()%>">
            <input type="hidden" name="precio" value="<%=a.getPrecioUni()%>">
            <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
            <input type="submit" value="Agregar" name="agrega" onclick="">
        </form>
            <%
                }
            if(request.getParameter("agrega") != null){
                System.out.println("Dentrooooo");

                Cliente cliente = DAOcliente.obtenCliente(id_cliente);
                Integer grupo = cliente.getCarrito() + 1;

                Integer idProd = Integer.parseInt(request.getParameter("idprod"));
                Integer cantidad = Integer.parseInt(request.getParameter("cantidad"));
                Float precio = Float.parseFloat(request.getParameter("precio"));

                CarritoAct carrito = new CarritoAct();
                carrito.setGrupoCarrito(grupo);
                carrito.setIdCliente(id_cliente);
                carrito.setIdProducto(idProd);
                carrito.setCantidad(cantidad);
                carrito.setPrecio(precio*cantidad);

                // Producto producto = DAOproducto.obtenProducto(idProd);
                // producto.setExistencias(producto.getExistencias()-cantidad);
                // DAOproducto.actualizaProducto(producto);

                DAOcarritoAct.guardarCarritoAct(carrito);
                System.out.println("Guardadoooooooooooo");
                %>
        <script>
            window.location.href = "compraBusca.jsp?id=<%=id_cliente%>";
        </script>
            <%}%>
        <form>
            <table border="1">
                <thead>
                <tr>
                    <th>ID Carrito</th>
                    <th>ID Compra</th>
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
                    for(CarritoAct c : listaCarritoAct){
                        Producto a = DAOproducto.obtenProducto(c.getIdProducto());
                        total += c.getPrecio();
                %>
                <tr>
                    <td><%= c.getGrupoCarrito()%></td>
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
            <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
            <input type="submit" value="Comprar" name="compra">
        </form>
        <%
            if(request.getParameter("compra") != null){
                CarritoDAO DAOcarrito = new CarritoDAO();
                for(CarritoAct c : listaCarritoAct){
                    Carrito carrito = new Carrito();
                    carrito.setGrupoCarrito(c.getGrupoCarrito());
                    carrito.setIdCliente(c.getIdCliente());
                    carrito.setIdProducto(c.getIdProducto());
                    carrito.setCantidad(c.getCantidad());
                    carrito.setPrecio(c.getPrecio());

                    DAOcarrito.guardarCarrito(carrito);
                }
                DAOcarritoAct.borrarTabla();
                Cliente cliente = DAOcliente.obtenCliente(id_cliente);
                Integer grupo = cliente.getCarrito() + 1;

                cliente.setCarrito(grupo);
                DAOcliente.actualizaCliente(cliente);
                %>
        <h3>Productos comprados</h3>
            <%}%>
    </center
</body>
</html>
