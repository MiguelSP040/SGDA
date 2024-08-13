<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String context = request.getContextPath();
    if (request.getSession(false).getAttribute("user") != null){
        response.sendRedirect(context+"/views/product/checkStock.jsp");
    }
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
                                <button type="submit" class="btn botonLogin btn-primary" id="botonLogin" onclick="handleLogin()">
                                    Iniciar sesión
                                </button>
                            </div>
                            <% if (request.getAttribute("errorMessage") != null) { %>
                            <div class="col-12">
                                <div class="alert alert-danger mb-4">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-exclamation-triangle-fill" viewBox="0 0 16 16">
                                        <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5m.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
                                    </svg>
                                    <%= request.getAttribute("errorMessage") %>
                                </div>
                            </div>
                            <% } %>
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
<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>