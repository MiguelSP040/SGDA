<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 03/08/2024
  Time: 06:30 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Proveedores"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") == null){
        response.sendRedirect(context+"/index.jsp");
    }
%>
<html>
<head>
    <title>Proveedores</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<jsp:include page="../../layouts/menu.jsp"/>


<div class="container">
    <div class="container-fluid vh-100 d-flex justify-content-center align-items-center">
        <div class="card contenidoTotal shadow-lg p-5">
            <div>
                <h3>Consulta de proveedores</h3>
            </div>

            <!--BOTON PARA AGREGAR NUEVO PROVEEDOR -->
            <div class="position-absolute top-10 end-0">
                <button class="btn btn-outline-secondary me-md-5" type="button" data-bs-toggle="modal"
                        data-bs-target="#registerSupplier">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-cart-plus" viewBox="0 0 16 16">
                        <path d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9z"/>
                        <path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zm3.915 10L3.102 4h10.796l-1.313 7zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
                    </svg>
                    Nuevo Proveedor
                </button>
                </button>
            </div>


            <!--[MODAL- REGISTRAR NUEVO PROVEEDOR] -->
            <!-- DATOS DE ENTRADA
                    Nombre del proveedor* - Alfanumérico
                    Razón social* - Alfanumérico
                    RFC* - Alfanumérico
                    Código Postal* - Numérico
                    Dirección* - Alfanumérico
                    Teléfono* - Numérico
                    Correo de contacto* - Alfanumérico
                    Nombre de persona adicional* - Alfanumérico
                    Teléfono de persona adicional* - Numérico
                    -->

            <div class="modal fade" id="registerSupplier" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="registerModalLabel">Nuevo Proveedor</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="supplierForm" method="post" action="/provider/save">
                                <div class="row">
                                    <h5>Datos de Proveedor</h5>
                                    <div class="col-6">
                                        <div class="mb-2">
                                            <label for="name" class="col-form-label">Nombre del Proveedor*</label>
                                            <input type="text" class="form-control" name="name" id="name" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="socialCase" class="col-form-label">Razón social*</label>
                                            <input type="text" class="form-control" name="socialCase" id="socialCase" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="rfc" class="col-form-label">RFC*</label>
                                            <input type="text" class="form-control" name="rfc" id="rfc" required>
                                        </div>
                                    </div>
                                    <div class="col-6">

                                        <div class="mb-2">
                                            <label for="phone" class="col-form-label">Teléfono*</label>
                                            <input type="tel" class="form-control" name="phone" id="phone" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="email" class="col-form-label">Correo electrónico*</label>
                                            <input type="text" class="form-control" name="email" id="email" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="postCode" class="col-form-label">Codigo Postal*</label>
                                            <input type="text" class="form-control" name="postCode" id="postCode" required>
                                        </div>
                                    </div>
                                    <div class="mb-2 text-align-center">
                                        <label for="address" class="col-form-label">Dirección*</label>
                                        <input type="text" class="form-control" name="address" id="address" required>
                                    </div>


                                    <h5>Datos de Contacto Adicional</h5>
                                    <div class="mb-2">
                                        <label for="contactName" class="col-form-label">Nombre
                                            completo*</label>
                                        <input type="text" class="form-control" name="contactName" id="contactName" required>
                                    </div>

                                    <div class="mb-2">
                                        <label for="contactPhone" class="col-form-label">Teléfono*</label>
                                        <input type="tel" class="form-control" name="contactPhone" id="contactPhone" required>
                                    </div>

                                    <div class="mb-2">
                                        <label for="contactEmail" class="col-form-label">Correo electrónico*</label>
                                        <input type="tel" class="form-control" name="contactEmail" id="contactEmail" required>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-secondary botonCafe" onclick="registerSupplier(event)">
                                        Registrar
                                    </button>
                                    <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                        Cancelar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <!--[MODAL- ACTUALIZAR INFORMACION DE PROVEEDOR] -->
            <!-- DATOS DE ENTRADA
                    Nombre del proveedor* - Alfanumérico
                    Razón social* - Alfanumérico
                    RFC* - Alfanumérico
                    Código Postal* - Numérico
                    Dirección* - Alfanumérico
                    Teléfono* - Numérico
                    Correo de contacto* - Alfanumérico
                    Nombre de persona adicional* - Alfanumérico
                    Teléfono de persona adicional* - Numérico
                    -->

            <div class="modal fade" id="updateSupplier" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="updateModalLabel">Editar información de proveedor</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateSupplierForm" method="post" action="/provider/update">
                                <div class="row">
                                    <h5>Datos de Proveedor</h5>
                                    <div class="col-6">
                                        <div class="mb-2">
                                            <label for="name" class="col-form-label">Nombre del Proveedor*</label>
                                            <input type="text" class="form-control" name="name" id="name" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="socialCase" class="col-form-label">Razón social*</label>
                                            <input type="text" class="form-control" name="socialCase" id="socialCase" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="rfc" class="col-form-label">RFC*</label>
                                            <input type="text" class="form-control" name="rfc" id="rfc" required>
                                        </div>
                                    </div>
                                    <div class="col-6">

                                        <div class="mb-2">
                                            <label for="phone" class="col-form-label">Teléfono*</label>
                                            <input type="tel" class="form-control" name="phone" id="phone" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="email" class="col-form-label">Correo electrónico*</label>
                                            <input type="text" class="form-control" name="email" id="email" required>
                                        </div>

                                        <div class="mb-2">
                                            <label for="postCode" class="col-form-label">Codigo Postal*</label>
                                            <input type="text" class="form-control" name="postCode" id="postCode" required>
                                        </div>
                                    </div>
                                    <div class="mb-2 text-align-center">
                                        <label for="address" class="col-form-label">Dirección*</label>
                                        <input type="text" class="form-control" name="address" id="address" required>
                                    </div>


                                    <h5>Datos de Contacto Adicional</h5>
                                    <div class="mb-2">
                                        <label for="contactName" class="col-form-label">Nombre
                                            completo*</label>
                                        <input type="text" class="form-control" name="contactName" id="contactName" required>
                                    </div>

                                    <div class="mb-2">
                                        <label for="contactPhone" class="col-form-label">Teléfono*</label>
                                        <input type="tel" class="form-control" name="contactPhone" id="contactPhone" required>
                                    </div>

                                    <div class="mb-2">
                                        <label for="contactEmail" class="col-form-label">Correo electrónico*</label>
                                        <input type="tel" class="form-control" name="contactPhone" id="contactEmail" required>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-secondary botonCafe" onclick="updateSupplier(event)">
                                        Modificar
                                    </button>
                                    <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                        Cancelar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <!--FILTRO DE BUSQUEDA DE PRODUCTO-->
            <!-- DATOS
            Nombre del proveedor* - Alfanumérico
            RFC* - Alfanumérico
            Correo electronico* - Alfanumérico
            -->
            <div class="mt-3">
                <form onsubmit="search(); return false;">
                    <div class="row d-flex justify-content-center">
                        <div class="col-3 ms-4">Nombre del proveedor</div>
                        <div class="col-3 ms-1">RFC</div>
                        <div class="col-3 ms-1">Correo electrónico</div>
                    </div>

                    <!--Clave del producto-->
                    <div class="row d-flex justify-content-center">
                        <div class="col-3">
                            <input id="nameSupplier" type="text" class="form-control"
                                   placeholder="Nombre(s) Apellidos">
                        </div>
                        <div class="col-3">
                            <input id="rfc" type="text" class="form-control" placeholder="RFC">
                        </div>
                        <!--Proveedor-->
                        <div class="col-3">
                            <input id="email" type="text" class="form-control" placeholder="alguien@example.com">
                        </div>

                        <!--Botones -->
                        <div class="grid gap-2 d-flex justify-content-end mt-5">
                            <button class="btn botonCafe mb-3" onsubmit="search()" id="">Buscar</button>
                            <button class="btn botonGris btn-light mb-3" id="" onreset="reset()">Limpiar</button>
                        </div>
                    </div>
                </form>
            </div>


            <div class="table-responsive table-container" id="contenedor">
                <table class="table table-bordered table-striped mt-0 text-center" id="resultTable">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col" colspan="8" class="tableTitle">INFORMACIÓN DE PROVEEDORES</th>
                    </tr>
                    <tr>
                        <th scope="col" class="thead">#</th>
                        <th scope="col" class="thead">Nombre</th>
                        <th scope="col" class="thead">RFC</th>
                        <th scope="col" class="thead">Teléfono</th>
                        <th scope="col" class="thead">Correo Electrónico</th>
                        <th scope="col" class="thead">Nombre Contacto</th>
                        <th scope="col" class="thead">Estado</th>
                        <th scope="col" class="thead">Acciones</th>

                    </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="provider" items="${providers}" varStatus="s">
                            <tr>
                                <th scope="row"><c:out value="${s.count}"/></th>
                                <td><c:out value="${provider.name}"/></td>
                                <td><c:out value="${provider.rfc}"/></td>
                                <td><c:out value="${provider.phone}"/></td>
                                <td><c:out value="${provider.email}"/></td>
                                <td><c:out value="${provider.contactName}"/></td>
                                <td>
                                    <h4>
                                        <span class="badge badge-pill <c:out value="${provider.status == true ? 'statusGreen' : 'statusRed'}"/>">
                                        <c:out value="${provider.status == true ? 'Activo' : 'Inactivo'}"/>
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

                                    <button onclick="update()" class="btn btn-lg botonEditar" data-bs-toggle="modal"
                                            data-bs-target="#updateSupplier">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                        </svg>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/provider/delete" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${provider.id}"/>
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
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script>
    // Obtener parámetros de la URL
    const urlParams = new URLSearchParams(window.location.search);
    const result = urlParams.get('result');
    const message = urlParams.get('message');
    // Función de validación del formulario
    function validateForm(formId) {
        const form = document.getElementById(formId);
        const cancelButton = document.querySelector('button[data-bs-dismiss="modal"]');
        let isValid = true;

        if (cancelButton && cancelButton.matches(':focus')) {
            // Si el botón de cancelar está enfocado, quitamos el estado 'was-validated'
            form.classList.remove('was-validated');
        }

        form.querySelectorAll('input, select, textarea').forEach(input => {
            if (input.required && (input.tagName === 'SELECT' && input.value === '' || !input.value.trim())) {
                isValid = false;
                form.classList.add('was-validated');
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });

        return isValid;
    }


    // Función para mostrar alerta de éxito
    function changeSuccess(message) {
        Swal.fire({
            toast: true,
            position: 'top-end',
            iconColor: 'white',
            icon: 'success',
            title: '¡Hecho!',
            text: message,
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
            customClass: {
                popup: 'no-select-popup colored-toast'
            }
        });
    }

    // Función para mostrar alerta de error
    function changeError(message) {
        Swal.fire({
            toast: true,
            position: 'top-end',
            iconColor: 'white',
            icon: 'error',
            title: '¡Error!',
            text: message,
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
            customClass: {
                popup: 'no-select-popup colored-toast'
            }
        });
    }

    // Función para mostrar confirmación antes de enviar el formulario
    function showSupplierConfirmation(message, form) {
        Swal.fire({
            icon: 'warning',
            title: '¡Cuidado!',
            text: message,
            showCancelButton: true,
            cancelButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-down-fill" viewBox="0 0 16 16">
                                      <path d="M6.956 14.534c.065.936.952 1.659 1.908 1.42l.261-.065a1.38 1.38 0 0 0 1.012-.965c.22-.816.533-2.512.062-4.51q.205.03.443.051c.713.065 1.669.071 2.516-.211.518-.173.994-.68 1.2-1.272a1.9 1.9 0 0 0-.234-1.734c.058-.118.103-.242.138-.362.077-.27.113-.568.113-.856 0-.29-.036-.586-.113-.857a2 2 0 0 0-.16-.403c.169-.387.107-.82-.003-1.149a3.2 3.2 0 0 0-.488-.9c.054-.153.076-.313.076-.465a1.86 1.86 0 0 0-.253-.912C13.1.757 12.437.28 11.5.28H8c-.605 0-1.07.08-1.466.217a4.8 4.8 0 0 0-.97.485l-.048.029c-.504.308-.999.61-2.068.723C2.682 1.815 2 2.434 2 3.279v4c0 .851.685 1.433 1.357 1.616.849.232 1.574.787 2.132 1.41.56.626.914 1.28 1.039 1.638.199.575.356 1.54.428 2.591"/>
                                    </svg>
                                </span> Cancelar.`,
            confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Sí, registrar.`,
            footer: '<span class="green">Nota: Puedes desactivarlo después</span>',
            reverseButtons: false,
            allowOutsideClick: false,
            allowEscapeKey: false,
            allowEnterKey: false,
            stopKeydownPropagation: true,
            customClass: {
                confirmButton: 'btn botonCafe',
                cancelButton: 'btn botonGris',
                popup: 'no-select-popup',
            }
        }).then((result) => {
            if (result.isConfirmed) {
                form.submit(); // Envía el formulario si se confirma
            }
        });
    }

    // Mostrar alerta en función del resultado
    if (result === 'true') {
        changeSuccess(decodeURIComponent(message));
    } else if (result === 'false') {
        changeError(decodeURIComponent(message));
    }

    // Función para manejar el registro de area de destino
    function registerSupplier(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const form = document.getElementById('supplierForm');
        if (validateForm('supplierForm')) { // Asegúrate de usar el ID correcto
            showSupplierConfirmation("¿Estás seguro de que deseas registrar a este proveedor?",form);
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Campos incompletos',
                text: 'Por favor llena todos los campos obligatorios del formulario.',
                confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Entendido.`,
                footer: '<span class="yellow">Nota: Todos los campos con asterisco son obligatorios</span>',
                allowOutsideClick: false,
                customClass: {
                    confirmButton: 'btn botonCafe',
                    cancelButton: 'btn botonGris',
                    popup: 'no-select-popup'
                }
            });
        }
    }

    // Función para manejar la actualización de area de destino
    function updateSupplier(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const form = document.getElementById('updateSupplierForm');
        if (validateForm('updateSupplierForm')) {
            showSupplierConfirmation("¿Estás seguro de que deseas actualizar a este proveedor?",form);
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Campos incompletos',
                text: 'Por favor llena todos los campos obligatorios del formulario.',
                confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Entendido.`,
                footer: '<span class="yellow">Nota: Todos los campos con asterisco son obligatorios</span>',
                allowOutsideClick: false,
                customClass: {
                    confirmButton: 'btn botonCafe',
                    cancelButton: 'btn botonGris',
                    popup: 'no-select-popup'
                }
            });
        }
    }
</script>
<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
