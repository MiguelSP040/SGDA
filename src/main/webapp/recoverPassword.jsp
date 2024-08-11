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
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.3.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
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
                                Restablecer contraseña
                            </h5>
                            <form id="recoverPasswordForm" class="needs-validation" novalidate autocomplete="off" method="post" action="resetPassword">
                                <div class="mb-5 text-center">
                                    <label class="mb-4" for="email">
                                        Introduzca su correo electrónico registrado y le enviaremos un mensaje con instrucciones para restablecer su contraseña. Recuerda revisar la bandeja de SPAM.
                                    </label>
                                    <input id="email" type="email" class="form-control" name="email" required placeholder="Correo electrónico">
                                    <div class="invalid-feedback">
                                        Correo electrónico no registrado
                                    </div>
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="button" class="btn botonGris btn-outline-secondary me-md-2" onclick="redirectToLogin()">
                                        Cancelar
                                    </button>
                                    <button type="submit" class="btn botonCafe me-md-2">
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

<script type="text/javascript">
    $(document).ready(function() {
        $("#recoverPasswordForm").validate({
            rules: {
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                email: {
                    required: "Por favor, ingrese su correo electrónico",
                    email: "Por favor, ingrese una dirección de correo electrónico válida"
                }
            },
            errorPlacement: function(error, element) {
                error.addClass('invalid-feedback');
                error.insertAfter(element);
            }
        });
    });

    function redirectToLogin() {
        window.location.href = '/login'; // Ajusta la URL según la ruta de tu página de inicio de sesión
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/assets/js/funciones.js"></script>
<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>
