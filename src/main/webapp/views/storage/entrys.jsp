<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 04/08/2024
  Time: 09:30 a. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Entradas"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Entradas</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
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
                <h3>Consulta de entradas</h3>
            </div>

            <!-- Botón para registrar movimiento -->
            <div class="position-absolute top-10 end-0">
                <button class="btn btn-outline-secondary me-md-5" type="button" data-bs-toggle="modal"
                        data-bs-target="#registerMovement">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-plus-circle-fill" viewBox="0 0 16 16">
                        <path
                                d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z" />
                    </svg>
                    Registrar entrada
                </button>
            </div>


            <!-- Modal -->
            <!--DATOS DE ENTRADA
            Fecha de inicio*    - Fecha
            Fecha de fin*       - Fecha
            -->

            <!-- Modal Registro de Movimiento -->
            <div class="modal fade " id="registerMovement" tabindex="-1" aria-labelledby="registerMovementLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content w-100">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="registerMovementLabel">Registrar entrada</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="registerEntryMovementForm" method="post" action="">
                                <div class="row d-flex justify-content-center">
                                    <div class="col-3">Folio</div>
                                    <div class="col-3">Facturación</div>
                                    <div class="col-3">Proveedor</div>
                                    <div class="col-3">Almacenista</div>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="col me-2">
                                        <input class="form-control w-100" type="text" name="folio"
                                               placeholder="Folio" disabled>
                                    </div>
                                    <div class="col me-2">
                                        <input class="form-control w-100" type="text" name="billing"
                                               placeholder="Facturación" required>
                                    </div>
                                    <div class="col me-2">
                                        <select class="form-select" name="storeKeeperName" required>
                                            <option value="" disabled selected>Seleccionar un proveedor</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select class="form-select" name="storeKeeperName" required>
                                            <option value="" disabled selected>Seleccionar un almacenista</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                </div>

                                <!--Registrar una entrada-->

                                <!-- Campos para Entrada -->

                                <div class="table-responsive table-container">
                                    <table class="table table-bordered table-striped mt-0 text-center">
                                        <thead class="thead-dark">
                                        <tr>
                                            <th scope="col" style="width: 3%" id="tableTitle">#</th>
                                            <th scope="col" style="width: 25%" id="tableTitle">Producto*</th>
                                            <th scope="col" style="width: 13%" id="tableTitle">Medida*</th>

                                            <th scope="col" style="width: 15%" id="tableTitle">Precio*</th>
                                            <th scope="col" style="width: 10%" id="tableTitle">Cantidad*</th>
                                            <th scope="col" style="width: 10%" id="tableTitle">Precio total*
                                            </th>
                                            <th scope="col" style="width: 3%" id="tableTitle">Acciones*</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td> <select class="form-select" name="productName" required>
                                                <option value="" disabled selected>Seleccionar un producto
                                                </option>
                                                <option value="1">One</option>
                                                <option value="2">Two</option>
                                                <option value="3">Three</option>
                                            </select>
                                            </td>
                                            <td>
                                                <select class="form-select " name="metric" disabled>
                                                    <option value="Paq" selected>Tipo</option>
                                                </select>
                                            </td>
                                            <td> <input class="form-control w-100" type="number" name="price"
                                                        min="0" step="0.5" placeholder="$0.00" required>
                                            </td>
                                            <td> <input class="form-control" type="number" name="quantity"
                                                        min="1" step="1" placeholder="0" required>
                                            </td>
                                            <td> <input class="form-control" type="number" name="totalPrice"
                                                        placeholder="$0.00" disabled>
                                            </td>
                                            <td class="d-flex justify-content-end">
                                                <div class="btn-group">
                                                    <button class="btn botonVerMas">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                             fill="currentColor" class="bi bi-plus-circle-fill"
                                                             viewBox="0 0 16 16">
                                                            <path
                                                                    d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z" />
                                                        </svg>
                                                    </button>
                                                    <button class="btn botonRojo me-2">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                             fill="currentColor" class="bi bi-dash-circle-fill"
                                                             viewBox="0 0 16 16">
                                                            <path
                                                                    d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M4.5 7.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1z" />
                                                        </svg>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="modal-footer d-flex ">
                                    <div class="d-flex justify-content-start">
                                        <button class="btn btn-outline-secondary" type="button"
                                                data-bs-toggle="modal" data-bs-target="#newProduct">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                 fill="currentColor" class="bi bi-cart-plus" viewBox="0 0 16 16">
                                                <path
                                                        d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9z" />
                                                <path
                                                        d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zm3.915 10L3.102 4h10.796l-1.313 7zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0" />
                                            </svg>
                                            Nuevo Producto
                                        </button>
                                    </div>
                                    <div class="ms-auto">
                                        <button type="submit" class="btn botonCafe" id="registerButton"
                                                onclick="registerEntry()">Registrar</button>
                                        <button type="button" class="btn btn-outline-secondary"
                                                data-bs-dismiss="modal" onclick="reset()">Cancelar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Actualizar Entrada -->
            <div class="modal fade" id="updateEntryModal" tabindex="-1" aria-labelledby="updateEntryLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="updateEntryLabel">Actualizar Entrada</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateEntryForm" method="post" action="">
                                <div class="row">
                                    <!-- Campos para Entrada -->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="movementDate" class="form-label">Fecha del
                                                movimiento*</label>
                                            <input name="movementDate" type="date" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="invoiceNumber" class="form-label">Número de
                                                facturación*</label>
                                            <input name="invoiceNumber" type="text" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="supplierName" class="form-label">Proveedor*</label>
                                            <select id="supplierName" class="form-select" required>
                                                <option value="" disabled selected>Seleccionar un proveedor</option>
                                                <option value="1">One</option>
                                                <option value="2">Two</option>
                                                <option value="3">Three</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="storekeeperName" class="form-label">Almacenista*</label>
                                            <select id="storekeeperName" class="form-select" required>
                                                <option value="" disabled selected>Seleccionar un almacenista
                                                </option>
                                                <option value="1">One</option>
                                                <option value="2">Two</option>
                                                <option value="3">Three</option>
                                            </select>
                                        </div>

                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Unidad de medida*</label>
                                            <select class="form-select " name="metric" disabled>
                                                <option value="Paq" selected>Tipo</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="price" class="form-label">Precio*</label>
                                            <input class="form-control" type="number" name="quantity" min="0"
                                                   step="0.5" placeholder="$0.00" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="quantity" class="form-label">Cantidad*</label>
                                            <input class="form-control" type="number" name="quantity" min="1"
                                                   step="1" placeholder="0" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="totalPrice" class="form-label">Precio total*</label>
                                            <input name="totalPrice" type="number" class="form-control"
                                                   placeholder="$0.00" disabled>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Productos*</label>
                                        <select class="form-select" name="products"
                                                aria-label="Default select example" required>
                                            <option value="" disabled selected>Seleccionar un producto</option>
                                            <option value="1">One</option>
                                            <option value="2">Two</option>
                                            <option value="3">Three</option>
                                            <!-- Opciones aquí -->
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn botonGris btn-secondary"
                                            data-bs-dismiss="modal">Cancelar</button>
                                    <button onclick="updateEntry()" type="button" class="btn botonCafe"
                                            id="updateEntryButton">Actualizar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Nuevo Producto -->
            <div class="modal fade" id="newProduct" tabindex="-1" aria-labelledby="exampleModalLabel"
                 aria-hidden="true" data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Nuevo Producto</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="newProductForm" method="post" action="">
                                <div class="mb-3">
                                    <label for="productName" class="col-form-label">Nombre del Producto*</label>
                                    <input type="text" class="form-control" name="name" id="productName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="productAcronym" class="col-form-label">Acrónimo*</label>
                                    <input type="text" class="form-control" name="acronym" id="productAcronym"
                                           required>
                                </div>
                                <div class="mb-3">
                                    <label for="productMetric" class="col-form-label">Unidad de medida*</label>
                                    <select class="form-select" name="productMetric" id="productMetric" required>
                                        <option value="" disabled selected>Seleccionar una medida</option>
                                        <option value="Paq">Paquete</option>
                                        <option value="Caj">Caja</option>
                                        <option value="lt">Litro</option>
                                        <option value="Kg">Kilogramo</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="productDescription" class="col-form-label">Descripción*</label>
                                    <textarea class="form-control" name="description" id="productDescription"
                                              required></textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn botonCafe"
                                            onclick="registerProduct('newProductForm')">Registrar</button>
                                    <button type="button" class="btn btn-outline-secondary"
                                            data-bs-dismiss="modal">Cancelar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!--FILTRO POR FECHA DE INICIO Y FECHA FIN-->
            <div class="mt-3 ">
                <form onsubmit="search()">
                    <div class="row d-flex justify-content-center">
                        <div class="col-5 ms-4"> Fecha de Inicio</div>
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
                    <div class="grid gap-2"
                         style="justify-content: end; display: flex; margin-top: 50px;padding-left:5%;">
                        <button class="btn botonCafe mb-3" onsubmit="search()" id="botonCafe">Buscar
                        </button>
                        <button class="btn botonGris btn-light mb-3" id="botonGris" onreset="reset()">Limpiar
                        </button>
                    </div>
                </form>
            </div>


            <!--TABLA DE ENTRADAS-->
            <div class="table-responsive table-container" id="contenedor">
                <table class="table table-bordered table-striped mt-0 text-center">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col" colspan="11" id="tableTitle">REPORTE DE ENTRADAS
                        </th>
                    </tr>
                    <tr>
                        <th scope="col" id="thead">#</th>
                        <th scope="col" id="thead">Fecha</th>
                        <th scope="col" id="thead">Folio</th>
                        <th scope="col" id="thead">Producto</th>
                        <th scope="col" id="thead">Precio Unitario</th>
                        <th scope="col" id="thead">Precio Total</th>
                        <th scope="col" id="thead">Cantidad</th>
                        <th scope="col" id="thead">Unidad de medida</th>
                        <th scope="col" id="thead">Almacenista</th>
                        <th scope="col" id="thead">Status</th>
                        <th scope="col" id="thead">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">1</th>
                        <td>22/07/2024</td>
                        <td>E2024F1KL</td>
                        <td>Colores Maped</td>
                        <td>$000.00</td>
                        <td>$000.00</td>
                        <td>10</td>
                        <td>Paquete</td>
                        <td>Daniel Barrera</td>
                        <td>
                            <button class="btn statusGreen w-100" id="statusActivo">Activo</button>
                        </td>
                        <!--Columna de Botones de acción-->
                        <td>
                            <button class="btn botonVerMas" id="botonVerMas" onsubmit="viewMore()">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                    <path
                                            d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                    <path
                                            d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                </svg>
                            </button>
                            <button onclick="updateEntryModal()" class="btn botonEditar" id="botonEditar"
                                    data-bs-toggle="modal" data-bs-target="#updateEntryModal">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path
                                            d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                    <path fill-rule="evenodd"
                                          d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                </svg>
                            </button>
                            <button onclick="deleteEntry()" class="btn botonRojo" id="#">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                    <path
                                            d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5" />
                                </svg>
                            </button>

                        </td>
                    </tr>
                    <tr>
                        <th scope="row">2</th>
                        <td>22/07/2024</td>
                        <td>E2024F1KL</td>
                        <td>Colores Maped</td>
                        <td>$000.00</td>
                        <td>$000.00</td>
                        <td>10</td>
                        <td>Paquete</td>
                        <td>Daniel Barrera</td>
                        <td>
                            <button class="btn statusGreen w-100" id="statusActivo">Activo</button>
                        </td>
                        <!--Columna de Botones de acción-->
                        <td>
                            <button class="btn botonVerMas" id="botonVerMas" onsubmit="viewMore()">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                    <path
                                            d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                    <path
                                            d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                </svg>
                            </button>
                            <button onclick="updateEntryModal()" class="btn botonEditar" id="botonEditar"
                                    data-bs-toggle="modal" data-bs-target="#updateEntryModal">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path
                                            d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                    <path fill-rule="evenodd"
                                          d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                </svg>
                            </button>
                            <button onclick="deleteEntry()" class="btn botonRojo" id="#">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                    <path
                                            d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5" />
                                </svg>
                            </button>

                        </td>
                    </tr>
                    <tr>
                        <th scope="row">1</th>
                        <td>22/07/2024</td>
                        <td>E2024F1KL</td>
                        <td>Colores Maped</td>
                        <td>$000.00</td>
                        <td>$000.00</td>
                        <td>10</td>
                        <td>Paquete</td>
                        <td>Daniel Barrera</td>
                        <td>
                            <button class="btn statusGreen w-100" id="statusActivo">Activo</button>
                        </td>
                        <!--Columna de Botones de acción-->
                        <td>
                            <button class="btn botonVerMas" id="botonVerMas" onsubmit="viewMore()">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                    <path
                                            d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                    <path
                                            d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                </svg>
                            </button>
                            <button onclick="updateEntryModal()" class="btn botonEditar" id="botonEditar"
                                    data-bs-toggle="modal" data-bs-target="#updateEntryModal">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path
                                            d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                    <path fill-rule="evenodd"
                                          d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                </svg>
                            </button>
                            <button onclick="deleteEntry()" class="btn botonRojo" id="#">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                    <path
                                            d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5" />
                                </svg>
                            </button>

                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="pagination d-flex justify-content-center align-items-center mt-5">
                <button class="btn  me-2" aria-label="Previous Page">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                         class="bi bi-caret-left-fill" viewBox="0 0 16 16">
                        <path d="m3.86 8.753 5.482 4.796c.646.566 1.658.106 1.658-.753V3.204a1 1 0 0 0-1.659-.753l-5.48 4.796a1 1 0 0 0 0 1.506z" />
                    </svg>
                </button>
                <span class="page-info me-2">1-5</span>
                <button class="btn" aria-label="Next Page">
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
<script src="../../assets/js/alerts.js"></script>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>