<%-- 
    Document   : consultar
    Created on : 1/11/2013, 06:31:09 PM
    Author     : Search
--%>

<%@page import="Mapeos.Empleado"%>
<%@page import="java.util.List"%>
<%@page import="Beans.EmpleadoDAO"%>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleado</title>
    </head>
    <body>
        <h1>Portal de modificacion de datos del empleado</h1>
        <% EmpleadoDAO empleadoDAO = new EmpleadoDAO();
            List<Empleado> lista = empleadoDAO.obtenListaEmpleado();
            List<Empleado> listaEmpleados = new ArrayList<>();

            for(Empleado a : lista) {
                if(a.getTipoUsuario().equals("Empleado")){
                    listaEmpleados.add(a);
                }
            }
        %>
        <form>
            <CENTER>
                <HR> 
                <I>Selecciona el empleado a actualizar.<a href="AutentificarAdmon.jsp">Cerrar Sesion</a> </I>.
                </HR>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Numero empleado</th>
                            <th>Nombre empleado</th>
                            <th>Contraseña</th>
                            <th>Apellido paterno</th>
                            <th>Apellido materno</th>
                            <th>Fecha de nacimiento</th>
                            <th>RFC</th>
                            <th>Salario</th>
                            <th>Estado civil</th>
                            <th>Estatus</th>
                            <th>Nivel de estudio</th>
                            <th>Tipo de usuario</th>
                        </tr>
                    </thead>
                    <%  for (Empleado a : listaEmpleados) {
                    %>
                    <tr>
                        <td><%= a.getNoEmpleado()%></td>
                        <td><%= a.getNombreEmpleado()%></td>
                        <td><%= a.getPassword()%></td>
                        <td><%= a.getApellPatEmpleado()%></td>
                        <td><%= a.getApellMatEmpleado()%></td>
                        <td><%= a.getFechaNac()%></td>
                        <td><%= a.getRfce()%></td>
                        <td><%= a.getSalario()%></td>
                        <td><%= a.getEstadoCivil()%></td>
                        <td><%= a.getEstatus()%></td>
                        <td><%= a.getNivelEstudio()%></td>
                        <td><%= a.getTipoUsuario()%></td>
                        <td><input type="radio" name="rselect" value="<%=a.getNoEmpleado()%>"/></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <input type="submit" value="Actualizar seleccionado" name="actualizar" />
                <a href="EliminarEmpleado.jsp">Regresar</a>
                <%
                    if ((request.getParameter("actualizar") != null)) {
                %>

                <table border="1"  cellpadding="0" cellspacing="0" height="40%" width="25">
                    <%
                        String IDtabla = request.getParameter("rselect");
                        Integer selectID = Integer.parseInt(IDtabla);

                        if (IDtabla != null) {
                            out.println("<h2>Actualizar empleado</h2>");
                            Empleado empleado = new Empleado();
                            for (Empleado a : listaEmpleados) {
                                if(a.getNoEmpleado().equals(selectID)) {
                                    empleado = a;
                                    break;
                                }
                            }

                    %>
                    <tr>
                        <td>
                            <input type="hidden" name="noEmpleado" value="<%= selectID %>">
                            <input id="Nombre_empleado" name="nombreEmpleado" placeholder="Nombre de empleado"
                                   title="Nombre de empleado" type="text" value="<%= empleado.getNombreEmpleado()%> " size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="password" name="password" placeholder="Contraseña"
                                   title="Contraseña" type="password" value="<%= empleado.getPassword()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_pat_empleado" name="apellPatEmpleado" placeholder="Apellido paterno "
                                   title="Apellido paterno" type="text" value="<%= empleado.getApellPatEmpleado()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Apell_mat_empleado" name="apellMatEmpleado" placeholder="Apellido materno"
                                   title="Apellido materno" type="text" value="<%= empleado.getApellMatEmpleado()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Fec_nac" name="fechaNac" placeholder="Fecha de nacimiento "
                                   title="Fecha de nacimiento" type="text" value="<%= empleado.getFechaNac()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="RFCE" name="rfce" placeholder="RFC empleado"
                                   title="RFC" type="text" value="<%= empleado.getRfce()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Salario" name="salario" placeholder="Salario"
                                   title="Salario" type="text" value="<%= empleado.getSalario()%>" size="25"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id="Edo_civil" name="estadoCivil"> 
                                <option value="Soltero">Soltero</option>
                                <option value="Casado">Casado</option>
                                <option value="Divorciado">Divorciado</option>
                                <option value="Viudo">Viudo</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id="Estatus_emp" name="estatus"> 
                                <option value="Laborando">Laborando</option>
                                <option value="Desempleado">Desempleado</option>
                                <option value="Retirado">Retirado</option>
                                <option value="Periodo Vacacional">Periodo Vacacional</option>
                                <option value="Incapacitado o lactancia">Incapacitado o lactancia</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id="Nivel" name="nivelEstudio">
                                <option value="Sin estudios">Sin estudios</option> 
                                <option value="Primaria">Primaria</option>
                                <option value="Secundaria">Secundaria</option>
                                <option value="Bachiller">Bachiller</option>
                                <option value="Universidad">Universidad</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <select id="tipoUsuario" name="tipoUsuario" value="<%= empleado.getTipoUsuario()%>"> 
                                <option value="Administrador">Administrador</option>
                                <option value="Empleado">Empleado</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="submit" name="Actualizar Empleado" type="submit" value="Actualizar">
                            <input type="reset" value="Limpiar">
                        </td>
                    </tr>
                </table>
            </CENTER>
        </form>
        <%
            }
                        else{
                out.println("<h2>Debes seleccionar un empleado para eliminarlo.</h2>");
            }
            }
                    if(request.getParameter("Actualizar Empleado") != null){

                        // Actualizando producto

                        Empleado empleadoAct = new Empleado();
                        empleadoAct.setNoEmpleado(Integer.parseInt(request.getParameter("noEmpleado")));
                        empleadoAct.setNombreEmpleado(request.getParameter("nombreEmpleado"));
                        empleadoAct.setPassword(request.getParameter("password"));
                        empleadoAct.setApellPatEmpleado(request.getParameter("apellPatEmpleado"));
                        empleadoAct.setApellMatEmpleado(request.getParameter("apellMatEmpleado"));
                        empleadoAct.setFechaNac(request.getParameter("fechaNac"));
                        empleadoAct.setRfce(request.getParameter("rfce"));
                        empleadoAct.setSalario(Integer.parseInt(request.getParameter("salario")));
                        empleadoAct.setEstadoCivil(request.getParameter("estadoCivil"));
                        empleadoAct.setEstatus(request.getParameter("estatus"));
                        empleadoAct.setNivelEstudio(request.getParameter("nivelEstudio"));
                        empleadoAct.setTipoUsuario(request.getParameter("tipoUsuario"));

                        EmpleadoDAO DAO = new EmpleadoDAO();
                        DAO.actualizaEmpleado(empleadoAct);
                        out.println("<h2>Empleado actualizado con éxito.</h2>\n<h3><a href=\"EliminarEmpleado.jsp\">Regresar</a></h3>\n<h4><a href=\"ModificarEmpleado.jsp\">Recargar página</a></h4>");
                    }
    %>
</body>
</html>
