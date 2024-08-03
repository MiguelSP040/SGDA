<%--
  Created by IntelliJ IDEA.
  User: migue
  Date: 30/07/2024
  Time: 12:51 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") != null){
        response.sendRedirect(context+"/views/user/userQuery.jsp");
    }
    boolean errorMessage = request.getAttribute("errorMessage") != null && !(boolean) request.getAttribute("errorMessage");
%>
<html>
<head>
    <title>Consulta de usuarios</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<jsp:include page="../../layouts/menu.jsp"/>
<!--Contenido Total, sin contemplar sidebar y navbar -->
<div class="contenidoTotal card shadow-lg">
    <!--Titulo de Formulario-->
    <div class="position-relative">
        <div class="position-absolute top-0 start-0">
            <h3>Filtro de búsqueda</h3>
        </div>

        <!--BOTON AGREGAR NUEVO PRODUCTO -->
        <div class="position-absolute top-0 end-0">
            <a href="<%=context%>/user/register" class="btn nuevoProductoBoton">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-add" viewBox="0 0 16 16">
                    <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                    <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4"/>
                </svg>
                Registrar Usuario
            </a>
        </div>
    </div>

    <!--FILTRO DE BUSQUEDA DE PRODUCTO-->
    <div class="Inputs">
        <form onsubmit="search(); return false;">
            <div class="row">
                <div class="col-3">Nombre completo</div>
                <div class="col-3">Rol</div>
                <div class="col-3">Correo electrónico </div>
                <div class="col-3">Estado</div>
            </div>

            <!--Clave del producto-->
            <div class="row">
                <!--Nombre Completo-->
                <div class="col-3">
                    <input id="nombreCompleto" type="text"
                           class="form-control" placeholder="Nombre(s) Apellidos">
                </div>
                <!--Rol-->
                <div class="col-3">
                    <select class="form-select" aria-label="Seleccionar opción">
                        <option disabled selected value>
                            Seleccionar opción
                        </option>
                        <option value="1">Administrador</option>
                        <option value="2">Almacenista</option>
                    </select>
                </div>
                <!--Correo Electrónico-->
                <div class="col-3">
                    <input id="nombreCompleto" type="text"
                           class="form-control" placeholder="alguien@example.com">
                </div>
                <!--Estado-->
                <div class="col-3">
                    <select class="form-select" aria-label="Seleccionar opción">
                        <option disabled selected value>
                            Seleccionar opción
                        </option>
                        <option value="1">Activo</option>
                        <option value="2">Inactivo</option>
                    </select>
                </div>

                <!--Botones -->
                <div class="grid gap-2"
                     style="justify-content: end; display: flex; margin-top: 50px;padding-left:5%;">
                    <button class="btn mb-3" onsubmit="search()"
                            id="botonCafe">Buscar</button>
                    <button class="btn btn-light mb-3" id="botonGris"
                            onreset="reset()">Limpiar</button>
                </div>
            </div>
        </form>
    </div>

    <!--Tabla con registros-->
    <div id="contenedor">
        <table class="table table-bordered table-striped " id="resultTable">
            <thead class="thead-dark">
            <tr>
                <th scope="col" colspan="5" id="tableTitle">
                    USUARIOS ENCONTRADOS
                </th>
            </tr>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Nombre completo</th>
                <th scope="col">Rol de usuario</th>
                <th scope="col">Correo electrónico</th>
                <th scope="col">Estado</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <th scope="row"><c:out value="${user.id}"/></th>
                    <td><c:out value="${user.name}"/>&nbsp;<c:out value="${user.surname}"/>&nbsp;<c:out value="${user.lastname}"/></td>
                    <td><c:out value="${user.role}"/></td>
                    <td><c:out value="${user.email}"/></td>
                    <td><c:out value="${user.status}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script src="../../assets/js/funciones.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>