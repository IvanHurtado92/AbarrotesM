<%-- 
    Document   : EliminarCliente
    Created on : 4/01/2014, 01:30:54 PM
    Author     : Search
--%>

    <%@page import="Beans.ClienteDAO"%> 
    <%@page import="java.util.List"%>
    <%@page import="Mapeos.Cliente"%> 
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleado</title>
    </head>
    <body>
        <h1>Portal de información del cliente</h1>
        <% ClienteDAO clienteDAO = new ClienteDAO();
            List<Cliente> listaClientes = clienteDAO.obtenListaCliente();
        %>
        <form>
            <HR> 
            <I>Para eliminar un cliente seleccionarlo en la columna final <a href="<%
                if(request.getParameter("admin").equals("1")){
                    out.println("AutentificarAdmon.jsp");
                }
                else {
                    out.println("AutentificarEmpleado.jsp");
                }
            %>">  Cerrar Sesion</a></I>.
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
                <tbody>
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
                        <td>
                            <input type="checkbox" name="cbactores" value="<%=a.getIdCliente()%>"/>
                            <input type="hidden" name="admin" value="<%=request.getParameter("admin")%>">
                        </td>
                    </tr>
                    <% }
                    %>
                </tbody>
            </table>
            <input type="submit" value="Eliminar Seleccionados" name="eliminar" />
            <input type="button" onclick=" location.href = 'InsertarCliente.jsp?admin=<%=request.getParameter("admin")%>' " value="Nuevo Cliente" name="boton" />
            <input type="button" onclick=" location.href = 'ModificarCliente.jsp?admin=<%=request.getParameter("admin")%>' " value="Actualizar Cliente" name="boton" />
        </form>
        <%
            if (request.getParameter("eliminar") != null) {
                String[] chbClientes = request.getParameterValues("cbactores");

                if (chbClientes != null && chbClientes.length > 0) {
                    for (int i = 0; i < chbClientes.length; i++) {
                        out.println("<li>" + chbClientes[i]);
                        clienteDAO.eliminaCliente(Short.valueOf(chbClientes[i]));
                        out.println(" El cliente ha sido eliminado");
                    }
                } else {
                    // Si no hay empleados seleccionados, mostramos un mensaje de advertencia
                    out.println("<p>Debes seleccionar al menos un cliente para eliminarlo.</p>");
                }
            }
        %>
    </body>
</html>
