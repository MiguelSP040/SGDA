<%--
  Created by IntelliJ IDEA.
  User: isael
  Date: 03/08/2024
  Time: 02:07 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Usuarios"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") == null){
        response.sendRedirect(context+"/index.jsp");
    }
%>
<html>
<head>
        <title>Usuarios</title>
        <link href="../../assets/css/estilos.css" rel="stylesheet">
        <jsp:include page="../../layouts/header.jsp"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<jsp:include page="../../layouts/menu.jsp"/>


<!--Contenido Total, sin contemplar sidebar y navbar -->
<div class="container">
    <div class="container-fluid vh-100 d-flex justify-content-center align-items-center">
        <div class="card shadow-lg p-5" style="width: 100rem; max-width: 100rem;">

            <!--Titulo de Formulario-->
            <div>
                <h3>Consulta de usuarios</h3>
            </div>

            <!-- Botón para agregar nuevo usuario -->
            <div class="position-absolute top-10 end-0">
                <button class="btn btn-outline-secondary me-md-5" type="button" data-bs-toggle="modal"
                        data-bs-target="#newUser">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-person-fill-add" viewBox="0 0 16 16">
                        <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
                        <path d="M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4" />
                    </svg>
                    Nuevo Usuario
                </button>
            </div>

            <!-- Modal -->
            <!--DATOS DE ENTRADA
        Nombres*            - Alfanumérico
        Apellido paterno*   - Alfanumérico
        Apellido materno*   - Alfanumérico
        Teléfono*           - Numérico
        Correo electrónico* - Alfanumérico
        -->

            <!-- Modal Nuevo Usuario -->
            <div class="modal fade" id="newUser" tabindex="-1" aria-labelledby="newUserLabel" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="newUserLabel">Nuevo Usuario</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="newUserForm" method="post" action="/user/save">
                                <h5>Datos de Usuario</h5>
                                <div class="row">
                                    <label for="name" class="col">Nombre(s)*</label>
                                    <label for="surname" class="col">Apellido paterno*</label>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <input type="text" class="col-3 form-control" name="name" id="name" required>
                                    </div>
                                    <div class="col">
                                        <input type="text" class="form-control" name="surname" id="surname" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <label for="lastname" class="col">Apellido materno*</label>
                                    <label class="col" for="phone">Teléfono*</label>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <input type="text" class="form-control" name="lastname" id="lastname" required></div>
                                    <div class="col">
                                        <input type="tel" class="form-control" name="phone" id="phone" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-8" for="email">Correo electrónico*</label>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <input type="email" class="form-control" name="email" id="email" required>
                                    </div>
                                </div>
                                <!--Botones MODAL--->
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="registerUser()">
                                        Registrar
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" onclick="reset()">
                                        Cancelar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Editar Usuario -->
            <div class="modal fade" id="updateUser" tabindex="-1" aria-labelledby="updateUserLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="updateUserLabel">Editar información de usuario</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateUserForm" method="post" action="/user/update">
                                <h5>Datos de Usuario</h5>
                                <div class="row">
                                    <label for="name" class="col">Nombre(s)*</label>
                                    <label for="surname" class="col">Apellido paterno*</label>
                                </div>
                                <div class="row">
                                    <div class="col"><input type="text" class="col-3 form-control" name="name" required>
                                    </div>
                                    <div class="col"><input type="text" class="form-control" name="surname"  required></div>
                                </div>
                                <div class="row">
                                    <label for="lastname" class="col">Apellido materno*</label>
                                    <label class="col" for="phone">Teléfono*</label>
                                </div>
                                <div class="row">
                                    <div class="col"><input type="text" class="form-control" name="lastname"  required></div>
                                    <div class="col"><input type="tel" class="form-control" name="phoneNumber"  required>
                                    </div>
                                </div>
                                <div class="row" style="text-indent: 2%!important;">
                                    <label class="col-8" for="email">Correo electrónico*</label>
                                </div>
                                <div class="row">
                                    <div class="col"><input type="email" class="form-control" name="email"  required>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="updateUser()">
                                        Modificar
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                        Cancelar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!--FILTRO DE BUSQUEDA DE PRODUCTO-->
            <div class="mt-3">
                <form onsubmit="search(); return false;">
                    <div class="row d-flex justify-content-center">
                        <div class="col-3">Nombre completo</div>
                        <div class="col-3">Rol</div>
                        <div class="col-3">Correo electrónico</div>
                        <div class="col-3">Estado</div>
                    </div>

                    <!--Clave del producto-->
                    <div class="row d-flex justify-content-center">
                        <!--Nombre Completo-->
                        <div class="col-3">
                            <input id="nombreCompleto" type="text" class="form-control" placeholder="Nombre(s) Apellidos">
                        </div>
                        <!--Rol-->
                        <div class="col-3">
                            <select class="form-select" aria-label="Seleccionar opción">
                                <option disabled selected value>
                                    Seleccionar opción
                                </option>
                                <option value="admin">Administrador</option>
                                <option value="user">Almacenista</option>
                            </select>
                        </div>
                        <!--Correo Electrónico-->
                        <div class="col-3">
                            <input  type="text" class="form-control"
                                    placeholder="alguien@example.com">
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
                        <div class="grid gap-2 d-flex justify-content-end mt-5">
                            <!-- Botón Buscar -->
                            <button class="btn botonCafe mb-3" onsubmit="search()">
                                Buscar
                            </button>

                            <!-- Botón Limpiar -->
                            <button class="btn botonGris btn-light mb-3" onclick="reset()">
                                Limpiar
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!--Tabla con registros-->
            <div class="table-responsive table-container" id="contenedor">
                <table class="table table-bordered table-striped mt-0 text-center" id="resultTable">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col" colspan="6" class="tableTitle">
                            USUARIOS ENCONTRADOS
                        </th>
                    </tr>
                    <tr>
                        <th scope="col" class="thead">#</th>
                        <th scope="col" class="thead">Nombre completo</th>
                        <th scope="col" class="thead">Rol de usuario</th>
                        <th scope="col" class="thead">Correo electrónico</th>
                        <th scope="col" class="thead">Estado</th>
                        <th scope="col" class="thead">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${users}" varStatus="s">
                        <tr>
                            <th scope="row"><c:out value="${s.count}"/></th>
                            <td><c:out value="${user.name}"/>&nbsp;<c:out value="${user.surname}"/>&nbsp;<c:out value="${user.lastname}"/></td>
                            <td><c:out value="${user.role}"/></td>
                            <td><c:out value="${user.email}"/></td>
                            <td>
                                <h4>
                                    <span class="badge badge-pill <c:out value="${user.status == true ? 'statusGreen' : 'statusRed'}"/>">
                                    <c:out value="${user.status == true ? 'Activo' : 'Inactivo'}"/>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                <button class="btn btn-lg botonVerMas" id="botonVerMas" onsubmit="viewMore()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                         fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                    </svg>
                                </button>
                                <button class="btn btn-lg botonEditar" data-bs-toggle="modal" data-bs-target="#updateUser" onclick="update()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                         fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                    </svg>
                                </button>
                                <form action="${pageContext.request.contextPath}/user/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${user.id}"/>
                                    <button type="submit" class="btn btn-lg botonRojo" onclick="return confirm('¿Estás seguro de que quieres cambiar el estado de este usuario?');">
                                        <svg class="bi bi-pencil-square" aria-hidden="true"
                                             xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             fill="none" viewBox="0 0 24 24">
                                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m16 10 3-3m0 0-3-3m3 3H5v3m3 4-3 3m0 0 3 3m-3-3h14v-3"/>
                                        </svg>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <!--Paginación al pie de Página -->
            <div class="pagination d-flex justify-content-center align-items-center mt-5">
                <button class="btn btn-lg me-2" aria-label="Previous Page">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-caret-left-fill" viewBox="0 0 16 16">
                        <path d="m3.86 8.753 5.482 4.796c.646.566 1.658.106 1.658-.753V3.204a1 1 0 0 0-1.659-.753l-5.48 4.796a1 1 0 0 0 0 1.506z" />
                    </svg>
                </button>
                <input type="number" class="page-info form-control" style="width: 4rem" min="1" value="1"></input>
                <button class="btn btn-lg ms-2" aria-label="Next Page">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-caret-right-fill" viewBox="0 0 16 16">
                        <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z" />
                    </svg>
                </button>
            </div>
        </div>
    </div>
</div>
<script>
    // Función para mostrar la alerta
    function changeSuccess(message) {
        Swal.fire({
            icon: 'success',
            title: 'Éxito',
            text: message,
            confirmButtonText: 'Aceptar'
        });
    }

    function changeError(message) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: message,
            confirmButtonText: 'Aceptar'
        });
    }

    // Obtener parámetros de la URL
    const urlParams = new URLSearchParams(window.location.search);
    const result = urlParams.get('result');
    const message = urlParams.get('message');

    // Mostrar la alerta en función del resultado
    if (result === 'true') {
        changeSuccess(decodeURIComponent(message));
    } else if (result === 'false') {
        changeError(decodeURIComponent(message));
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script src="../../assets/js/alerts.js"></script>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
