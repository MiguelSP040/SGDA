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
                <button onclick="update()" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#updateUser">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                        <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z" />
                        <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z" />
                    </svg>
                    Editar datos
                </button>
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
                            Nombre de usuario
                        </label>
                        <div class="row">
                            <div class="col">
                                <span class="userName fw-bold fs-5">Isael Alejandro Reyes Vargas </span>
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
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-briefcase" viewBox="0 0 16 16">
                                <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v8A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-8A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5m1.886 6.914L15 7.151V12.5a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5V7.15l6.614 1.764a1.5 1.5 0 0 0 .772 0M1.5 4h13a.5.5 0 0 1 .5.5v1.616L8.129 7.948a.5.5 0 0 1-.258 0L1 6.116V4.5a.5.5 0 0 1 .5-.5"/>
                            </svg>
                            Rol de usuario
                        </label>
                        <div class="row">
                            <div class="col">
                                <span class="rol fw-bold fs-5">Administrador</span>
                            </div>
                        </div>
                    </div>
                    <!--ESTADO-->
                    <div class="mt-4">
                        <label id="status" for="status" class="fs-4">
                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-check2-circle" viewBox="0 0 16 16">
                                <path d="M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0"/>
                                <path d="M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0z"/>
                            </svg>
                            Estado
                        </label>
                        <div class="row">
                            <div class="col align-items-center">
                                <h4><span class="badge badge-pill statusGreen">Activo</span></h4>
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
                                <span class="email fw-bold fs-5"><%=request.getSession(false).getAttribute("user")%></span>
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
                                <span class="fw-bold fs-5">************</span> <!-- Estos asteríscos no deben cambiar,-->
                            </div>                                             <!-- deben quedar así aunque no muestre nada -->
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
                            <h1 class="modal-title fs-5" id="updateUserLabel">Editar información de usuario</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="updateUserForm" method="post" action="">
                                <div class="row">
                                    <label for="name" class="col">Nombre(s)*</label>
                                    <label for="surname" class="col">Apellido paterno*</label>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <input type="text" class="col-3 form-control" name="name" id="name" required>
                                    </div>
                                    <div class="col">
                                        <input type="text" class="form-control" name="surname" id="surname" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <label for="lastname" class="col">Apellido materno*</label>
                                    <label class="col" for="phone">Teléfono*</label>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <input type="text" class="form-control" name="lastname" id="lastname" required>
                                    </div>
                                    <div class="col">
                                        <input type="tel" class="form-control" name="phone" id="phone" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="col-8" for="email">Correo electrónico*</label>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <input type="email" class="form-control" name="email" id="email" required>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="submit" class="btn botonCafe" onclick="updateUser(event)">Actualizar</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="../../assets/js/funciones.js"></script>
    <script>
        // Obtener parámetros de la URL
        const urlParams = new URLSearchParams(window.location.search);
        const result = urlParams.get('result');
        const message = urlParams.get('message');
        // Función de validación del formulario
        function validateForm(formId) {
            const form = document.getElementById(formId);
            const cancelButton = document.querySelector('button[data-bs-dismiss="modal"]');
            let isValid = true;

            if (cancelButton && cancelButton.matches(':focus')) {
                // Si el botón de cancelar está enfocado, quitamos el estado 'was-validated'
                form.classList.remove('was-validated');
            }

            form.querySelectorAll('input, select, textarea').forEach(input => {
                if (input.required && (input.tagName === 'SELECT' && input.value === '' || !input.value.trim())) {
                    isValid = false;
                    form.classList.add('was-validated');
                    input.classList.add('is-invalid');
                } else {
                    input.classList.remove('is-invalid');
                }
            });

            return isValid;
        }


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
                                </span> Cancelar.`,
                confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Sí, registrar.`,
                footer: '<span class="green">Nota: Puedes desactivarlo después</span>',
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

        // Función para actualizar los datos de un usuario
        function updateUser(event) {
            event.preventDefault(); // Evita el envío automático del formulario
            const form = document.getElementById('updateUser');
            if (validateForm('updateUser')) {
                showUserConfirmation("¿Estás seguro de que deseas actualizar a este usuario?",form);
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Campos incompletos',
                    text: 'Por favor llena todos los campos obligatorios del formulario.',
                    confirmButtonText: `<span>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                        <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>
                                    </svg>
                                </span> Entendido.`,
                    footer: '<span class="yellow">Nota: Todos los campos con asterisco son obligatorios</span>',
                    allowOutsideClick: false,
                    customClass: {
                        confirmButton: 'btn botonCafe',
                        cancelButton: 'btn botonGris',
                        popup: 'no-select-popup'
                    }
                });
            }
        }
    </script>
    <jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>