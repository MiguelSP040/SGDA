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
<html>
<head>
    <title>Proveedores</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
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
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Nuevo Proveedor</h1>
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
                                        <input type="tel" class="form-control" name="contactPhone" id="contactEmail" required>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary botonCafe" onclick="registerSupplier()">Registrar
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar
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
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Modificar Datos</h1>
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
                                    <button type="button" class="btn btn-secondary botonCafe" onclick="updateSupplier()">
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
                        <div class="grid gap-2"
                             style="justify-content: end; display: flex; margin-top: 50px;padding-left:5%;">
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
                        <c:forEach var="provider" items="${provider}">
                            <tr>
                                <th scope="row"><c:out value="${provider.id_provider}"/></th>
                                <td><c:out value="${provider.name}"/></td>
                                <td><c:out value="${provider.rfc}"/></td>
                                <td><c:out value="${provider.phone}"/></td>
                                <td><c:out value="${provider.email}"/></td>
                                <td><c:out value="${provider.contactname}"/></td>
                                <td><c:out value="${provider.status}"/></td>
                                <td>
                                    <button class="btn btn-lg botonVerMas" id="botonVerMas" onsubmit="viewMore()"><svg
                                            xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z" />
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0" />
                                    </svg></button>

                                    <button onclick="update()" class="btn btn-lg botonEditar" data-bs-toggle="modal"
                                            data-bs-target="#updateUser">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                        </svg>
                                    </button>
                                    <button onclick="deleteProvider()" class="btn btn-lg botonRojo">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                            <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5" />
                                        </svg>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>

                    <tr>
                        <th scope="row">2</th>
                        <td>GB12JAKNCX</td>
                        <td>MAPED</td>
                        <td> 01800 00</td>
                        <td>gperez@mapedsilco.com</td>
                        <td>Maped B2B</td>

                        <td>
                            <button class="btn statusGreen w-100" id="statusActivo">Activo</button>
                        </td>

                        <!--Botones de acciones de Proveedor-->
                        <td>
                            <button class="btn botonVerMas" id="botonVerMas" onsubmit="viewMore()">
                                <svg
                                        xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                                    <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
                                    <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>
                                </svg>
                            </button>

                            <button onclick="update()" class="btn botonEditar mb-1" id=""
                                    data-bs-toggle="modal" data-bs-target="#updateSupplier">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
                                </svg>
                            </button>
                            <button onclick="deleteProvider()" class="btn botonRojo">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
                                    <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5M11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47M8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5" />
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
<script src="../../assets/js/alerts.js"></script>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
