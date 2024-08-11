<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") != null){
        response.sendRedirect(context+"/views/product/checkStock.jsp");
    }
    boolean errorMessage = request.getAttribute("errorMessage") != null && !(boolean) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Inicio de sesión</title>
    <link href="/assets/css/estilos.css" rel="stylesheet">
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
<section class="h-100">

    <!-- Sección Banner -->
    <div id="barraNavegacion" class="fixed-top text-light d-flex">
        <nav class="container-fluid navbar navbar-expand-lg navbar-light p-0">
            <div class="row w-100 align-items-center">
                <div class="col-5 ps-5 fs-4 fs-md-3 fs-lg-2 fw-bold">Inicio de sesión</div>
                <div class="col-6 text-end fs-4 fs-md-3 fs-lg-2 fw-bold">Sistema Gestor de Almacén</div>
                <div class="col-1 text-end pe-2">
                    <img src="/assets/img/logoSGDA.svg" loading="lazy" style="width: 80%; height: 80%;" alt="SGDA">
                </div>
            </div>
        </nav>
    </div>

    <div class="container h-100">
        <div class="row justify-content-sm-center h-100">
            <div class="col-xxl-4 col-xl-5 col-lg-5 col-md-7 col-sm-9">
                <div class="text-center my-5">
                    <br>
                </div>

                <!-- Card -->
                <div class="card shadow-lg">
                    <div class="card-body p-5">
                        <div class="text-center">
                            <div id="boxContainer" class="circle-container">
                                <img id="boxClosed" src="/assets/img/logoSGDAClosed.svg" loading="lazy" style="width: 120%; height: 120%; " alt="SGDA">
                                <img id="boxOpen" src="/assets/img/logoSGDA.svg" loading="lazy" style="width: 120%; height: 120%; display: none;" alt="SGDA">
                            </div>
                        </div>
                        <h1 class="fs-4 text-center card-title fw-bold mb-4 my-3">Inicio de sesión</h1>
                        <form class="needs-validation" autocomplete="off" method="post" action="/LoginServlet">
                            <div class="mb-3">
                                <label class="mb-2 text-muted" for="email">Correo Electrónico</label>
                                <input id="email" type="email" class="form-control" name="email" required autofocus>
                                <div class="invalid-feedback">
                                    Correo electrónico no registrado
                                </div>
                            </div>
                            <div class="mb-3">
                                <div class="mb-2 w-100">
                                    <label class="text-muted" for="password">Contraseña</label>
                                </div>
                                <input id="password" type="password" class="form-control" name="password" required>
                                <div class="invalid-feedback">
                                    Ingrese su contraseña
                                </div>
                            </div>
                            <!-- Botón -->
                            <div class="d-flex justify-content-center my-4">
                                <button type="submit" class="btn botonLogin btn-primary" id="botonLogin" onclick="handleLogin(event)">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-door-open" viewBox="0 0 16 16">
                                        <path d="M8.5 10c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1"/>
                                        <path d="M10.828.122A.5.5 0 0 1 11 .5V1h.5A1.5 1.5 0 0 1 13 2.5V15h1.5a.5.5 0 0 1 0 1h-13a.5.5 0 0 1 0-1H3V1.5a.5.5 0 0 1 .43-.495l7-1a.5.5 0 0 1 .398.117M11.5 2H11v13h1V2.5a.5.5 0 0 0-.5-.5M4 1.934V15h6V1.077z"/>
                                    </svg>
                                    Iniciar sesión
                                </button>
                            </div>
                            <%if (errorMessage) {%>
                            <div class="col-12">
                                <div class="alert alert-danger mb-0">Contraseña y/o Usuario incorrectos</div>
                            </div>
                            <%}%>
                        </form>
                    </div>
                    <div class="card-footer coffe text-center py-3 border-0">
                    <a href="/recoverPassword.jsp" id="linkPassword">
                        ¿Olvidaste tu contraseña?
                    </a>
                </div>
                <div class="text-center mt-2 text-muted mb-3" style="user-select: none">
                    Copyright &copy; 2024 &mdash; SGA Sistema Gestor de Almacén
                </div>
            </div>
        </div>
    </div>
    </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/assets/js/funciones.js"></script>
<script>
    // BOTÓN DE LOGIN EN login.html
    // Función para validar campos vacíos y redirigir al usuario en el login
    function handleLogin(event) {
        'use strict';
        event.preventDefault(); // Evitar el envío inmediato del formulario

        var email = document.getElementById("email");
        var password = document.getElementById("password");
        var isValid = true;

        if (!email.value || !password.value) {
            var boxClosed = document.getElementById("boxClosed");
            boxClosed.classList.add("fade-out");
            boxClosed.style.display = "block";
            boxClosed.classList.add("fade-in");
            email.classList.add("is-invalid");
            password.classList.add("is-invalid");
            isValid = false;
        } else {
            email.classList.remove("is-invalid");
            password.classList.remove("is-invalid");
        }
        if (isValid) {
            var boxClosed = document.getElementById("boxClosed");
            var boxOpen = document.getElementById("boxOpen");

            boxClosed.style.display = "none";
            boxClosed.classList.add("fade-out");
            boxOpen.style.display = "block";
            boxOpen.classList.add("fade-in");

            // Esperar 2 segundos antes de enviar el formulario
            setTimeout(function() {
                document.querySelector("form").submit(); // Enviar el formulario después de un ligero retraso
            }, 1000); // 1000 ms = 1 segundo
        }
    }

</script>
<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>