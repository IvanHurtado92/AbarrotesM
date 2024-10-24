<%-- 
    Document   : ModificarProducto
    Created on : 26/12/2013, 08:01:41 PM
    Author     : USUARIO
--%>

<%@page import="Mapeos.Producto"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ProductoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Producto</title>
    </head>
    <body>
        <h1>Portal de modificacion de datos del producto</h1>
        <% ProductoDAO productoDAO = new ProductoDAO();
            List<Producto> listaProductos = productoDAO.obtenListaProducto();
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Selecciona el producto a actualizar.<a href="AutentificarAdmon.jsp">Cerrar Sesion</a> </I>.
                </HR>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Numero producto</th>
                            <th>Nombre producto</th>
                            <th>Presentacion</th>
                            <th>Caducidad</th>
                            <th>P. Proveedor</th>
                            <th>P. Unitario</th>
                            <th>Existencias</th>
                            <th>Fecha</th>
                            <th>Marca</th>
                        </tr>
                    </thead>
                    <%  for (Producto a : listaProductos) {
                    %>
                    <tr>
                        <td><%= a.getIdProducto()%></td>
                        <td><%= a.getNombreProducto()%></td>
                        <td><%= a.getPresentacion()%></td>
                        <td><%= a.getCaducidad()%></td>
                        <td><%= a.getPrecioProv()%></td>
                        <td><%= a.getPrecioUni()%></td>
                        <td><%= a.getExistencias()%></td>
                        <td><%= a.getFech()%></td>
                        <td><%= a.getMarca()%></td>
                        <td><input type="radio" name="cbactores" value="<%=a.getIdProducto()%>"/></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <input type="submit" value="Actualizar seleccionado" name="actualizar" />
                <a href="EliminarProducto.jsp">Regresar</a>
                <%
                    if ((request.getParameter("actualizar") != null)) {
                %>
                <h2>Actualizar producto</h2>
                <table border="1"  cellpadding="0" cellspacing="0" height="40%" width="25">
                    <%
                        Producto producto = new Producto();
                        String IDtabla = request.getParameter("cbactores");
                        Integer selectID = Integer.parseInt(IDtabla);

                        if (IDtabla != null){
                            for(Producto a : listaProductos){
                                if(a.getIdProducto() == selectID){
                                    producto = a;
                                    break;
                                }
                            }
                        }
                    %>
                    <tr>
                        <td>
                            <input type="hidden" name="idProducto" value="<%= selectID %>">
                            <input id="Nombre_producto" name="nombreProducto" placeholder="Nombre de producto"
                                   title="Nombre de producto" type="text" value="<%= producto.getNombreProducto()%> " size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Presentacion" name="presentacion" placeholder="Presentacion"
                                   title="Presentacion" type="text" value="<%= producto.getPresentacion()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Caducidad" name="caducidad" placeholder="Caducidad"
                                   title="Caducidad" type="text" value="<%= producto.getCaducidad()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="PProveedor" name="pproveedor" placeholder="Precio Proveedor"
                                   title="PrecioProveedor" type="text" value="<%= producto.getPrecioProv()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="PUnitario" name="punitario" placeholder="Precio Unitario"
                                   title="PrecioUnitario" type="text" value="<%= producto.getPrecioUni()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Exitencias" name="existencias" placeholder="Existencias"
                                   title="Existencias" type="text" value="<%= producto.getExistencias()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Fech" name="fech" placeholder="Fech"
                                   title="Fech" type="text" value="<%= producto.getFech()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Marca" name="marca" placeholder="Marca"
                                   title="Marca" type="text" value="<%= producto.getMarca()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="IdProveedor" name="idProveedor" placeholder="IdProveedor"
                                   title="IdProveedor" type="text" value="<%= producto.getIdProveedor()%>" size="25"/>
                        </td>
                    </tr>

                    <tr>
                        <td>
                                <input id="submit" name="Actualizar Producto" type="submit" value="Actualizar">
                            <input type="reset" value="Limpiar">
                        </td>
                    </tr>
                </table>
            </CENTER>
        </form>
        <%
            }
                    if(request.getParameter("Actualizar Producto") != null){

                        // Actualizar el producto con los datos del formulario

                        Producto productoActualizado = new Producto();
                        productoActualizado.setIdProducto(Integer.parseInt(request.getParameter("idProducto")));
                        productoActualizado.setNombreProducto(request.getParameter("nombreProducto"));
                        productoActualizado.setPresentacion(request.getParameter("presentacion"));
                        productoActualizado.setCaducidad(request.getParameter("caducidad"));
                        productoActualizado.setPrecioProv(Float.parseFloat((request.getParameter("pproveedor"))));
                        productoActualizado.setPrecioUni(Float.parseFloat(request.getParameter("punitario")));
                        productoActualizado.setExistencias(Integer.parseInt(request.getParameter("existencias")));
                        productoActualizado.setFech(request.getParameter("fech"));
                        productoActualizado.setMarca(request.getParameter("marca"));
                        productoActualizado.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));

                        ProductoDAO DAO = new ProductoDAO();
                        DAO.actualizaProducto(productoActualizado);
                        out.println("<h2>Producto actualizado con éxito.</h2>\n<h3><a href=\"EliminarProducto.jsp\">Regresar</a></h3>\n<h4><a href=\"ModificarProducto.jsp\">Recargar página</a></h4>");
                    }
        %>
    </body>
</html>
