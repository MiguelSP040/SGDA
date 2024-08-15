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
                <div class="row">
                    <button onclick="update()" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#updateUser">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                        </svg>
                        Editar datos
                    </button>
                </div>
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
                            </svg>
                            Nombre(s)
                        </label>
                        <div class="row">
                            <div class="col">
                                <span class="userName fw-bold fs-5">Isael Alejandro</span>
                            </div>
                        </div>
                    </div>
                    <!--TELEFONO-->
                    <div class="mt-4">
                        <label for="rol" class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-telephone" viewBox="0 0 16 16">
                                <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.6 17.6 0 0 0 4.168 6.608 17.6 17.6 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.68.68 0 0 0-.58-.122l-2.19.547a1.75 1.75 0 0 1-1.657-.459L5.482 8.062a1.75 1.75 0 0 1-.46-1.657l.548-2.19a.68.68 0 0 0-.122-.58zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z"/>
                            </svg>
                            Teléfono
                        </label>
                        <div class="row">
                            <div class="col">
                                <span class="fw-bold fs-5">77743838948</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <!--ROL-->
                    <div class="mt-4">
                        <label id="rol" for="rol" class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                                <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
                            </svg>
                            Apellidos
                        </label>
                        <div class="row">
                            <div class="col">
                                <span class="rol fw-bold fs-5">Reyes Vargas</span>
                            </div>
                        </div>
                    </div>
                    <!--ESTADO-->
                    <div class="mt-4">
                        <label id="status" for="status" class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-briefcase" viewBox="0 0 16 16">
                                <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v8A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-8A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5m1.886 6.914L15 7.151V12.5a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5V7.15l6.614 1.764a1.5 1.5 0 0 0 .772 0M1.5 4h13a.5.5 0 0 1 .5.5v1.616L8.129 7.948a.5.5 0 0 1-.258 0L1 6.116V4.5a.5.5 0 0 1 .5-.5"/>
                            </svg>
                            Rol de usuario
                        </label>
                        <div class="row">
                            <div class="col align-items-center">
                                <span class="rol fw-bold fs-5">Administrador</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <!--EMAIL-->
                    <div class=" mt-4">
                        <label class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                                <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
                            </svg>
                            Correo electrónico
                        </label>
                        <div class="row">
                            <div class="col">
                                <div class="input-group">
                                <span class="email fw-bold fs-5"><%=request.getSession(false).getAttribute("user")%></span>
                                    <button onclick="" class="btn" data-bs-toggle="modal" data-bs-target="#updateEmail">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4 mb-4">
                        <label class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-lock" viewBox="0 0 16 16">
                                <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m0 5.996V14H3s-1 0-1-1 1-4 6-4q.845.002 1.544.107a4.5 4.5 0 0 0-.803.918A11 11 0 0 0 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664zM9 13a1 1 0 0 1 1-1v-1a2 2 0 1 1 4 0v1a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1h-4a1 1 0 0 1-1-1zm3-3a1 1 0 0 0-1 1v1h2v-1a1 1 0 0 0-1-1"/>
                            </svg>
                            Contraseña
                        </label>
                        <div class="row">
                            <div class="col">
                                <div class="input-group">
                                    <span class="fw-bold fs-5">************</span><!-- Estos asteríscos no deben cambiar,-->
                                    <button onclick="" class="btn" data-bs-toggle="modal" data-bs-target="#updatePassword">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                                        </svg>
                                    </button>
                                </div>
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
                            <h1 class="modal-title fs-5" id="updateUserLabel">Editar perfil</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateUserForm" method="post" action="">
                                <div class="row">
                                    <label for="name" class="col">Nombre(s)*</label>
                                    <label for="surname" class="col">Apellido paterno*</label>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <input type="text" class="col-3 form-control" name="name" id="name" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$">
                                    </div>
                                    <div class="col">
                                        <input type="text" class="form-control" name="surname" id="surname" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$">
                                    </div>
                                </div>
                                <div class="row">
                                    <label for="lastname" class="col">Apellido materno*</label>
                                    <label class="col" for="phone">Teléfono*</label>
                                </div>
                                <div class="row mb-3">
                                    <div class="col">
                                        <input type="text" class="form-control" name="lastname" id="lastname" required pattern="^([A-ZÁÉÍÓÚÑ]{1}[a-záéíóúñ]+\s*)*$">
                                    </div>
                                    <div class="col">
                                        <input type="tel" class="form-control" name="phone" id="phone" minlength="10" maxlength="10" required pattern="^[0-9]*$">
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="updateUser(event)">
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
        </div>
    </div>

    <!--Modal Cambiar contraseña-->
    <div class="modal fade" id="updatePassword" tabindex="-1" aria-labelledby="updatePasswordModal"
         aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="updatePasswordLabel">Cambiar contraseña</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="updatePasswordForm" class="needs-validation" novalidate autocomplete="off" method="post" action="">
                        <div class="mb-1 text-start">

                            <!--Contraseña ACTUAL-->
                            <label class="form-label" for="password">Ingrese su contraseña actual</label>
                            <div class="input-group mb-5">
                                <input  class="form-control" type="password" name="password" id="password" placeholder="Contraseña" required>
                                <button class="btn btn-outline-secondary eyeOpen" type="button" onclick="showPassword()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                                        <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                                        <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                                    </svg>
                                </button>
                                <button class="btn btn-outline-secondary eyeClose" type="button" onclick="showPassword()" style="display:none;">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash-fill" viewBox="0 0 16 16">
                                        <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                                        <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
                                    </svg>
                                </button>
                                <div class="invalid-feedback">
                                    La contraseña no es válida.
                                </div>
                            </div>

                            <!--Contraseña NUEVA-->
                            <label class="form-label" for="password1">Ingrese una nueva contraseña</label>
                            <div class="input-group mb-5">
                                <input  class="form-control" type="password" name="password1" id="password1" placeholder="Nueva contraseña" required>
                                <button class="btn btn-outline-secondary eyeOpen1" type="button" onclick="showPassword1()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                                        <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                                        <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                                    </svg>
                                </button>
                                <button class="btn btn-outline-secondary eyeClose1" type="button" onclick="showPassword1()" style="display:none;">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash-fill" viewBox="0 0 16 16">
                                        <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                                        <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
                                    </svg>
                                </button>
                                <div class="invalid-feedback">
                                    Las contraseñas no coinciden.
                                </div>
                            </div>

                            <!--Contraseña CONFIRMAR NUEVA-->
                            <label class="form-label" for="password2">Confirme su contraseña</label>
                            <div class="input-group mb-3">
                                <input  class="form-control" type="password" name="password2" id="password2" placeholder="Confirmar nueva contraseña" required>
                                <button class="btn btn-outline-secondary eyeOpen2" type="button" onclick="showDoublePassword()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                                        <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                                        <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                                    </svg>
                                </button>
                                <button class="btn btn-outline-secondary eyeClose2" type="button" onclick="showDoublePassword()" style="display:none;">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash-fill" viewBox="0 0 16 16">
                                        <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                                        <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
                                    </svg>
                                </button>
                                <div class="invalid-feedback">
                                    Las contraseñas no coinciden.
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <!-- Enva correo para obtener un código de verificación -->
                            <button type="button" class="btn botonCafe me-md-2" onclick="changePassword(event)">
                                Actualizar contraseña
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

    <!-- Modal Cambiar Email -->
    <div class="modal fade" id="updateEmail" tabindex="-1" aria-labelledby="updateEmail"
         aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="updateEmailLabel">Cambiar correo electrónico</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="updateEmailForm" method="post" action="" novalidate>
                        <div class="row">
                            <label class="col-8" for="email1">Nuevo correo electrónico*</label>
                        </div>
                        <div class="row mb-4">
                            <div class="col">
                                <input type="email" class="form-control" name="email1" id="email1" required pattern="^[a-z0-9]+[a-z0-9\.\_]+[a-z0-9]+@[a-z]{2,}(\.[a-z]{2,}){1,2}$">
                                <div class="invalid-feedback">
                                    Los correos no coinciden.
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-8" for="email2">Confirmar correo electrónico*</label>
                        </div>
                        <div class="row mb-4">
                            <div class="col">
                                <input type="email" class="form-control" name="email2" id="email2" required pattern="^[a-z0-9]+[a-z0-9\.\_]+[a-z0-9]+@[a-z]{2,}(\.[a-z]{2,}){1,2}$">
                                <div class="invalid-feedback">
                                    Las correos no coinciden.
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn botonCafe" onclick="changeEmail(event)">
                                Confirmar
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
</div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../../assets/js/funciones.js"></script>
    <script src="../../assets/js/updateUsers.js"></script>
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
            setupRealTimeValidation('updatePasswordForm');
            setupRealTimeValidation('updateUserForm');
            setupRealTimeValidation('updateEmailForm');
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
        function showUserConfirmation(message, form) {
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

        // Función para mostrar confirmación antes de enviar el formulario
        function showSpecialConfirmation(message, form) {
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
                                </span> Estoy seguro`,
                footer: '<span class="red">Nota: Se cerrará tu sesión actual y tendrás que iniciar sesión de nuevo</span>',
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

        // Función para manejar el cambio de contraseña
        function changePassword(event) {
            event.preventDefault(); // Evita el envío automático del formulario
            const formId = 'updatePasswordForm';
            let password1 = document.getElementById('password1').value;
            let password2 = document.getElementById('password2').value;

            if (password1 !== password2) {
                showWarningAlert();
                document.getElementById('password1').classList.add('is-invalid');
                document.getElementById('password2').classList.add('is-invalid');
            } else if (validateForm(formId)) {
                const form = document.getElementById(formId);
                showSpecialConfirmation("¿Estás seguro de que deseas cambiar tu contraseña?", form);
            }
        }

        // Función para manejar el cambio de email
        function changeEmail(event) {
            event.preventDefault(); // Evita el envío automático del formulario
            const formId = 'updateEmailForm';

            if (validateForm(formId)) {
                const form = document.getElementById(formId);
                showSpecialConfirmation("¿Estás seguro de que deseas cambiar tu correo electrónico?", form);
            }
        }

        // Función para actualizar usuario
        function updateUser(event) {
            event.preventDefault(); // Evita el envío automático del formulario
            const formId = 'updateUserForm';

            if (validateForm(formId)) {
                const form = document.getElementById(formId);
                showUserConfirmation("¿Estás seguro de que deseas actualizar a este usuario?", form);
            }
        }

        // Función para cambiar el estado de un usuario
        function handleChangeStatus(event) {
            event.preventDefault(); // Evita el envío automático del formulario
            const button = event.currentTarget;
            const userId = button.getAttribute('data-id');
            const form = document.getElementById('changeStatusForm');

            // Actualiza el input hidden con el ID correcto
            form.querySelector('input[name="id"]').value = userId;
            showUserConfirmation('¿Estás seguro de que deseas cambiar el estado a este usuario?', form);
        }

        // Asocia la función a los botones cuando el DOM esté listo
        document.addEventListener('DOMContentLoaded', function() {
            const changeStatusButtons = document.querySelectorAll('.botonRojo');

            changeStatusButtons.forEach(button => {
                button.addEventListener('click', handleChangeStatus);
            });
        });
    </script>
<script>
    //Funcion para mostrar contraseña
    function showPassword() {
        const eyeOpen = document.querySelector(".eyeOpen");
        const eyeClose = document.querySelector(".eyeClose");
        var password = document.getElementById("password");

        if (password.type === "password") {
            password.type = "text";
            eyeOpen.style.display = "none";
            eyeClose.style.display = "block";
        } else {
            password.type = "password";
            eyeOpen.style.display = "block";
            eyeClose.style.display = "none";
        }
    }

    //Funcion para mostrar contraseña doble
    function showPassword1() {
        const eyeOpen = document.querySelector(".eyeOpen1");
        const eyeClose = document.querySelector(".eyeClose1");
        var password1 = document.getElementById("password1");

        if (password1.type === "password") {
            password1.type = "text";
            eyeOpen.style.display = "none";
            eyeClose.style.display = "block";
        } else {
            password1.type = "password";
            eyeOpen.style.display = "block";
            eyeClose.style.display = "none";
        }
    }
    //Funcion para mostrar contraseña doble
    function showDoublePassword() {
        const eyeOpen = document.querySelector(".eyeOpen2");
        const eyeClose = document.querySelector(".eyeClose2");
        var password2 = document.getElementById("password2");

        if (password2.type === "password") {
            password2.type = "text";
            eyeOpen.style.display = "none";
            eyeClose.style.display = "block";
        } else {
            password2.type = "password";
            eyeOpen.style.display = "block";
            eyeClose.style.display = "none";
        }
    }
</script>
    <jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>