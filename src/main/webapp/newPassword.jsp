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
                    <div class="col-5 ps-5 fs-4 fs-md-3 fs-lg-2 fw-bold">Restablecer contraseña</div>
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
                        <div class="card-body">
                            <h5 class="card-header h3 text-black mb-5">
                                Cambiar contraseña
                            </h5>
                            <form id="updatePasswordForm" class="needs-validation" novalidate autocomplete="off" method="post" action="updatePassword">
                                <input type="hidden" name="token" value="${param.token}"/> <!-- Token -->
                                <div class="mb-1 text-start">
                                    <label class="mb-3" for="password1">Ingrese una nueva contraseña</label>
                                    <div class="input-group mb-5">
                                        <input id="password1" name="password1" type="password" class="form-control" placeholder="Nueva contraseña" required>
                                        <!-- Add eye icon logic here -->
                                    </div>
                                </div>
                                <div class="mb-2 text-start">
                                    <label class="mb-3" for="password2">Confirme su contraseña</label>
                                    <div class="input-group mb-3">
                                        <input id="password2" name="password2" type="password" class="form-control" placeholder="Confirmar nueva contraseña" required>
                                        <!-- Add eye icon logic here -->
                                    </div>
                                </div>
                                <div align="center">
                                    <br/>
                                    <h3>${message}</h3>
                                    <br/>
                                </div>
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                                    <button type="button" class="btn botonGris btn-outline-secondary me-md-2" onclick="redirectToLogin()">
                                        Cancelar
                                    </button>
                                    <button type="submit" class="btn botonCafe me-md-2">
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
