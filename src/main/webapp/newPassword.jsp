<%--
  Created by IntelliJ IDEA.
  User: migue
  Date: 01/08/2024
  Time: 11:56 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Nueva contraseña</title>
    <link href="/assets/css/estilos.css" rel="stylesheet" type="text/css">
    <jsp:include page="/layouts/header.jsp"/>
    <style>
        body {
            background-image: url('/assets/img/loginBG.jpg');
            background-size: cover; /* Ajusta el tamaño de la imagen */
            background-repeat: no-repeat; /* Evita que la imagen se repita */
            background-position: center; /* Centra la imagen en la página */
            background-attachment: fixed; /* Fija la imagen de fondo */
        }
    </style>
</head>
<body>
<section>
    <div class="container">
        <!-- Sección Banner -->
        <div id="barraNavegacion" class="fixed-top text-light d-flex">
            <nav class="container-fluid navbar navbar-expand-lg navbar-light p-0">
                <div class="row w-100 align-items-center">
                    <div class="col-5 ps-5 fs-4 fs-md-3 fs-lg-2 fw-bold">Restablecer contraseña</div>
                    <div class="col-6 text-end fs-4 fs-md-3 fs-lg-2 fw-bold">Sistema Gestor de Almacén</div>
                    <div class="col-1 text-end pe-2">
                        <img src="/assets/img/logoSGDA.svg" loading="lazy" style="width: 80%; height: 80%;" alt="SGDA">
                    </div>
                </div>
            </nav>
        </div>

        <!-- Contenedor Principal -->
        <div class="container d-flex justify-content-center align-items-center min-vh-100">
            <div class="row justify-content-center w-100">
                <div class="col-md-8 col-lg-6"> <!-- Ajusta el tamaño del card con clases de columna -->
                    <div class="card shadow-lg mb-5">
                        <div class="card-body">
                            <h5 class="card-header h3 text-black mb-5">
                                Cambiar contraseña
                            </h5>
                            <form id="updatePasswordForm" class="needs-validation" novalidate autocomplete="off" method="post" action="">
                                <div class="mb-1 text-start">
                                    <label class="mb-3" for="password1">Ingrese una nueva contraseña</label>
                                    <div class="input-group mb-5">
                                        <input id="password1" type="password" class="form-control" placeholder="Nueva contraseña" required>
                                        <button class="btn btn-outline-secondary eyeOpen" type="button" id="button-addon2" onclick="showPassword()">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                                                <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                                                <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                                            </svg>
                                        </button>
                                        <button class="btn btn-outline-secondary eyeClose" type="button" id="button-addon1" onclick="showPassword()" style="display:none;">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash-fill" viewBox="0 0 16 16">
                                                <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                                                <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
                                            </svg>
                                        </button>
                                        <div class="invalid-feedback">
                                            Contraseña no válida
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-2 text-start">
                                    <label class="mb-3" for="password2">Confirme su contraseña</label>
                                    <div class="input-group mb-3">
                                        <input id="password2" type="password" class="form-control" placeholder="Confirmar nueva contraseña" required>
                                        <button class="btn btn-outline-secondary eyeOpen2" type="button" id="button-addon2" onclick="showDoublePassword()">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-fill" viewBox="0 0 16 16">
                                                <path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0"/>
                                                <path d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8m8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7"/>
                                            </svg>
                                        </button>
                                        <button class="btn btn-outline-secondary eyeClose2" type="button" id="button-addon1" onclick="showDoublePassword()" style="display:none;">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye-slash-fill" viewBox="0 0 16 16">
                                                <path d="m10.79 12.912-1.614-1.615a3.5 3.5 0 0 1-4.474-4.474l-2.06-2.06C.938 6.278 0 8 0 8s3 5.5 8 5.5a7 7 0 0 0 2.79-.588M5.21 3.088A7 7 0 0 1 8 2.5c5 0 8 5.5 8 5.5s-.939 1.721-2.641 3.238l-2.062-2.062a3.5 3.5 0 0 0-4.474-4.474z"/>
                                                <path d="M5.525 7.646a2.5 2.5 0 0 0 2.829 2.829zm4.95.708-2.829-2.83a2.5 2.5 0 0 1 2.829 2.829zm3.171 6-12-12 .708-.708 12 12z"/>
                                            </svg>
                                        </button>
                                        <div class="invalid-feedback">
                                            Las contraseñas no coinciden
                                        </div>
                                    </div>
                                </div>
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                                    <!-- Regresa a Vista Login -->
                                    <button type="button" class="btn botonGris btn-outline-secondary me-md-2" onclick="redirectToLogin()">
                                        Cancelar
                                    </button>
                                    <!-- Enva correo para obtener un código de verificación -->
                                    <button type="button" class="btn botonCafe me-md-2" onclick="updatePassword()">
                                        Actualizar contraseña
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/assets/js/funciones.js"></script>
<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>
