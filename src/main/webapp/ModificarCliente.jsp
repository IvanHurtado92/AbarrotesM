<%-- 
    Document   : ModificarCliente
    Created on : 4/01/2014, 05:24:56 PM
    Author     : Search
--%>

<%@page import="Mapeos.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="Beans.ClienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cliente</title>
    </head>
    <body>
        <h1>Portal de modificacion de datos del cliente</h1>
        <% ClienteDAO clienteDAO = new ClienteDAO();
            List<Cliente> listaClientes = clienteDAO.obtenListaCliente();
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Para modificar un cliente seleccionar las filas desde el primer cliente hasta el que se desea modificar en la columna final.<a href="AutentificarEmpleado.jsp">Cerrar Sesion</a> </I>.
                </HR>
                <table border="1">
                    <thead>
                        <tr>
                            <th>ID cliente</th>
                        <th>Nombre</th>
                        <th>Apellido paterno</th>
                        <th>Apellido materno</th>
                        <th>Fecha de nacimiento</th>
                        <th>RFC</th>
                        <th>Correo</th>
                        <th>Contraseña</th>
                        <th>Direccion</th>
                        <th>Telefono</th>
                        </tr>
                    </thead>
                    <%  for (Cliente a : listaClientes) { 
                    %>
                    <tr>
                        <td><%= a.getIdCliente() %></td>
                        <td><%= a.getNombre() %></td>
                        <td><%= a.getApellPat() %></td>
                        <td><%= a.getApellMat() %></td>
                        <td><%= a.getFechaNac() %></td>
                        <td><%= a.getRfc() %></td>
                        <td><%= a.getCorreo() %></td>
                        <td><%= a.getPassword() %></td>
                        <td><%= a.getDireccion() %></td>
                        <td><%= a.getTelefono() %></td>
                        <td><input type="radio" name="rselect" value="<%=a.getIdCliente()%>"/></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <input type="hidden" name="admin" value="<%=request.getParameter("admin")%>">
                <input type="submit" value="Actualizar seleccionado" name="actualizar" />
                <a href="EliminarCliente.jsp?admin=<%=request.getParameter("admin")%>">Regresar</a>
                <%
                    if ((request.getParameter("actualizar") != null)) {
                %>
                <h2>Insertar producto</h2>
                <table border="1"  cellpadding="0" cellspacing="0" height="40%" width="25">
                    <%
                        String IDtabla = request.getParameter("rselect");

                        if (IDtabla != null){
                            out.println("<h2>Actualizar cliente</h2>");
                            Integer selectID = Integer.parseInt(IDtabla);
                            Cliente cliente = new Cliente();
                            for(Cliente a : listaClientes){
                                if(a.getIdCliente().equals(selectID)){
                                    cliente = a;
                                    break;
                                }
                            }
                    %>
                    <tr>
                        <td>
                            <input type="hidden" name="idCliente" value="<%= selectID %>">
                            <input type="hidden" name="admin" value="<%=request.getParameter("admin")%>">
                            <input id="Nombre" name="nombre" placeholder="Nombre"
                                   title="Nombre del cliente" type="text" value="<%= cliente.getNombre() %> " size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_pat" name="apellPat" placeholder="Apellido paterno "
                                   title="Apellido Paterno" type="text" value="<%= cliente.getApellPat() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_mat" name="apellMat" placeholder="Apellido materno"
                                   title="Apellido materno" type="text" value="<%= cliente.getApellMat() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Fecha_nac" name="fechaNac" placeholder="Fecha de nacimiento "
                                   title="Fecha de nacimiento" type="text" value="<%= cliente.getFechaNac() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RFC" name="rfc" placeholder="RFC "
                                   title="RFC cliente" type="text" value="<%= cliente.getRfc() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Correo" name="correo" placeholder="Email"
                                   title="Correo electronico" type="text" value="<%= cliente.getCorreo() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Password" name="password" placeholder="Contraseña"
                                   title="Contraseña" type="password" value="<%= cliente.getPassword() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="direccion" name="direccion" placeholder="Dirección"
                                   title="Dirección" type="text" value="<%= cliente.getDireccion() %>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="telefono" name="telefono" placeholder="Telefono"
                                   title="Telefono" type="text" value="<%= cliente.getTelefono() %>" size="10"/>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <input id="submit" name="Actualizar Cliente" type="submit" value="Actualizar">
                            <input type="reset" value="Limpiar">
                        </td>
                    </tr>
                </table>
            </CENTER>
        </form>
        <%
            }
            else{
                out.println("<h2>Debes seleccionar un cliente para eliminarlo.</h2>");
            }
            }
                        if(request.getParameter("Actualizar Cliente") != null){
                            Cliente clienteAct = new Cliente();
                            clienteAct.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));
                            clienteAct.setNombre(request.getParameter("nombre"));
                            clienteAct.setApellPat(request.getParameter("apellPat"));
                            clienteAct.setApellMat(request.getParameter("apellMat"));
                            clienteAct.setFechaNac(request.getParameter("fechaNac"));
                            clienteAct.setRfc(request.getParameter("rfc"));
                            clienteAct.setCorreo(request.getParameter("correo"));
                            clienteAct.setPassword(request.getParameter("password"));
                            clienteAct.setDireccion(request.getParameter("direccion"));
                            clienteAct.setTelefono(request.getParameter("telefono"));

                            ClienteDAO DAO = new ClienteDAO();
                            DAO.actualizaCliente(clienteAct);
                            out.println("<h2>Producto actualizado con éxito.</h2>\n" +
                                    "<h3><a href='EliminarCliente.jsp?admin=" + request.getParameter("admin") + "'>Regresar</a></h3>\n" +
                                    "<h4><a href='ModificarCliente.jsp?admin=" + request.getParameter("admin") + "'>Recargar página</a></h4>");
                        }

        %>
    </body>
</html>
