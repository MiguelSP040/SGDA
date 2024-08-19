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

            <div class="modal fade" id="registerSupplier" tabindex="-1" aria-labelledby="registerSupplier" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="registerModalLabel">Nuevo Proveedor</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="supplierForm" method="post" action="/provider/save" novalidate>
                                <div class="row">
                                    <h5>Datos de Proveedor</h5>
                                    <div class="col-6">
                                        <div>
                                            <label for="name" class="col-form-label">Nombre del Proveedor*</label>
                                            <input type="text" class="form-control" name="name" id="name" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9]*\s*)*$">
                                            <div class="invalid-feedback">
                                                Debe empezar con mayúscula.
                                            </div>
                                        </div>

                                        <div>
                                            <label for="socialCase" class="col-form-label">Razón social*</label>
                                            <input type="text" class="form-control" name="socialCase" id="socialCase" required pattern="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]{1,}(\s[A-ZÁÉÍÓÚÑa-záéíóúñ]*)*$">
                                            <div class="invalid-feedback">
                                                Debe empezar con mayúscula.
                                            </div>
                                        </div>

                                        <div>
                                            <label for="rfc" class="col-form-label">RFC*</label>
                                            <input type="text" class="form-control" name="rfc" id="rfc" maxlength="13" minlength="12" required pattern="^[A-Z0-9]+$">
                                            <div class="invalid-feedback">
                                                Rango 12-13 caracteres.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">

                                        <div>
                                            <label for="phone" class="col-form-label">Teléfono*</label>
                                            <input type="tel" class="form-control" name="phone" id="phone" maxlength="10" minlength="10" required pattern="^[0-9]*$">
                                            <div class="invalid-feedback">
                                                Mínimo 10 caracteres.
                                            </div>
                                        </div>

                                        <div>
                                            <label for="email" class="col-form-label">Correo electrónico*</label>
                                            <input type="text" class="form-control" name="email" id="email" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}">
                                            <div class="invalid-feedback">
                                                formato: alguien@example.com
                                            </div>
                                        </div>

                                        <div>
                                            <label for="postCode" class="col-form-label">Codigo Postal*</label>
                                            <input type="text" class="form-control" name="postCode" id="postCode" maxlength="5" minlength="5" required pattern="^[0-9]*$">
                                            <div class="invalid-feedback">
                                                Mínimo 5 caracteres.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-align-center">
                                        <label for="address" class="col-form-label">Dirección*</label>
                                        <input type="text" class="form-control" name="address" id="address" required pattern="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]{1,}(\s[A-ZÁÉÍÓÚÑa-záéíóúñ]*)*$">
                                        <div class="invalid-feedback">
                                            Debe empezar con mayúscula.
                                        </div>
                                    </div>

                                    <div class="mt-3">
                                    <h5>Datos de Contacto Adicional</h5>
                                    </div>

                                    <div class="col-6">
                                        <label for="contactName" class="col-form-label">Nombre completo*</label>
                                        <input type="text" class="form-control" name="contactName" id="contactName" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$">
                                        <div class="invalid-feedback">
                                            Debe empezar con mayúscula.
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <label for="contactPhone" class="col-form-label">Teléfono*</label>
                                        <input type="tel" class="form-control" name="contactPhone" id="contactPhone" maxlength="10" minlength="10" required pattern="^[0-9]*$">
                                        <div class="invalid-feedback">
                                            Mínimo 10 caracteres.
                                        </div>
                                    </div>
                                    <div>
                                        <label for="contactEmail" class="col-form-label">Correo electrónico*</label>
                                        <input type="tel" class="form-control" name="contactEmail" id="contactEmail" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}">
                                        <div class="invalid-feedback">
                                            formato: alguien@example.com
                                        </div>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-secondary botonCafe" onclick="registerProvider(event)">
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

            <div class="modal fade" id="updateSupplier" tabindex="-1" aria-labelledby="updateSupplier" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="updateModalLabel">Editar información de proveedor</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateSupplierForm" method="post" action="/provider/update" novalidate>
                                <div class="row">
                                    <input hidden id="u_id" name="id">
                                    <h5>Datos de Proveedor</h5>
                                    <div class="col-6">
                                        <div>
                                            <label for="u_name" class="col-form-label">Nombre del Proveedor*</label>
                                            <input type="text" class="form-control" name="name" id="u_name" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-zA-ZáéíóúÁÉÍÓÚñÑ0-9]*\s*)*$">
                                            <div class="invalid-feedback">
                                                Debe empezar con mayúscula.
                                            </div>
                                        </div>

                                        <div>
                                            <label for="u_socialCase" class="col-form-label">Razón social*</label>
                                            <input type="text" class="form-control" name="socialCase" id="u_socialCase" required pattern="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]{1,}(\s[A-ZÁÉÍÓÚÑa-záéíóúñ]*)*$">
                                            <div class="invalid-feedback">
                                                Debe empezar con mayúscula.
                                            </div>
                                        </div>

                                        <div>
                                            <label for="u_rfc" class="col-form-label">RFC*</label>
                                            <input type="text" class="form-control" name="rfc" id="u_rfc" maxlength="13" minlength="12" required pattern="^[A-Z0-9]+$">
                                            <div class="invalid-feedback">
                                                Rango 12-13 caracteres.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">

                                        <div>
                                            <label for="u_phone" class="col-form-label">Teléfono*</label>
                                            <input type="tel" class="form-control" name="phone" id="u_phone" maxlength="10" minlength="10" required pattern="^[0-9]*$">
                                            <div class="invalid-feedback">
                                                Mínimo 10 caracteres.
                                            </div>
                                        </div>

                                        <div>
                                            <label for="u_email" class="col-form-label">Correo electrónico*</label>
                                            <input type="text" class="form-control" name="email" id="u_email" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}">
                                            <div class="invalid-feedback">
                                                formato: alguien@example.com
                                            </div>
                                        </div>

                                        <div>
                                            <label for="u_postCode" class="col-form-label">Codigo Postal*</label>
                                            <input type="text" class="form-control" name="postCode" id="u_postCode" maxlength="5" minlength="5" required pattern="^[0-9]*$">
                                            <div class="invalid-feedback">
                                                Mínimo 5 caracteres.
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-align-center">
                                        <label for="u_address" class="col-form-label">Dirección*</label>
                                        <input type="text" class="form-control" name="address" id="u_address" required pattern="^[A-ZÁÉÍÓÚÑ][a-záéíóúñ]{1,}(\s[A-ZÁÉÍÓÚÑa-záéíóúñ]*)*$">
                                        <div class="invalid-feedback">
                                            Debe empezar con mayúscula.
                                        </div>
                                    </div>

                                    <div class="mt-3">
                                        <h5>Datos de Contacto Adicional</h5>
                                    </div>

                                    <div class="col-6">
                                        <label for="u_contactName" class="col-form-label">Nombre completo*</label>
                                        <input type="text" class="form-control" name="contactName" id="u_contactName" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$">
                                        <div class="invalid-feedback">
                                            Debe empezar con mayúscula.
                                        </div>
                                    </div>

                                    <div class="col-6">
                                        <label for="u_contactPhone" class="col-form-label">Teléfono*</label>
                                        <input type="tel" class="form-control" name="contactPhone" id="u_contactPhone" maxlength="10" minlength="10" required pattern="^[0-9]*$">
                                        <div class="invalid-feedback">
                                            Mínimo 10 caracteres.
                                        </div>
                                    </div>
                                    <div>
                                        <label for="u_contactEmail" class="col-form-label">Correo electrónico*</label>
                                        <input type="tel" class="form-control" name="contactEmail" id="u_contactEmail" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}">
                                        <div class="invalid-feedback">
                                            formato: alguien@example.com
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-secondary botonCafe" onclick="updateProvider(event)">
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

            <!--[MODAL- MOSTRAR INFORMACION DE PROVEEDOR] -->
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

            <div class="modal fade" id="showSupplier" tabindex="-1" aria-labelledby="showSupplier" aria-hidden="true"
                 data-bs-backdrop="static">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">Más información</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                                <div class="row">
                                    <input hidden id="r_id" name="id">
                                    <h5>Datos de Proveedor</h5>
                                    <div class="col-6">
                                        <div>
                                            <label for="r_name" class="col-form-label">Nombre del Proveedor</label>
                                            <input type="text" class="form-control" name="name" id="r_name" readonly disabled>
                                        </div>

                                        <div>
                                            <label for="r_socialCase" class="col-form-label">Razón social</label>
                                            <input type="text" class="form-control" name="socialCase" id="r_socialCase" readonly disabled>
                                        </div>

                                        <div>
                                            <label for="r_rfc" class="col-form-label">RFC</label>
                                            <input type="text" class="form-control" name="rfc" id="r_rfc" readonly disabled>
                                        </div>
                                    </div>
                                    <div class="col-6">

                                        <div>
                                            <label for="r_phone" class="col-form-label">Teléfono</label>
                                            <input type="tel" class="form-control" name="phone" id="r_phone" readonly disabled>
                                        </div>

                                        <div>
                                            <label for="r_email" class="col-form-label">Correo electrónico</label>
                                            <input type="text" class="form-control" name="email" id="r_email" readonly disabled>
                                        </div>

                                        <div>
                                            <label for="r_postCode" class="col-form-label">Codigo Postal</label>
                                            <input type="text" class="form-control" name="postCode" id="r_postCode" readonly disabled>
                                        </div>
                                    </div>
                                    <div class="text-align-center">
                                        <label for="r_address" class="col-form-label">Dirección</label>
                                        <input type="text" class="form-control" name="address" id="r_address" readonly disabled>
                                    </div>

                                    <div class="mt-3">
                                        <h5>Datos de Contacto Adicional</h5>
                                    </div>


                                    <div class="col-6">
                                        <label for="r_contactName" class="col-form-label">Nombre completo</label>
                                        <input type="text" class="form-control" name="contactName" id="r_contactName" readonly disabled>
                                    </div>

                                    <div class="col-6">
                                        <label for="r_contactPhone" class="col-form-label">Teléfono</label>
                                        <input type="tel" class="form-control" name="contactPhone" id="r_contactPhone" readonly disabled>
                                    </div>

                                    <div>
                                        <label for="r_contactEmail" class="col-form-label">Correo electrónico</label>
                                        <input type="tel" class="form-control" name="contactEmail" id="r_contactEmail" readonly disabled>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary botonCafe" data-bs-dismiss="modal">
                                        Aceptar
                                    </button>
                                </div>
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
                <form action="<%=context%>/provider/search" method="get">
                    <div class="row d-flex justify-content-center">
                        <div class="col-3">Nombre del proveedor</div>
                        <div class="col-3">RFC</div>
                        <div class="col-3">Correo electrónico</div>
                        <div class="col-3">Estado</div>
                    </div>

                    <!--Clave del producto-->
                    <div class="row d-flex justify-content-center">
                        <div class="col-3">
                            <input name="name" type="text" class="form-control" placeholder="Nombre(s) Apellidos">
                        </div>
                        <div class="col-3">
                            <input name="rfc" type="text" class="form-control" placeholder="RFC">
                        </div>
                        <!--Proveedor-->
                        <div class="col-3">
                            <input name="email" type="text" class="form-control" placeholder="alguien@example.com">
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
                    <tbody class="align-middle">
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
                                    <button class="btn btn-lg botonVerMas" data-bs-toggle="modal" onclick="showProviderInformation(${provider.getId()})"
                                            data-bs-target="#showSupplier">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                            <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                            <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                        </svg>
                                    </button>

                                    <button class="btn btn-lg botonEditar" data-bs-toggle="modal" onclick="putProviderInformation(${provider.getId()})"
                                            data-bs-target="#updateSupplier">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                        </svg>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/provider/delete" method="post" style="display:inline;" id="changeStatusForm">
                                        <input type="hidden" name="id" value="${provider.id}"/>
                                        <button type="submit" class="btn btn-lg botonRojo" data-id="${provider.id}">
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
                <c:if test="${empty providers}">
                    <div class="alert alert-success d-flex align-items-center" role="alert">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-triangle-fill" viewBox="0 0 16 16">
                            <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                        </svg>
                        <div>
                            &nbsp;Aún no hay registros
                        </div>
                    </div>
                </c:if>
            </div>
            <!--Paginación al pie de Página -->
            <div class="pagination d-flex justify-content-center align-items-center mt-5">
                <c:if test="${not empty providers and totalPaginas > 1}">
                    <div class="pagination d-flex mt-2 mb-2">
                        <div class="btn-group" role="group" aria-label="Botones de paginación">
                            <c:if test="${paginaActual > 1}">
                                <a href="/provider/list-providers?page=${paginaActual - 1}" class="btn btn-light border-black"><< Anterior</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPaginas}" var="numeroPagina">
                                <c:choose>
                                    <c:when test="${numeroPagina == paginaActual}">
                                        <a href="/provider/list-providers?page=${numeroPagina}" class="btn btn-light active border-black">${numeroPagina}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/provider/list-providers?page=${numeroPagina}" class="btn btn-light border-black">${numeroPagina}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${paginaActual < totalPaginas}">
                                <a href="/provider/list-providers?page=${paginaActual + 1}" class="btn btn-light border-black">Siguiente >></a>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="../../assets/js/funciones.js"></script>
