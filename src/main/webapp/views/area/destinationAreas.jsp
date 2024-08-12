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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                                    <button type="submit" class="btn botonCafe">
                                        Registrar
                                    </button>
                                    <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal" onclick="reset()">
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
                                <input hidden id="u_id" name="id">
                                <h5>Datos de Área de destino</h5>
                                <div class="mb-3">
                                    <label for="u_name" class="col-4">Nombre*</label>
                                    <input type="text" class="form-control mb-2" name="name" id="u_name" required>
                                </div>
                                <div class="mb-3">
                                    <label for="u_shortName">Acronimo*</label>
                                    <input type="text" class="form-control mb-2" name="shortName" id="u_shortName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="u_description">Descripción</label>
                                    <textarea class="form-control mb-3" name="description" id="u_description"></textarea>
                                </div>
                                <input hidden id="u_status" name="status">
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
                    <th scope="col" class="thead">Acrónimo</th>
                    <th scope="col" class="thead">Nombre</th>
                    <th scope="col" class="thead">Descripción</th>
                    <th scope="col" class="thead">Estado</th>
                    <th scope="col" class="thead">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="area" items="${areas}" varStatus="s">
                        <tr>
                            <th scope="row"><c:out value="${s.count}"/></th>
                            <td><c:out value="${area.shortName}"/></td>
                            <td><c:out value="${area.name}"/></td>
                            <td><c:out value="${area.description}"/></td>
                            <td>
                                <h4>
                                   <span class="badge badge-pill <c:out value="${area.status == true ? 'statusGreen' : 'statusRed'}"/>">
                                    <c:out value="${area.status == true ? 'Activo' : 'Inactivo'}"/>
                                    </span>
                                </h4>
                            </td>
                            <td>
                                <button class="btn btn-lg botonEditar" data-bs-toggle="modal" data-bs-target="#updateArea" onclick="putAreaInfo(${area.getId()})">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                         fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                    </svg>
                                </button>
                                <form action="${pageContext.request.contextPath}/area/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${area.id}"/>
                                    <button type="submit" class="btn btn-lg botonRojo">
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
            title: '¡Hecho!',
            text: message,
            showConfirmButton: true,
            focusConfirm: false,
            confirmButtonText: `<span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                </svg>
                                </span> ¡Genial!`,
            confirmButtonAriaLabel: "Thumbs up, great!",
            timer: 2000,
            timerProgressBar: true,
            customClass: {
                confirmButton: 'btn botonCafe',
                popup: 'no-select-popup'
            }
        });
    }

    function changeError(message) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: message,
            showConfirmButton: true,
            confirmButtonText: 'Aceptar',
            customClass: {
                confirmButton: 'btn botonCafe',
                cancelButton: 'btn botonGris',
                popup: 'no-select-popup'
            }
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
<script src="../../assets/js/updateAreas.js"></script>
<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
