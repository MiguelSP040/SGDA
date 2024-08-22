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
                                    Usuario no registrado.
                                </div>
                            </div>
                            <div class="mb-3">
                                <div class="mb-2 w-100">
                                    <label class="text-muted" for="password">Contraseña</label>
                                </div>
                                <div class="input-group mb-5">
                                    <input id="password" type="password" class="form-control" name="password" required>
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
                                        Ingrese su contraseña.
                                    </div>
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
<script>
    function handleLogin(event) {
        'use strict';
        event.preventDefault(); // Evitar el envío inmediato del formulario

        var email = document.getElementById("email");
        var password = document.getElementById("password");
        var isValid = true;

        // Validar campos vacíos
        if (!email.value || !password.value) {
            showEmptyWarning();
            var boxClosed = document.getElementById("boxClosed");
            // Reiniciar animación
            boxClosed.classList.remove("fade-out");
            boxClosed.classList.remove("fade-in");
            boxClosed.style.display = "block";
            setTimeout(function() {
                boxClosed.classList.add("fade-in");
            }, 10);
            email.classList.add("is-invalid");
            password.classList.add("is-invalid");
            isValid = false;
        } else {
            email.classList.remove("is-invalid");
            password.classList.remove("is-invalid");
        }

        if (isValid) {
            // Verificar sesión
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/LoginServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);
                        if (response.success) {
                            var boxClosed = document.getElementById("boxClosed");
                            var boxOpen = document.getElementById("boxOpen");

                            // Reiniciar animación de boxClosed
                            boxClosed.classList.remove("fade-out");
                            boxClosed.classList.remove("fade-in");
                            boxClosed.style.display = "none";

                            boxOpen.style.display = "block";
                            boxOpen.classList.add("fade-in");

                            // Esperar 1.2 segundos antes de redirigir a la página deseada
                            setTimeout(function() {
                                window.location.href = response.redirectUrl;
                            }, 1200); // 1200 ms = 1.2 segundos
                        } else {
                            var boxClosed = document.getElementById("boxClosed");
                            // Reiniciar animación de boxClosed
                            boxClosed.classList.remove("fade-out");
                            boxClosed.classList.remove("fade-in");
                            boxClosed.style.display = "block";
                            setTimeout(function() {
                                boxClosed.classList.add("fade-in");
                            }, 10);
                            email.classList.add("is-invalid");
                            password.classList.add("is-invalid");

                            // Mostrar mensaje de error si lo hay
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: response.errorMessage,
                                confirmButtonText: `<span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                    <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                </svg>
                            </span> Entendido`,
                                footer: '<span class="red">Nota: Si olvidaste tu contraseña, haz clic en "¿Olvidaste tu contraseña?" para recuperarla</span>',
                                allowOutsideClick: false,
                                customClass: {
                                    confirmButton: 'btn botonCafe',
                                    cancelButton: 'btn botonGris',
                                    popup: 'no-select-popup'
                                }
                            });
                        }
                    } else {
                        console.error("Error en la solicitud: " + xhr.status);
                    }
                }
            };

            var params = "email=" + encodeURIComponent(email.value) + "&password=" + encodeURIComponent(password.value);
            xhr.send(params);
        }
    }

</script>


<script>
    function showEmptyWarning() {
        Swal.fire({
            toast: true,
            position: 'top-end',
            iconColor: 'white',
            icon: 'error',
            title: 'Campos incompletos',
            text: 'Debes ingresar tu correo electrónico y contraseña para acceder.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
            customClass: {
                popup: 'no-select-popup colored-toast'
            }
        });
    }

    function showPassword1() {
        const eyeOpen = document.querySelector(".eyeOpen1");
        const eyeClose = document.querySelector(".eyeClose1");
        var password1 = document.getElementById("password");

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
</script>


<jsp:include page="/layouts/footer.jsp"/>
</body>
</html>