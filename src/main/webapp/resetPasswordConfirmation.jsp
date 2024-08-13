<%--
  Created by IntelliJ IDEA.
  User: emmita
  Date: 11/08/24
  Time: 11:57 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Correo enviado</title>
    <link href="/assets/css/estilos.css" rel="stylesheet" type="text/css">
    <jsp:include page="/layouts/header.jsp"/>
    <style>
        body {
            background-image: url('/assets/img/loginBG.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }
    </style>
</head>
<body>
<section>
    <div class="container">
        <div id="barraNavegacion" class="fixed-top text-light d-flex">
            <nav class="container-fluid navbar navbar-expand-lg navbar-light p-0">
                <div class="row w-100 align-items-center">
                    <div class="col-5 ps-5 fs-4 fs-md-3 fs-lg-2 fw-bold">Correo enviado</div>
                    <div class="col-6 text-end fs-4 fs-md-3 fs-lg-2 fw-bold">Sistema Gestor de Almacén</div>
                    <div class="col-1 text-end pe-2">
                        <img src="/assets/img/logoSGDA.svg" loading="lazy" style="width: 80%; height: 80%;" alt="SGDA">
                    </div>
                </div>
            </nav>
        </div>

        <div class="container d-flex justify-content-center align-items-center min-vh-100">
            <div class="row justify-content-center w-100">
                <div class="col-md-8 col-lg-6">
                    <div class="card shadow-lg mb-5">
                        <div class="card-body text-center">
                            <h5 class="card-header h3 text-black mb-5">
                                ¡Correo de restablecimiento enviado!
                            </h5>
                            <p class="h5">Revisa tu bandeja de entrada y sigue las instrucciones para restablecer tu contraseña.</p>
                            <p class="h5 mt-3">Recuerda revisar también la bandeja de SPAM.</p>
                            <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
                                <button type="button" class="btn botonCafe" onclick="redirectToLogin()">
                                    Ir a inicio de sesión
                                </button>
                            </div>
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
