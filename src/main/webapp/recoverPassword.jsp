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
                            <h5 class="card-header h4 text-black mb-5">
                                Recuperar cuenta
                            </h5>
                            <c:if test="${not empty message}">
                                <div class="alert alert-danger text-center">
                                        ${message}
                                </div>
                            </c:if>
                            <form id="recoverPasswordForm" class="needs-validation" novalidate autocomplete="off" method="post" action="resetPassword">
                                <div class="mb-5 text-center">
                                    <label class="mb-4" for="email">
                                        Introduzca su correo electrónico registrado y le enviaremos un mensaje con instrucciones para restablecer su contraseña. Recuerda revisar la bandeja de SPAM.
                                    </label>
                                    <input id="email" type="email" class="form-control" name="email" placeholder="alguien@example.com" required pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}">
                                </div>

                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn botonCafe me-md-2">
                                        Enviar correo
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary me-md-2" onclick="redirectToLogin()">
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
</section>
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

        // Validación personalizada para campos como 'lastname'
        if (input.name === 'lastname') {
        // Si el campo está lleno, validar el patrón; si no, lo consideramos válido
        if (input.value.trim() !== '' && !input.checkValidity()) {
        isValid = false;
        input.classList.add('is-invalid');
    } else {
        input.classList.remove('is-invalid');
    }
    } else {
        // Verifica si el campo es requerido y si cumple con el patrón (si está presente)
        if (input.required && !input.checkValidity()) {
        isValid = false;
        input.classList.add('is-invalid');
    } else {
        input.classList.remove('is-invalid');
    }
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
        setupRealTimeValidation('recoverPasswordForm');
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

        // Función para mostrar la alerta de error
        const showErrorAlert = (message) => {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: message,
            showConfirmButton: true,
            confirmButtonText: 'Aceptar',
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
            timer: 3500,
            timerProgressBar: true,
            customClass: {
                popup: 'no-select-popup colored-toast'
            }
        });
    }

    // Mostrar alerta en función del resultado
    if (result === 'true') {
        changeSuccess(decodeURIComponent(message));
    } else if (result === 'false') {
        changeError(decodeURIComponent(message));
    }
</script>

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
        window.location.href = '/';
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="/assets/js/funciones.js"></script>
<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>
