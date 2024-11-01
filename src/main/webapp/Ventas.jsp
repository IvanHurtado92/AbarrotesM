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
<%@ page import="Beans.CarritoActDAO" %>
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
            Integer numCarro = cliente.getCarrito();
            // eliminando el carrito actual para que si el usuario vuelve a ir a compraBusca esté vacío.
//            CarritoActDAO carritoActDAO = new CarritoActDAO();
//            carritoActDAO.borrarTabla();
        %>

            <CENTER>
                <I>----------  </I><tr><I>BIENBENID@ <%= cliente.getNombre()%></I></tr>
                    <I>----------  </I><th><I>HISTORIAL DE COMPRAS</I></th>
                <I>----------  </I><a href="Acceso.jsp">Cerrar Sesion</a>
                <h5></h5>
                <form>
                    <h3>Formato</h3>
                    <label>
                        Ver por grupo
                        <input type="radio" name="tipo" value="1">
                    </label>
                    <label>
                        Ver por lista
                        <input type="radio" name="tipo" value="2">
                    </label>
                    <br>
                    <input type="hidden" name="id" value="<%=id_cliente%>">
                    <input type="submit" name="elegir" value="Elegir">
                </form>
                <%
                    if(request.getParameter("elegir") != null){
                        if(request.getParameter("tipo").equals("1")){
                %>
                    <form>
                        <h3>Selecciona el carrito/historial que deseas ver</h3>
                        <td>
                            <input type="number" id="carritoSelect" name="grupo"
                                   min="1" max="<%= numCarro %>">
                        </td>
                        <input type="hidden" name="id" value="<%=id_cliente%>">
                        <input type="hidden" name="elegir" value="Elegir">
                        <input type="hidden" name="tipo" value="<%=request.getParameter("tipo")%>">
                        <input type="submit" value="Seleccionar" name="Seleccionar" />
                    </form>
                    <%
                        if(request.getParameter("Seleccionar") != null){
                            CarritoDAO DAO = new CarritoDAO();
                            Integer grupo = Integer.parseInt(request.getParameter("grupo"));
    //            List<Carrito> listacarrito = DAO.obtenCarritoPorCliente(id_cliente);
                            List<Carrito> listacarrito = DAO.obtenCarritoPorGrupo(grupo,id_cliente);
                            Float total = 0f;

                    %>
                    <form>
                            <h3>Grupo de carrito <%=grupo%></h3>
                            <table border="1">
                                <thead>
                                    <tr>
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
                </form>
                        <%}%>
                <%} else if (request.getParameter("tipo").equals("2")) {
                            CarritoDAO DAO = new CarritoDAO();
                            List<Carrito> listacarrito = DAO.obtenCarritoPorCliente(id_cliente);
                            Float total = 0f;
                            %>
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
                            for(Carrito c : listacarrito){
                                ProductoDAO DAOproducto = new ProductoDAO();
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
                </form>
                <%}%>
                <h4>Selecciona una opción</h4>
                    <%}%>
                        <input type="button" onclick=" location.href = 'compraBusca.jsp?id=<%=id_cliente%>'" value="Comprar por búsqueda" name="Comprar" />
                        <input type="button" onclick=" location.href = 'compraLista.jsp?id=<%=id_cliente%>'" value="Comprar por lista" name="Comprar" />
        </CENTER>
    </body>
</html>
