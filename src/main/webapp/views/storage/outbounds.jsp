
<%@ page import="com.utez.edu.almacen.models.metric.BeanMetric" %>
<%@ page import="com.utez.edu.almacen.models.user.BeanLoggedUser" %>
<%@ page import="java.util.List" %>
<%@ page import="com.utez.edu.almacen.models.metric.DaoMetric" %>
<%@ page import="com.utez.edu.almacen.models.product.DaoProduct" %>
<%@ page import="com.utez.edu.almacen.models.product.BeanProduct" %>
<%@ page import="com.utez.edu.almacen.models.provider.DaoProvider" %>
<%@ page import="com.utez.edu.almacen.models.provider.BeanProvider" %>
<%@ page import="com.utez.edu.almacen.models.area.DaoArea" %>
<%@ page import="com.utez.edu.almacen.models.area.BeanArea" %>
<%@ page import="com.utez.edu.almacen.models.user.DaoUser" %>
<%@ page import="com.utez.edu.almacen.models.user.BeanUser" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Salidas de almacén"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    String email = (String) request.getSession(false).getAttribute("user");
    String role = (String) request.getSession(false).getAttribute("role");
    if (email == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    BeanLoggedUser user = (BeanLoggedUser) request.getAttribute("user");
    List<BeanMetric> metrics = new DaoMetric().listAll();
    List<BeanProduct> products = new DaoProduct().listAll();
    List<BeanProvider> providers = new DaoProvider().listAll();
    List<BeanArea> areas = new DaoArea().listAll();
    List<BeanUser> users = new DaoUser().listAll();
    List<BeanProduct> stocks = new DaoProduct().listAllStock();
%>
<html>
<head>
    <title>Salidas de almacén</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

            <!--SECCION DE TITULO DE LA CARD Y BOTON QUE ACTIVA EL MODAL DE REGISTRO DE UN MOVIMIENTO {ENTRADA/SALIDA}-->
            <div class="position-relative">
                <h3>Consulta de salidas</h3>
            </div>

            <!-- Botón para registrar movimiento -->
            <div class="position-absolute top-10 end-0">
                <button class="btn btn-outline-secondary me-md-5" onclick="generateFolioNumber()" type="button" data-bs-toggle="modal"
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
                            <form id="registerOutboundForm" method="post" action="<%=context%>/storage/save-Exit">
                                <h5>Datos de la Salida</h5>
                                <div class="row d-flex justify-content-center">
                                    <div class="col-3"><label for="folioNumber">Folio</label></div>
                                    <div class="col-3"><label for="invoiceNumber">Facturación</label></div>
                                    <div class="col-3"><label for="id_area">Área</label></div>
                                    <div class="col-3"><label for="id_user">Almacenista</label></div>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="col me-2">
                                        <input class="form-control w-100" type="text" name="folioNumber" id="folioNumber" placeholder="Folio" required readonly>
                                    </div>
                                    <div class="col me-2">
                                        <input class="form-control w-100" type="text" name="invoiceNumber" id="invoiceNumber" maxlength="9" placeholder="Facturación"
                                               required title="Solo se admiten números." pattern="^[0-9]*$">
                                    </div>
                                    <div class="col me-2">
                                        <select class="form-select" name="id_area" id="id_area" required title="Elige una área.">
                                            <option disabled selected value>Seleccionar opción</option>
                                            <% for (BeanArea a : areas) { %>
                                            <% if (a.getStatus()) { %>
                                            <option value="<%= a.getId() %>"><%= a.getName() %></option>
                                            <% } %>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <input type="hidden" name="id_user" id="id_user" value="<%= user.getId() %>">
                                        <input class="form-control w-100" value="<%= user.getName() %>" required disabled>
                                    </div>
                                </div>

                                <!-- Campos para Salida -->
                                <div class="table-responsive table-container">
                                    <table class="table table-bordered table-striped text-center" id="outboundTable">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th scope="col" style="width: 3%" class="tableTitle">#</th>
                                            <th scope="col" style="width: 25%" class="tableTitle"><label for="id_product">Producto*</label></th>
                                            <th scope="col" style="width: 10%" class="tableTitle"><label for="id_metric">Medida*</label></th>
                                            <th scope="col" style="width: 18%" class="tableTitle"><label for="id_provider">Proveedor*</label></th>
                                            <th scope="col" style="width: 10%" class="tableTitle"><label for="unitPrice">Precio*</label></th>
                                            <th scope="col" style="width: 10%" class="tableTitle"><label for="quantity">Cantidad*</label></th>
                                            <th scope="col" style="width: 10%" class="tableTitle"><label for="total_price">Precio total*</label></th>
                                            <th scope="col" style="width: 3%;" class="tableTitle">Acciones</th>
                                        </tr>
                                        </thead>
                                        <tbody class="align-middle">
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>
                                                <select class="form-select product-select" name="idProduct" required title="Elige un producto.">
                                                    <option disabled selected value>Seleccionar opción</option>
                                                    <% for (BeanProduct p : stocks) { %>
                                                    <% if (p.getQuantity() != 0) { %>
                                                    <option value="<%= p.getId() %>"><%= p.getName() %> Stock: <%=p.getQuantity()%></option>
                                                    <% } %>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td>
                                                <input class="form-control product-metric" type="text" name="id_metric" placeholder="Automático" required readonly>
                                            </td>
                                            <td>
                                                <select class="form-select mb-2" name="id_provider" id="id_provider" required title="Elige a un proveedor.">
                                                    <option disabled selected value>Seleccionar opción</option>
                                                    <% for (BeanProvider pr : providers) { %>
                                                    <% if (pr.getStatus()) { %>
                                                    <option value="<%= pr.getId() %>"><%= pr.getName() %></option>
                                                    <% } %>
                                                    <% } %>
                                                </select>
                                            </td>
                                            <td>
                                                <input class="form-control unit-price" type="number" name="unitPrice" max="9999999" min="0" step="0.01" placeholder="$0.00" required title="Ingresa un valor.">
                                            </td>
                                            <td>
                                                <input class="form-control quantity" type="number" name="quantity" max="999999" min="1" step="1" placeholder="0" required title="Ingresa un valor.">
                                            </td>
                                            <td>
                                                <input class="form-control total-price" type="number" name="total_price" placeholder="$0.00" readonly>
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
                                <div class="modal-footer d-flex">
                                    <div class="me-auto">
                                        <div class="d-flex flex-column justify-content-start">
                                            <label for="buyerName" class="mb-0 mt-1">Receptor:</label>
                                            <input class="form-control w-100 mb-2" type="text" name="buyerName" id="buyerName" placeholder="Receptor" required title="Debe empezar con mayúscula." pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$">
                                        </div>
                                    </div>
                                    <div class="d-flex flex-column align-items-start me-2">
                                        <label for="totalAllPrices" class="mb-0 mt-1">Total General:</label>
                                        <input class="form-control totalAllPrices mb-2" type="number" name="totalAllPrices" id="totalAllPrices" placeholder="Total" readonly>
                                    </div>
                                    <div class="d-flex align-items-center mt-4">
                                        <button type="submit" class="btn botonCafe me-2" onclick="registerOutbound(event)">
                                            Registrar
                                        </button>
                                        <button type="reset" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                            Cancelar
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Revisar Salida -->
            <div class="modal fade" id="reviewOutboundModal" tabindex="-1" aria-labelledby="reviewOutboundLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content w-100">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="reviewEntryLabel">Más información</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h5>Datos de la Salida</h5>
                            <div class="row d-flex justify-content-center">
                                <div class="col-3"><label for="r_folioNumber">Folio</label></div>
                                <div class="col-3"><label for="r_invoiceNumber">Facturación</label></div>
                                <div class="col-3"><label for="r_id_area">Área</label></div>
                                <div class="col-3"><label for="r_id_user">Almacenista</label></div>
                            </div>
                            <div class="d-flex align-items-center mb-4">
                                <div class="col me-2">
                                    <input class="form-control w-100" type="text" name="folioNumber" id="r_folioNumber" readonly>
                                </div>
                                <div class="col me-2">
                                    <input class="form-control w-100" type="text" name="invoiceNumber" id="r_invoiceNumber" readonly>
                                </div>
                                <div class="col me-2">
                                    <input class="form-control w-100" type="text" name="id_area" id="r_id_area" readonly>
                                </div>
                                <div class="col">
                                    <input class="form-control w-100" type="text" name="id_user" id="r_id_user" readonly>
                                </div>
                            </div>

                            <!-- Campos para Salida -->
                            <div class="table-responsive table-container">
                                <table class="table table-bordered table-striped mt-0 text-center" id="reviewEntryTable">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th scope="col" style="width: 3%" class="tableTitle">#</th>
                                        <th scope="col" style="width: 25%" class="tableTitle"><label for="r_idProduct">Producto*</label></th>
                                        <th scope="col" style="width: 18%" class="tableTitle"><label for="r_id_metric">Medida*</label></th>
                                        <th scope="col" style="width: 10%" class="tableTitle"><label for="r_unitPrice">Precio*</label></th>
                                        <th scope="col" style="width: 10%" class="tableTitle"><label for="r_quantity">Cantidad*</label></th>
                                        <th scope="col" style="width: 10%" class="tableTitle"><label for="r_total_price">Precio total*</label></th>
                                    </tr>
                                    </thead>
                                    <tbody class="align-middle">
                                    <tr>
                                        <th scope="row">1</th>
                                        <td>
                                            <input class="form-control w-100 metric" type="text" name="id_product" id="r_idProduct" readonly/>
                                        </td>
                                        <td>
                                            <input class="form-control w-100 metric" name="id_metric" id="r_id_metric" placeholder="Automático" readonly>
                                        </td>
                                        <td>
                                            <input class="form-control unit-price" type="number" name="unitPrice" id="r_unitPrice" placeholder="$0.00" readonly>
                                        </td>
                                        <td>
                                            <input class="form-control quantity" type="number" name="quantity" id="r_quantity" placeholder="0" readonly>
                                        </td>
                                        <td>
                                            <input class="form-control total-price" type="number" name="total_price" id="r_total_price" placeholder="$0.00" readonly>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer d-flex">
                                <div class="me-auto">
                                    <div class="d-flex flex-column justify-content-start">
                                        <label for="buyerName" class="mb-0 mt-1">Receptor:</label>
                                        <input class="form-control w-100 mb-2" type="text" name="buyerName" id="r_buyerName" placeholder="Receptor" readonly>
                                    </div>
                                </div>
                                <div class="d-flex flex-column align-items-start me-2">
                                    <label for="totalAllPrices" class="mb-0 mt-1">Total General:</label>
                                    <input class="form-control totalAllPrices mb-2" type="number" name="totalAllPrices" id="r_totalAllPrices" placeholder="Total" readonly>
                                </div>
                                <div class="d-flex align-items-center mt-4">
                                    <button type="button" class="btn botonCafe" data-bs-dismiss="modal">
                                        Aceptar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--FILTRO POR FECHA DE INICIO Y FECHA FIN-->
            <div class="mt-3">
                <form action="<%=context%>/storage/search-exit" method="get">
                    <div class="row d-flex justify-content-center">
                        <div class="col-5 ms-4">Fecha de Inicio</div>
                        <div class="col-5 ms-1">Fecha Final</div>
                    </div>

                    <!--Input de Fecha de Inicio-->
                    <div class="row d-flex justify-content-center">
                        <div class="col-5">
                            <input type="date" name="fechaInicio" class="form-control">
                        </div>

                        <!--Input de Fecha Final-->
                        <div class="col-5">
                            <input type="date" name="fechaFin" class="form-control">
                        </div>
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
                        <th scope="col" class="thead">Destino</th>
                        <th scope="col" class="thead">Almacenista</th>
                        <th scope="col" class="thead">Precio Total</th>
                        <th scope="col" class="thead">Acciones</th>
                    </tr>
                    </thead>
                    <tbody class="align-middle">
                    <c:forEach var="exit" items="${exits2}" varStatus="s">
                        <tr>
                            <th scope="row"><c:out value="${s.count}"/></th>
                            <td><c:out value="${exit.changeDate}"/></td>
                            <td><c:out value="${exit.folioNumber}"/></td>
                            <td><c:out value="${exit.invoiceNumber}"/></td>
                            <td><c:out value="${exit.areaName}"/></td>
                            <td><c:out value="${exit.userName}"/></td>
                            <td><c:out value="${exit.totalAllPrices}"/></td>
                            <!--Columna de Botones de acción-->
                            <td>
                                <button class="btn btn-lg botonVerMas" onclick="showProducts('${exit.folioNumber}','${exit.invoiceNumber}','${exit.buyerName}','${exit.userName}',${exit.idExit},'${exit.productName}','${exit.metricName}',${exit.unitPrice},${exit.quantity},${exit.totalPrice})" data-bs-toggle="modal" data-bs-target="#reviewOutboundModal">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>
                                    </svg>
                                </button>
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

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<!--Validar formularios-->
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
        setupRealTimeValidation('registerOutboundForm');
        setupRealTimeValidation('updateOutboundForm');
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
    function showMovementConfirmation(message, form) {
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

    // Función para actualizar usuario
    function registerOutbound(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const formId = 'registerOutboundForm';

        if (validateForm(formId)) {
            const form = document.getElementById(formId);
            showMovementConfirmation("¿Estás seguro de que deseas registrar esta salida?", form);
        }
    }

    // Función para actualizar usuario
    function updateOutbound(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const formId = 'updateOutboundForm';

        if (validateForm(formId)) {
            const form = document.getElementById(formId);
            showMovementConfirmation("¿Estás seguro de que deseas actualizar esta salida?", form);
        }
    }
</script>
<!--Calcular precios en las múltiples filas-->
<script>
    // Script para realizar el cálculo de precio unitario, cantidad y precio total
    document.addEventListener('DOMContentLoaded', () => {
        // Función para actualizar el precio total en una fila de la tabla
        function updateTableTotalPrice(row) {
            const unitPrice = parseFloat(row.querySelector('.unit-price').value) || 0;
            const quantity = parseInt(row.querySelector('.quantity').value, 10) || 0;
            const totalPrice = unitPrice * quantity;
            row.querySelector('.total-price').value = totalPrice.toFixed(2); // Ajusta a dos decimales
            updateTotalAllPrices(); // Actualiza el total de todos los precios
        }

        // Función para actualizar el precio total en el modal
        function updateModalTotalPrice() {
            const unitPrice = parseFloat(document.getElementById('modalUnitPrice').value) || 0;
            const quantity = parseInt(document.getElementById('modalQuantity').value, 10) || 0;
            const totalPrice = unitPrice * quantity;
            document.getElementById('modalTotalPrice').value = totalPrice.toFixed(2); // Ajusta a dos decimales
        }

        // Función para actualizar el total de todos los precios
        function updateTotalAllPrices() {
            let totalAllPrices = 0;
            document.querySelectorAll('#outboundTable tbody .total-price').forEach(input => {
                totalAllPrices += parseFloat(input.value) || 0;
            });
            document.getElementById('totalAllPrices').value = totalAllPrices.toFixed(2); // Ajusta a dos decimales
        }

        // Event listeners para inputs en la tabla
        document.querySelector('#outboundTable tbody').addEventListener('input', (event) => {
            if (event.target.classList.contains('unit-price') || event.target.classList.contains('quantity')) {
                // Encuentra la fila actual
                const row = event.target.closest('tr');
                updateTableTotalPrice(row);
            }
        });

        // Event listeners para inputs en el modal
        document.getElementById('modalUnitPrice').addEventListener('input', updateModalTotalPrice);
        document.getElementById('modalQuantity').addEventListener('input', updateModalTotalPrice);
    });
</script>
<!--Añadir o eliminar filas-->
<script>
    // Función para añadir una fila de la tabla
    function addRow(button) {
        // Obtener la fila actual (donde se hizo clic en el botón)
        const currentRow = button.closest('tr');
        // Obtener el cuerpo de la tabla
        const tableBody = currentRow.parentElement;

        // Clonar la fila actual para crear una nueva fila vacía
        const newRow = currentRow.cloneNode(true);

        // Limpiar los valores de los campos en la nueva fila
        const inputs = newRow.querySelectorAll('input, select');
        inputs.forEach(input => {
            if (input.type === 'text' || input.type === 'number') {
                input.value = '';
            } else if (input.tagName === 'SELECT') {
                input.selectedIndex = 0;
            }
        });

        // Insertar la nueva fila después de la fila actual
        currentRow.insertAdjacentElement('afterend', newRow);

        // Actualizar los índices de todas las filas
        updateRowIndices();
    }

    // Función para eliminar una fila de la tabla
    function removeRow(button) {
        // Obtener la fila actual y el cuerpo de la tabla
        const row = button.closest('tr');
        const tableBody = row.parentElement;

        // Eliminar la fila si no es la única
        if (tableBody.children.length > 1) {
            row.remove();
            // Actualizar los índices de todas las filas
            updateRowIndices();
        } else {
            showErrorAlert('No se puede eliminar la única fila.');
        }
    }

    // Función para actualizar los índices de la tabla
    function updateRowIndices() {
        const rows = document.querySelectorAll('tbody tr');
        rows.forEach((row, index) => {
            const indexCell = row.querySelector('th');
            if (indexCell) {
                indexCell.textContent = index + 1; // Actualizar el índice de la fila
            }
        });
    }
</script>
<!--Generar folio automático-->
<script>
    function generateFolioNumber() {
        var year = new Date().getFullYear(); // Obtener el año actual
        var randomDigits = Math.floor(1000 + Math.random() * 9000); // Generar 4 números aleatorios
        var folio = "S" + year + randomDigits; // Concatenar E + año + 4 números
        document.getElementById('folioNumber').value = folio
        console.log(folio);
    }
</script>
<!--Colocar unidad de medida automáticamente-->
<script>
    $(document).ready(function() {
        $(document).on('change', '.product-select', function() {
            var $row = $(this).closest('tr');
            var idProducto = $(this).val();
            var contextPath = '';
            var $metricField = $row.find('.product-metric');

            console.log("ID Producto seleccionado:", idProducto);

            if (idProducto) {
                $.ajax({
                    url: contextPath + '/ServletPutMetric',
                    type: 'GET',
                    data: { id_product: idProducto },
                    success: function(response) {
                        console.log("Respuesta del servidor:", response);

                        // Verifica si la respuesta es válida y establece el valor de la métrica
                        if (response && response.name) {
                            $metricField.val(response.name);
                        } else {
                            $metricField.val('Métrica no encontrada.');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("Error en la solicitud AJAX:", status, error);
                        $metricField.val('Error al cargar la métrica.');
                    }
                });
            } else {
                $metricField.val('');
            }
        });
    });
</script>
<script>
    function showProducts(folio, facturacion, proovedor, almacenista, id, producto, medida, precio, cantidad, total) {
        document.getElementById("r_folioNumber").value = folio;
        document.getElementById("r_invoiceNumber").value = facturacion;
        document.getElementById("r_id_user").value = almacenista;
        document.getElementById("r_id_Exit").textContent = id;
        document.getElementById("r_idProduct").value = producto;
        document.getElementById("r_id_metric").value = medida;
        document.getElementById("r_unitPrice").value = precio;
        document.getElementById("r_quantity").value = cantidad;
        document.getElementById("u_id").value = total;
        console.log(folio, facturacion, proovedor, almacenista, id, producto, medida, precio, cantidad, total);
    }
</script>
<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
S