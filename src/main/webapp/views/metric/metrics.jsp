<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Unidades de medida"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    String email = (String) request.getSession(false).getAttribute("user");
    String role = (String) request.getSession(false).getAttribute("role");
    if (email == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<html>
<head>
    <title>Unidades de medida</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<%
    if ("Administrador".equals(role)) {
%>
<jsp:include page="../../layouts/menu.jsp"/>
<%
} else if ("Almacenista".equals(role)) {
%>
<jsp:include page="../../layouts/menu2.jsp"/>
<%
    }
%>

<!--CONTENEDOR TOTAL-->
<div class="container">
    <div class="container-fluid vh-100 d-flex justify-content-center align-items-center">
        <div class="card contenidoTotal shadow-lg p-5">

            <div><h3>Consulta de unidades de medida</h3></div>

            <div class="position-absolute top-10 end-0">
                <button class="btn btn-outline-secondary me-md-5" type="button" data-bs-toggle="modal"
                        data-bs-target="#registerMetric">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-cart-plus" viewBox="0 0 16 16">
                        <path d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9z"/>
                        <path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zm3.915 10L3.102 4h10.796l-1.313 7zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
                    </svg>
                    Nueva Medida
                </button>
            </div>

            <!--FILTRO DE BUSQUEDA DE PRODUCTO-->
            <!-- DATOS
                Nombre del proveedor* - Alfanumérico
                RFC* - Alfanumérico
                Correo electronico* - Alfanumérico
            -->
            <div class="mt-3">
                <form action="<%=context%>/metric/search" method="get">
                    <div class="row d-flex justify-content-center">
                        <div class="col-3 ms-3">Nombre</div>
                        <div class="col-3 ms-1">Abreviatura</div>
                        <div class="col-3 ms-1">Estado</div>
                    </div>

                    <div class="row d-flex justify-content-center">
                        <!--Nombre-->
                        <div class="col-3">
                            <input class="form-control" type="text" id="nameArea" name="name" placeholder="Nombre de la unidad de medida">
                        </div>
                        <!--Abreviatura-->
                        <div class="col-3">
                            <input class="form-control" type="text" id="shortNameArea" name="shortName" placeholder="Abreviatura de la unidad de medida">
                        </div>
                        <!--Estado-->
                        <div class="col-3">
                            <select class="form-select" name="status" aria-label="Seleccionar opción">
                                <option disabled selected value>
                                    Seleccionar opción
                                </option>
                                <option value="Activo">Activo</option>
                                <option value="Inactivo">Inactivo</option>
                            </select>
                        </div>

                        <!--Botones -->
                        <div class="grid gap-2 d-flex justify-content-end mt-5">
                            <!-- Botón Buscar -->
                            <button type="submit" class="btn botonCafe mb-3">
                                Buscar
                            </button>

                            <!-- Botón Limpiar -->
                            <button type="reset" class="btn botonGris btn-light mb-3">
                                Limpiar
                            </button>
                        </div>
                    </div>
                </form>
            </div>


            <!--MODAL Registro de Metrica-->
            <div class="modal fade" id="registerMetric" tabindex="-1" aria-labelledby="registerMetricLabel" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Nueva Unidad de medida</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="registerMetricsForm" method="post" action="/metric/save" novalidate>
                                <h5>Datos de Unidad de medida</h5>
                                <div class="mb-3">
                                    <label for="name" class="col-4">Nombre*</label>
                                    <input type="text" class="form-control mb-2" name="name" id="name" required pattern="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]{1,}(\s[A-ZÁÉÍÓÚÑa-záéíóúñ]*)*$">
                                    <div class="invalid-feedback">
                                        Debe empezar con mayúscula.
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="shortName">Abreviatura*</label>
                                    <input type="text" class="form-control" name="shortName" id="shortName" required pattern="^([A-ZÁÉÍÓÚÑ]{1}\s*)*$">
                                    <div class="invalid-feedback">
                                        Solo se admiten mayúsculas.
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="registerMetrics(event)">
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

            <!--MODAL ACTUALIZAR INFORMACION DE METRICAS -->
            <div class="modal fade" id="updateMetric" tabindex="-1" aria-labelledby="updateAreaLabel" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Editar información de unidad de medida</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateMetricForm" method="post" action="/metric/update" novalidate>
                                <input hidden id="u_id" name="id" >
                                <h5>Datos de Unidad de medida</h5>
                                <div class="mb-3">
                                    <label for="u_name" class="col-4">Nombre*</label>
                                    <input type="text" class="form-control mb-2" name="name" id="u_name" required pattern="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]{1,}(\s[A-ZÁÉÍÓÚÑa-záéíóúñ]*)*$">
                                    <div class="invalid-feedback">
                                        Debe empezar con mayúscula.
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="u_shortName">Abreviatura*</label>
                                    <input type="text" class="form-control" name="shortName" id="u_shortName" required pattern="^([A-ZÁÉÍÓÚÑ]{1}\s*)*$">
                                    <div class="invalid-feedback">
                                        Solo se admiten mayúsculas.
                                    </div>
                                </div>
                                <input hidden id="u_status" name="status">
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="updateMetrics(event)">
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


            <!--Tabla Consulta de Unidades de medida/Metricas -->
            <div class="table-responsive table-container" id="contenedor">
                <table class="table table-bordered table-striped mt-0 text-center">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col" colspan="6" class="tableTitle">UNIDADES DE MEDIDA
                        </th>
                    </tr>

                    <th scope="col" class="thead">#</th>
                    <th scope="col" class="thead">Abreviatura</th>
                    <th scope="col" class="thead">Nombre</th>
                    <th scope="col" class="thead">Estado</th>
                    <th scope="col" class="thead">Acciones</th>

                    </thead>
                    <tbody class="align-middle">
                        <c:forEach var="metric" items="${metrics}" varStatus="s">
                            <tr>
                                <th scope="row"><c:out value="${s.count}"/></th>
                                <td><c:out value="${metric.shortName}"/></td>
                                <td><c:out value="${metric.name}"/></td>
                                <td>
                                    <h4>
                                        <span class="badge badge-pill <c:out value="${metric.status == true ? 'statusGreen' : 'statusRed'}"/>">
                                        <c:out value="${metric.status == true ? 'Activo' : 'Inactivo'}"/>
                                    </span>
                                    </h4>
                                </td>
                                <td>
                                    <button  class="btn btn-lg botonEditar" data-bs-toggle="modal" data-bs-target="#updateMetric" onclick="putMetricInfo(${metric.getId()})">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                        </svg>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/metric/delete" method="post" style="display:inline;" id="changeStatusForm">
                                        <input type="hidden" name="id" value="${metric.id}"/>
                                        <button type="submit" class="btn btn-lg botonRojo" data-id="${metric.id}">
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
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script src="../../assets/js/updateMetrics.js"></script>
<script>
    // Función para validar un campo individualmente en tiempo real
    function validateField(input) {
        const form = input.closest('form'); // Obtén el formulario al que pertenece el campo
        if (input.required && !input.checkValidity()) {
            input.classList.add('is-invalid');
            form.classList.add('was-validated');
        } else {
            input.classList.remove('is-invalid');
            if (form.querySelectorAll('input:invalid, select:invalid, textarea:invalid').length === 0) {
                form.classList.remove('was-validated'); // Elimina 'was-validated' si todos los campos son válidos
            }
        }
    }

    // Configura la validación en tiempo real para todos los campos del formulario
    function setupRealTimeValidation(formId) {
        const form = document.getElementById(formId);

        form.querySelectorAll('input, select, textarea').forEach(input => {
            input.addEventListener('input', () => {
                validateField(input);
            });
        });
    }

    // Función para validar el formulario completo antes de enviar
    function validateForm(formId) {
        const form = document.getElementById(formId);
        let isValid = true;
        let isEmpty = true;

        form.querySelectorAll('input, select, textarea').forEach(input => {
            // Verifica si el formulario tiene algún campo lleno
            if (input.value.trim()) {
                isEmpty = false;
            }

            // Verifica si el campo es requerido y si cumple con el patrón (si está presente)
            if (input.required && !input.checkValidity()) {
                isValid = false;
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });

        // Si el formulario está vacío, muestra una advertencia de formulario vacío
        if (isEmpty) {
            showEmptyWarning();
            return false;
        }

        // Si algún campo no es válido, muestra una advertencia
        if (!isValid) {
            form.classList.add('was-validated');
            showWarningAlert();
            return false;
        }

        // Si es válido, aseguramos que la clase 'was-validated' esté eliminada
        form.classList.remove('was-validated');
        return true;
    }

    // Configura la validación en tiempo real al cargar la página
    document.addEventListener('DOMContentLoaded', () => {
        setupRealTimeValidation('registerMetricsForm');
        setupRealTimeValidation('updateMetricForm');
    });

    // Ejemplos de las funciones showWarningAlert y showEmptyWarning (deben estar definidas previamente)
    function showWarningAlert() {
        Swal.fire({
            icon: 'error',
            title: 'Campos inválidos',
            text: 'Por favor corrige los campos marcados en el formulario.',
            confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Entendido`,
            footer: '<span class="red">Nota: Ingresa datos válidos en el formulario</span>',
            allowOutsideClick: false,
            customClass: {
                confirmButton: 'btn botonCafe',
                cancelButton: 'btn botonGris',
                popup: 'no-select-popup'
            }
        });
    }

    function showEmptyWarning() {
        Swal.fire({
            icon: 'warning',
            title: 'Campos incompletos',
            text: 'Por favor llena todos los campos obligatorios del formulario.',
            confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Entendido`,
            footer: '<span class="yellow">Nota: Todos los campos con asterisco son obligatorios</span>',
            allowOutsideClick: false,
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
    function showMetricConfirmation(message, form) {
        Swal.fire({
            icon: 'warning',
            title: '¡Cuidado!',
            text: message,
            showCancelButton: true,
            cancelButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-down-fill" viewBox="0 0 16 16">
                                      <path d="M6.956 14.534c.065.936.952 1.659 1.908 1.42l.261-.065a1.38 1.38 0 0 0 1.012-.965c.22-.816.533-2.512.062-4.51q.205.03.443.051c.713.065 1.669.071 2.516-.211.518-.173.994-.68 1.2-1.272a1.9 1.9 0 0 0-.234-1.734c.058-.118.103-.242.138-.362.077-.27.113-.568.113-.856 0-.29-.036-.586-.113-.857a2 2 0 0 0-.16-.403c.169-.387.107-.82-.003-1.149a3.2 3.2 0 0 0-.488-.9c.054-.153.076-.313.076-.465a1.86 1.86 0 0 0-.253-.912C13.1.757 12.437.28 11.5.28H8c-.605 0-1.07.08-1.466.217a4.8 4.8 0 0 0-.97.485l-.048.029c-.504.308-.999.61-2.068.723C2.682 1.815 2 2.434 2 3.279v4c0 .851.685 1.433 1.357 1.616.849.232 1.574.787 2.132 1.41.56.626.914 1.28 1.039 1.638.199.575.356 1.54.428 2.591"/>
                                    </svg>
                                </span> Cancelar`,
            confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Sí, continuar`,
            footer: '<span class="green">Nota: Puedes cambiarlo después</span>',
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

    // Función para manejar el registro de una unidad de medida
    function registerMetrics(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const formId = 'registerMetricsForm';

        if (validateForm(formId)) {
            const form = document.getElementById(formId);
            showMetricConfirmation("¿Estás seguro de que deseas registrar esta unidad de medida?", form);
        }
    }

    // Función para manejar la actualización de una unidad de medida
    function updateMetrics(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const formId = 'updateMetricForm';

        if (validateForm(formId)) {
            const form = document.getElementById(formId);
            showMetricConfirmation("¿Estás seguro de que deseas actualizar esta unidad de medida?", form);
        }
    }

    // Función para cambiar el estado de una unidad de medida
    function handleChangeStatus(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const button = event.currentTarget;
        const metricId = button.getAttribute('data-id');
        const form = document.getElementById('changeStatusForm');

        // Actualiza el input hidden con el ID correcto
        form.querySelector('input[name="id"]').value = metricId;
        showMetricConfirmation('¿Estás seguro de que deseas cambiar el estado a esta unidad de medida?', form);
    }

    // Asocia la función a los botones cuando el DOM esté listo
    document.addEventListener('DOMContentLoaded', function() {
        const changeStatusButtons = document.querySelectorAll('.botonRojo');

        changeStatusButtons.forEach(button => {
            button.addEventListener('click', handleChangeStatus);
        });
    });
</script>
<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