<script src="../../assets/js/udpateProviders.js"></script>
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
        setupRealTimeValidation('supplierForm');
        setupRealTimeValidation('updateSupplierForm');
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
    function showProviderConfirmation(message, form) {
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

    // Función para manejar el registro de un proveedor
    function registerProvider(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const formId = 'supplierForm';

        if (validateForm(formId)) {
            const form = document.getElementById(formId);
            showProviderConfirmation("¿Estás seguro de que deseas registrar a este proveedor?", form);
        }
    }

    // Función para manejar la actualización de un proveedor
    function updateProvider(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const formId = 'updateSupplierForm';

        if (validateForm(formId)) {
            const form = document.getElementById(formId);
            showProviderConfirmation("¿Estás seguro de que deseas actualizar a este proveedor?", form);
        }
    }

    // Función para cambiar el estado de un proveedor
    function handleChangeStatus(event) {
        event.preventDefault(); // Evita el envío automático del formulario
        const button = event.currentTarget;
        const providerId = button.getAttribute('data-id');
        const form = document.getElementById('changeStatusForm');

        // Actualiza el input hidden con el ID correcto
        form.querySelector('input[name="id"]').value = providerId;
        showProviderConfirmation('¿Estás seguro de que deseas cambiar el estado a este proveedor?', form);
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
