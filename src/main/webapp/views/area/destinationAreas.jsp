<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 03/08/2024
  Time: 11:38 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Áreas de destino"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") == null){
        response.sendRedirect(context+"/index.jsp");
    }
%>
<html>
<head>
    <title>Áreas de destino</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<jsp:include page="../../layouts/menu.jsp"/>


<!--CONTENEDOR TOTAL-->
<div class="container">
    <div class="container-fluid vh-100 d-flex justify-content-center align-items-center">
        <div class="card contenidoTotal shadow-lg p-5">
            <!--Título del contenido-->
            <div>
                <h3>Consulta de Área de destino</h3>
            </div>

            <!--BOTON PARA AGREGAR NUEVA AREA DE DESTINO -->
            <div class="position-absolute top-10 end-0">
                <button class="btn btn-outline-secondary me-md-5" type="button" data-bs-toggle="modal"
                        data-bs-target="#registerArea">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart-plus"
                         viewBox="0 0 16 16">
                        <path d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9z" />
                        <path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zm3.915 10L3.102 4h10.796l-1.313 7zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0" />
                    </svg> Nueva Área</button>
            </div>
            <!--FILTRO DE BUSQUEDA DE AREA DE DESTINO-->
            <!-- DATOS
            Nombre del proveedor* - Alfanumérico
            RFC* - Alfanumérico
            Correo electronico* - Alfanumérico
        -->
            <div class="mt-3">
                <form onsubmit="search(); return false;">
                    <div class="row d-flex justify-content-center">
                        <div class="col-5 ms-3">Nombre</div>
                        <div class="col-5 ms-1">Acrónimo</div>
                    </div>
                    <!--Nombre-->
                    <div class="row d-flex justify-content-center">
                        <div class="col-5">
                            <input id="nameSupplier" type="text" class="form-control" placeholder="Nombre del área de destino">
                        </div>
                        <!--Acronimo-->
                        <div class="col-5">
                            <input id="rfc" type="text" class="form-control" placeholder="Acrónimo del área de destino">
                        </div>
                    </div>
                    <!--Botones -->
                    <div class="grid gap-2 d-flex justify-content-end mt-5">
                        <button class="btn botonCafe mb-3" onsubmit="search()" id="">
                            Buscar
                        </button>
                        <button class="btn botonGris btn-light mb-3" id="" onreset="reset()">
                            Limpiar
                        </button>
                    </div>
                </form>
            </div>

            <!--[MODAL] AGREGAR AREA DE DESTINO-->
            <div class="modal fade" id="registerArea" tabindex="-1" aria-labelledby="registerAreaLabel" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title fs-5">Nueva Área de Destino</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="newAreaForm" method="post" action="/area/save">
                                <h5>Datos de Área de destino</h5>
                                <div class="mb-3">
                                    <label for="name" class="col-4">Nombre*</label>
                                    <input type="text" class="form-control mb-2" name="name" id="name" required>
                                </div>
                                <div class="mb-3">
                                    <label for="shortName">Acronimo*</label>
                                    <input type="text" class="form-control mb-2" name="shortName" id="shortName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="description">Descripción</label>
                                    <textarea class="form-control mb-3" name="description" id="description"></textarea>
                                </div>
                                <!--Botones MODAL--->
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="registerDestinationArea()">
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

            <!--[MODAL] ACTUALIZAR AREA DE DESTINO-->
            <div class="modal fade" id="updateArea" tabindex="-1" aria-labelledby="updateAreaLabel" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Editar información de Área de Destino</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateAreaForm" method="post" action="/area/update">
                                <h5>Datos de Área de destino</h5>
                                <div class="mb-3">
                                    <label for="name" class="col-4">Nombre*</label>
                                    <input type="text" class="form-control mb-2" name="name" id="name" required>
                                </div>
                                <div class="mb-3">
                                    <label for="shortName">Acronimo*</label>
                                    <input type="text" class="form-control mb-2" name="shortName" id="shortName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="description">Descripción</label>
                                    <textarea class="form-control mb-3" name="description" id="description"></textarea>
                                </div>
                                <!--Botones MODAL--->
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="updateDestinationArea()">
                                        Modificar
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

            <!--Tabla Consulta de Unidades de medida/Metricas -->
            <div class="table-responsive table-container" id="contenedor">
                <table class="table table-bordered table-striped mt-0 text-center" id="resultTable">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col" colspan="6" class="tableTitle">ÁREAS DE DESTINO
                        </th>
                    </tr>
                    <tr>
                    <th scope="col" class="thead">#</th>
                    <th scope="col" class="thead">Nombre</th>
                    <th scope="col" class="thead">Acrónimo</th>
                    <th scope="col" class="thead">Descripción</th>
                    <th scope="col" class="thead">Estado</th>
                    <th scope="col" class="thead">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="area" items="${areas}" varStatus="s">
                        <tr>
                            <th scope="row"><c:out value="${s.count}"/></th>
                            <td><c:out value="${area.name}"/></td>
                            <td><c:out value="${area.shortName}"/></td>
                            <td><c:out value="${area.description}"/></td>
                            <td>
                                <h4>
                                   <span class="badge badge-pill <c:out value="${area.status == true ? 'statusGreen' : 'statusRed'}"/>">
                                    <c:out value="${area.status}"/>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                <button class="btn btn-lg botonEditar" data-bs-toggle="modal" data-bs-target="#updateArea" onclick="update()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                    </svg>
                                </button>
                                <form action="${pageContext.request.contextPath}/area/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${area.id}"/>
                                    <button type="submit" class="btn btn-lg botonRojo" onclick="return confirm('¿Estás seguro de que quieres cambiar el estado de esta area?');">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                            <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5" />
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


<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script src="../../assets/js/alerts.js"></script>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
