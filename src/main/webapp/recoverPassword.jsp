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
    <title>Reestablecer contraseña</title>
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
            <!-- Fila para centrar horizontalmente -->
            <div class="row justify-content-center w-100">
                <!-- Columna que define el ancho del card -->
                <div class="col-md-8 col-lg-6">
                    <!-- Card -->
                    <div class="card shadow-lg mb-5">
                        <div class="card-body">
                            <h5 class="card-header h3 text-black mb-5">
                                Restablecer contraseña
                            </h5>
                            <form id="recoverPasswordForm" class="needs-validation" novalidate autocomplete="off" method="post" action="">
                                <div class="mb-5 text-center">
                                    <label class="mb-4" for="email">
                                        Introduzca su correo electrónico registrado y le enviaremos un mensaje con instrucciones para restablecer su contraseña. Recuerda revisar la bandeja de SPAM.
                                    </label>
                                    <input id="email" type="email" class="form-control" name="email" required placeholder="Correo electrónico">
                                    <div class="invalid-feedback">
                                        Correo electrónico no registrado
                                    </div>
                                </div>

                                <!-- Botones -->
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <!-- Regresa a Vista Login -->
                                    <button type="button" class="btn botonGris btn-outline-secondary me-md-2" onclick="redirectToLogin()">
                                        Cancelar
                                    </button>
                                    <!-- Envia correo para obtener un código de verificación -->
                                    <button type="button" class="btn botonCafe me-md-2" onclick="sendEmail()">
                                        Enviar correo
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
