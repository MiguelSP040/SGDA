<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 04/08/2024
  Time: 09:30 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Salidas de almacén"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") == null){
        response.sendRedirect(context+"/index.jsp");
    }
%>
<html>
<head>
    <title>Salidas de almacén</title>
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

            <!--SECCION DE TITULO DE LA CARD Y BOTON QUE ACTIVA EL MODAL DE REGISTRO DE UN MOVIMIENTO {ENTRADA/SALIDA}-->
            <div class="position-relative">
                <h3>Consulta de salidas</h3>
            </div>

            <!-- Botón para registrar movimiento -->
            <div class="position-absolute top-10 end-0">
                <button class="btn btn-outline-secondary me-md-5" type="button" data-bs-toggle="modal"
                        data-bs-target="#registerMovement">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-plus-circle-fill" viewBox="0 0 16 16">
                        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/>
                    </svg>
                    Registrar salida
                </button>
            </div>

            <!-- Modal Registro de Salida -->
            <div class="modal fade " id="registerMovement" tabindex="-1" aria-labelledby="registerMovementLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content w-100">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="registerOutboundLabel">Nueva Salida</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="registerOutboundForm" method="post" action="/exit/save">
                                <h5>Datos de la Salida</h5>
                                <div class="row d-flex justify-content-center">
                                    <div class="col-3"><label for="folioNumber">Folio</label></div>
                                    <div class="col-3"><label for="invoiceNumber">Facturación</label></div>
                                    <div class="col-3"><label for="id_area">Área</label></div>
                                    <div class="col-3"><label for="id_user">Almacenista</label></div>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="col me-2">
                                        <input class="form-control w-100" type="text" name="folioNumber" id="folioNumber" placeholder="Folio" disabled>
                                    </div>
                                    <div class="col me-2">
                                        <input class="form-control w-100" type="text" name="invoiceNumber" id="invoiceNumber" placeholder="Facturación"
                                               required>
                                    </div>
                                    <div class="col me-2">
                                        <select class="form-select" name="id_area" id="id_area" required>
                                            <option value="" disabled selected>Seleccionar un área de destino</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select class="form-select" name="id_user" id="id_user" required>
                                            <option value="" disabled selected>Seleccionar un almacenista</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Campos para Salida -->
                                <div class="table-responsive table-container">
                                    <table class="table table-bordered table-striped text-center">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th scope="col" style="width: 3%" class="tableTitle">#</th>
                                            <th scope="col" style="width: 25%" class="tableTitle"><label for="id_product">Producto*</label></th>
                                            <th scope="col" style="width: 13%" class="tableTitle"><label for="id_metric">Medida*</label></th>
                                            <th scope="col" style="width: 15%" class="tableTitle"><label for="buyerName">Receptor*</label></th>
                                            <th scope="col" style="width: 10%" class="tableTitle"><label for="unitPrice">Precio*</label></th>
                                            <th scope="col" style="width: 10%" class="tableTitle"><label for="quantity">Cantidad*</label></th>
                                            <th scope="col" style="width: 10%" class="tableTitle"><label for="total_price">Precio total*</label></th>
                                            <th scope="col" style="width: 3%;" class="tableTitle">Acciones</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>
                                                <select class="form-select" name="id_product" id="id_product" required>
                                                    <option value="" disabled selected>Seleccionar un producto</option>
                                                    <option value="1">One</option>
                                                    <option value="2">Two</option>
                                                    <option value="3">Three</option>
                                                </select>
                                            </td>
                                            <td>
                                                <select class="form-select " name="id_metric" id="id_metric" disabled>
                                                    <option value="" selected>Tipo</option>
                                                </select>
                                            </td>
                                            <td>
                                                <input class="form-control w-100" type="text" name="buyerName" id="buyerName" placeholder="Receptor" required>
                                            </td>
                                            <td>
                                                <input class="form-control w-100" type="number" name="unitPrice" id="unitPrice" min="0" step="0.5"
                                                       placeholder="$0.00" required>
                                            </td>
                                            <td>
                                                <input class="form-control" type="number" name="quantity" id="quantity" min="1" step="1" placeholder="0"
                                                       required>
                                            </td>
                                            <td>
                                                <input class="form-control" type="number" name="total_price" id="total_price" placeholder="$0.00" disabled>
                                            </td>
                                            <td class="d-flex justify-content-end">
                                                <div class="btn-group">
                                                    <button type="button" class="btn botonVerMas" onclick="addRow(this)">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                             fill="currentColor" class="bi bi-plus-circle-fill"
                                                             viewBox="0 0 16 16">
                                                            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/>
                                                        </svg>
                                                    </button>
                                                    <button type="button" class="btn botonRojo me-2" onclick="removeRow(this)">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                             fill="currentColor" class="bi bi-dash-circle-fill"
                                                             viewBox="0 0 16 16">
                                                            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M4.5 7.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1z"/>
                                                        </svg>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" id="registerButton" onclick="registerOutbound()">
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

            <!-- Modal Actualizar Salida -->
            <div class="modal fade" id="updateOutboundModal" tabindex="-1" aria-labelledby="updateOutboundLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="updateOutboundLabel">Editar información de Salida</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="updateOutboundForm" method="post" action="/exit/update">
                                <h5>Datos de la Salida</h5>
                                <div class="row">
                                    <div class="col-6">
                                        <!-- Campos para Entrada -->
                                        <div class="mb-3">
                                            <label for="changeDate" class="form-label">Fecha del movimiento*</label>
                                            <input type="date" class="form-control" name="changeDate" id="changeDate" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="invoiceNumber" class="form-label">Número de facturación*</label>
                                            <input type="text" class="form-control" name="invoiceNumber" id="invoiceNumber" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="id_area" class="form-label">Area de destino*</label>
                                            <select class="form-select" name="id_area" id="id_area" required>
                                                <option value="" disabled selected>Seleccionar un area de destino</option>
                                                <option value="1">One</option>
                                                <option value="2">Two</option>
                                                <option value="3">Three</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="id_user" class="form-label">Almacenista*</label>
                                            <select class="form-select" name="id_user" id="id_user" required>
                                                <option value="" disabled selected>Seleccionar un almacenista</option>
                                                <option value="1">One</option>
                                                <option value="2">Two</option>
                                                <option value="3">Three</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="id_product" class="form-label">Productos*</label>
                                            <select class="form-select" aria-label="Default select example" name="id_product" id="id_product" required>
                                                <option value="" disabled selected>Seleccionar un producto</option>
                                                <option value="1">One</option>
                                                <option value="2">Two</option>
                                                <option value="3">Three</option>
                                                <!-- Opciones aquí -->
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="mb-3">
                                            <label for="id_metric" class="form-label" >Unidad de medida*</label>
                                            <select class="form-select" name="id_metric" id="id_metric" disabled>
                                                <option value="" selected>Tipo</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="buyerName" class="form-label">Receptor*</label>
                                            <input type="text" class="form-control" name="buyerName" id="buyerName" min="0" step="0.5" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="unitPrice" class="form-label">Precio*</label>
                                            <input type="number" class="form-control" name="unitPrice" id="unitPrice" min="0" step="0.5" placeholder="$0.00" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="quantity" class="form-label">Cantidad*</label>
                                            <input type="number" class="form-control" name="quantity" id="quantity" min="1" step="1" placeholder="0" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="total_price" class="form-label">Precio total*</label>
                                            <input type="number" class="form-control" name="total_price" id="total_price" placeholder="$0.00" disabled>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="updateOutbound()">
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

            <!--FILTRO POR FECHA DE INICIO Y FECHA FIN-->
            <div class="mt-3">
                <form onsubmit="search()">
                    <div class="row d-flex justify-content-center">
                        <div class="col-5 ms-4">Fecha de Inicio</div>
                        <div class="col-5 ms-1">Fecha Final</div>
                    </div>

                    <!--Input de Fecha de Inicio-->
                    <div class="row d-flex justify-content-center">
                        <div class="col-5">
                            <input type="date" class="form-control">
                        </div>

                        <!--Input de Fecha Final-->
                        <div class="col-5">
                            <input type="date" class="form-control">
                        </div>
                    </div>
                    <!--Botones -->
                    <div class="grid gap-2 d-flex justify-content-end mt-5">
                        <button class="btn botonCafe mb-3" onsubmit="search()" id="botonCafe">Buscar
                        </button>
                        <button class="btn botonGris btn-light mb-3" id="botonGris" onreset="reset()">Limpiar
                        </button>
                    </div>
                </form>
            </div>

            <div class="table-responsive table-container" id="contenedor">
                <table class="table table-bordered table-striped mt-0 text-center">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col" colspan="9" class="tableTitle">
                            REPORTE DE SALIDAS
                        </th>
                    </tr>
                    <tr>
                        <th scope="col" class="thead">#</th>
                        <th scope="col" class="thead">Fecha</th>
                        <th scope="col" class="thead">Folio</th>
                        <th scope="col" class="thead">Facturación</th>
                        <th scope="col" class="thead">Producto</th>
                        <th scope="col" class="thead">Cantidad</th>
                        <th scope="col" class="thead">Precio Total</th>
                        <th scope="col" class="thead">Destino</th>
                        <th scope="col" class="thead">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="exit" items="${exits}">
                            <tr>
                                <th scope="row"><c:out value="${exit.id}"/></th>
                                <td><c:out value="${exit.changeDate}"/></td>
                                <td><c:out value="${exit.folioNumber}"/></td>
                                <td><c:out value="${exit.invoiceNumber}"/></td>
                                <td><c:out value="${exit.id_product}"/></td>
                                <td><c:out value="${exit.quantity}"/></td>
                                <td><c:out value="${exit.total_price}"/></td>
                                <td><c:out value="${exit.id_provider}"/></td>
                                <!--Columna de Botones de acción-->
                                <td>
                                <button class="btn btn-lg botonVerMas" id="botonVerMas" onsubmit="viewMore()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>
                                    </svg>
                                </button>
                                <button onclick="updateOutboundModal()" class="btn btn-lg botonEditar" id="botonEditar"
                                        data-bs-toggle="modal" data-bs-target="#updateOutboundModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
                                    </svg>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                        <tr>
                            <th scope="row">2</th>
                            <td>22/07/2024</td>
                            <td>E2024F1KL</td>
                            <td>#123456</td>
                            <td>HJS</td>
                            <td>10</td>
                            <td>$100.00</td>
                            <td>A-SUR</td>
                            <!--Columna de Botones de acción-->
                            <td>
                                <button class="btn btn-lg botonVerMas" id="botonVerMas" onsubmit="viewMore()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>
                                    </svg>
                                </button>
                                <button class="btn btn-lg botonEditar" id="botonEditar"
                                        data-bs-toggle="modal" data-bs-target="#updateOutboundModal" onclick="updateOutboundModal()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
                                    </svg>
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!--Paginación al pie de Página -->
            <div class="pagination d-flex justify-content-center align-items-center mt-5">
                <button class="btn btn-lg me-2" aria-label="Previous Page">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-caret-left-fill" viewBox="0 0 16 16">
                        <path d="m3.86 8.753 5.482 4.796c.646.566 1.658.106 1.658-.753V3.204a1 1 0 0 0-1.659-.753l-5.48 4.796a1 1 0 0 0 0 1.506z"/>
                    </svg>
                </button>
                <input type="number" class="page-info form-control" style="width: 4rem" min="1" value="1"/>
                <button class="btn btn-lg ms-2" aria-label="Next Page">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-caret-right-fill" viewBox="0 0 16 16">
                        <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
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
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Obtener referencias a los modales
        var registerMovementModal = new bootstrap.Modal(document.getElementById('registerMovement'));
        var newProductModal = new bootstrap.Modal(document.getElementById('newProduct'));

        // Obtener el botón que abre el modal de nuevo producto
        var openNewProductModalBtn = document.getElementById('openNewProductModal');

        // Evento para abrir el modal de nuevo producto
        openNewProductModalBtn.addEventListener('click', function () {
            newProductModal.show();
        });

    });
</script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script src="../../assets/js/alerts.js"></script>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
