<%--
  Created by IntelliJ IDEA.
  User: DS
  Date: 8/4/2024
  Time: 3:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("pageTitle", "Usuario"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Perfil de usuario</title>
    <link href="../../assets/css/estilos.css" rel="stylesheet">
    <jsp:include page="../../layouts/header.jsp"/>
</head>
<body>
<jsp:include page="../../layouts/menu.jsp"/>


<div class="container">
    <div class="container-fluid vh-100 d-flex justify-content-center align-items-center">
        <div class="card contenidoTotal shadow-lg p-5">
            <div class="position-relative fs-1">
                Perfil de usuario
            </div>
            <div class="d-flex justify-content-end">
                <button onclick="update()" class="btn btn-outline-secondary" data-bs-toggle="modal"
                        data-bs-target="#updateUser"> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                           fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                    <path
                            d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                    <path fill-rule="evenodd"
                          d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                </svg> Editar datos
                </button>
            </div>

            <!-- DATOS DE CONSULTA
            Nombre completo* - Alfanumérico
            Correo electrónico* - Alfanumérico
            Rol del usuario* (Administrador/Almacenista)
            Estado del usuario* - Selección de lista (Activo/Inactivo)
            Teléfono - Numérico
            -->
            <div class="row justify-content-center">

                <!--NAME-->
                <div class="col-3">
                    <div class="mt-4">
                        <label id="userName" for="userName" class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                                <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
                            </svg> Nombre de usuario</label>
                        <div class="row">
                            <div class="col">
                                <span class="userName fw-bold fs-5">Isael Alejandro Vargas </span>
                            </div>
                        </div>
                    </div>
                    <!--EMAIL-->
                    <div class=" mt-4">
                        <label id="email" for="email" class="fs-4"><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                            <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
                        </svg> Correo electrónico</label>
                        <div class="row">
                            <div class="col">
                                <span class="email fw-bold fs-5">isaelvargas@gmail.com </span>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-3">
                    <!--ROL-->
                    <div class="mt-4">
                        <label id="rol" for="rol" class="fs-4"> <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-briefcase" viewBox="0 0 16 16">
                            <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v8A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-8A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5m1.886 6.914L15 7.151V12.5a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5V7.15l6.614 1.764a1.5 1.5 0 0 0 .772 0M1.5 4h13a.5.5 0 0 1 .5.5v1.616L8.129 7.948a.5.5 0 0 1-.258 0L1 6.116V4.5a.5.5 0 0 1 .5-.5"/>
                        </svg>
                            Rol de usuario
                        </label>
                        <div class="row">
                            <div class="col">
                    <span class="rol fw-bold fs-5" >
                       Administrador
                    </span>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <label id="phone" for="rol" class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-telephone" viewBox="0 0 16 16">
                                <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.6 17.6 0 0 0 4.168 6.608 17.6 17.6 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.68.68 0 0 0-.58-.122l-2.19.547a1.75 1.75 0 0 1-1.657-.459L5.482 8.062a1.75 1.75 0 0 1-.46-1.657l.548-2.19a.68.68 0 0 0-.122-.58zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z"/>
                            </svg> Teléfono
                        </label>
                        <div class="row">
                            <div class="col">
                                <span class="fw-bold fs-5" name="phone">77743838948</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-3">
                    <!--ROL-->
                    <div class="mt-4">
                        <label id="status" for="status" class="fs-4"> <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-bullseye" viewBox="0 0 16 16">
                            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
                            <path d="M8 13A5 5 0 1 1 8 3a5 5 0 0 1 0 10m0 1A6 6 0 1 0 8 2a6 6 0 0 0 0 12"/>
                            <path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6m0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8"/>
                            <path d="M9.5 8a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0"/>
                        </svg> Estado</label>

                        <div class="row">
                            <div class="col align-items-center">
                                <span class="rol fw-bold fs-5" style="color:dodgerblue;">Activo</span>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4 mb-4">
                        <label id="password" for="password" class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-lock" viewBox="0 0 16 16">
                                <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m0 5.996V14H3s-1 0-1-1 1-4 6-4q.845.002 1.544.107a4.5 4.5 0 0 0-.803.918A11 11 0 0 0 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664zM9 13a1 1 0 0 1 1-1v-1a2 2 0 1 1 4 0v1a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1h-4a1 1 0 0 1-1-1zm3-3a1 1 0 0 0-1 1v1h2v-1a1 1 0 0 0-1-1"/>
                            </svg> Contraseña
                        </label>
                        <div class="row">
                            <div class="col">
                                <span class="fw-bold fs-5" name="password">
                                     ************</span>
                            </div>
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
                        <form id="updateUserForm" method="post" action="">
                            <div class="row">
                                <label for="name" class="col">Nombre(s)*</label>
                                <label for="paternalLastName" class="col" id="paternalLastName">Apellido paterno*</label>
                            </div>
                            <div class="row">
                                <div class="col"><input type="text" name="name" class="col-3 form-control"
                                                        required>
                                </div>
                                <div class="col"><input type="text" name="paternalLastName" class="form-control"
                                                        required></div>
                            </div>
                            <div class="row">
                                <label for="mothersLastName" class="col">Apellido materno*</label>
                                <label class="col" for="phoneNumber">Teléfono*</label>
                            </div>
                            <div class="row">
                                <div class="col"><input type="text" name="mothersLastName" class="form-control"
                                                        required></div>
                                <div class="col"><input type="tel" name="phoneNumber" class="form-control"
                                                        required>
                                </div>
                            </div>
                            <div class="row" style="text-indent: 2%!important;">
                                <label class="col-8" for="email">Correo electrónico*</label>
                            </div>
                            <div class="row">
                                <div class="col"><input type="email" name="email" class="form-control" required>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn botonCafe"
                                        onclick="registerUser('updateUserForm')">Registrar</button>
                                <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Cancelar</button>
                            </div>
                        </form>
                    </div>
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
