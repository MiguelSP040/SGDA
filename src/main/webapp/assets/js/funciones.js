// FUNCIONES PARA EL BOTON DEL SIDEBAR
document.addEventListener('DOMContentLoaded', function() {
    function toggleSidebar() {
        const sidebarAbierto = document.getElementById('sidebarAbierto');
        const sidebarCerrado = document.getElementById('sidebarCerrado');

        if (sidebarAbierto.style.display === 'block') {
            sidebarAbierto.style.display = 'none';
            sidebarCerrado.style.display = 'block';
        } else {
            sidebarAbierto.style.display = 'block';
            sidebarCerrado.style.display = 'none';
        }
    }

    // Agregar event listeners al botón para esconder y mostrar el sidebar
    const button = document.getElementById('esconderBTN');
    if (button) {
        button.addEventListener('click', function(event) {
            event.stopPropagation();
            toggleSidebar();
        });
    }

    // Agregar event listeners a los iconos dentro del sidebarCerrado
    const toggleIcons = document.querySelectorAll('#sidebarCerrado a');
    toggleIcons.forEach(function(icon) {
        icon.addEventListener('click', function(event) {
            event.stopPropagation();
            toggleSidebar();
        });
    });
    document.addEventListener('click', function(event) {
        const sidebarAbierto = document.getElementById('sidebarAbierto');
        const sidebarCerrado = document.getElementById('sidebarCerrado');
        const target = event.target;

        // Verifica si el clic fue fuera de los sidebars y fuera del botón
        if (!sidebarAbierto.contains(target) && !sidebarCerrado.contains(target) && target !== button && !button.contains(target)) {
            if (sidebarAbierto.style.display === 'block') {
                sidebarAbierto.style.display = 'none';
                sidebarCerrado.style.display = 'block';
            }
        }
    });
});


// FUNCIONES PARA LA DE BUSQUEDA DE PRODUCTO
function searchProduct() {
    // Guardar el nuevo producto
    console.log("Producto guardado");
    $('#newProduct').modal('hide'); // Cierra el modal después de guardar
}
document.querySelectorAll('.dropdown-btn').forEach(button => {
    button.addEventListener('click', () => {
        button.classList.toggle('active');
        const submenu = button.nextElementSibling;
        if (submenu.style.display === 'block') {
            submenu.style.display = 'none';
        } else {
            submenu.style.display = 'block';
        }
    });
});


// Función para validar que todos los campos obligatorios estén llenos
function validateForm(formId) {
    //'use strict';
    const form = document.getElementById(formId);
    let isValid = true;

    form.querySelectorAll('input, select, textarea').forEach(input => {
        if (input.required && (input.tagName === 'SELECT' && input.value === '' || !input.value.trim())) {
            isValid = false;
            form.classList.add('was-validated');
        } else {
            input.classList.remove('is-invalid');
        }
    });
    return isValid;
}

// Función para manejar el reset de formularios
function reset() {
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.reset();
        form.querySelectorAll('input, select, textarea').forEach(input => {
            input.classList.remove('is-invalid');
            input.classList.remove('was-validated');
        });
    });
}

// Función de validación y registro de usuario en userQuery.html
// Función para registrar usuario
const registerUser = async (formId) => {
    const isValidUser = validateForm('newUserForm');


    if (isValidUser) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showUserConfirmation();


    } else {
        // Muestra alerta si hay campos incompletos
        showWarningAlert();
    }
}

// Función para actualizar usuario
const updateUser = async (formId) => {
    const isValidUser = validateForm('updateUserForm');


    if (isValidUser) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showUserConfirmation();
    } else {
        // Muestra alerta si hay campos incompletos
        showWarningAlert();
    }
}

// Función de validación y registro de productos en products.html
// Función para registrar producto
const registerProduct = async (formId) => {
    const isValidUser = validateForm('newProductForm');
    if (isValidUser) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showProductConfirmation();
    } else {
        // Muestra alerta si hay campos incompletos
        showWarningAlert();
    }
}

// Función para actualizar producto
const updateProduct = async (formId) => {
    const isValidUser = validateForm('updateProductForm');
    if (isValidUser) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showProductConfirmation();
    } else {
        // Muestra alerta si hay campos incompletos
        showWarningAlert();
    }
}

// Función de validación y registro de proveedor y contacto en registerSupplier.html
// Función para manejar el registro de proveedor y contacto
async function registerSupplier() {
    const isValidSupplier = validateForm('supplierForm');


    if (isValidSupplier) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showSupplierConfirmation();

    } else {
        // Llama a la función en alerts.js para mostrar la alerta de advertencia
        showWarningAlert();
    }
}

// Función de validación y registro de proveedor y contacto en registerSupplier.html
// Función para manejar el registro de proveedor y contacto
async function updateSupplier() {
    const isValidSupplier = validateForm('updateSupplierForm');


    if (isValidSupplier) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showSupplierConfirmation();

    } else {
        // Llama a la función en alerts.js para mostrar la alerta de advertencia
        showWarningAlert();
    }
}



// Función de validación y registro de area en destinationAreas.html
// Función para manejar el registro de area de destino
async function registerDestinationArea() {
    const isValidArea = validateForm('newAreaForm');
    if (isValidArea) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showAreaConfirmation();
    } else {
        // Llama a la función en alerts.js para mostrar la alerta de advertencia
        showWarningAlert();
    }
}

// Función para actualizar área
async function updateDestinationArea() {
    const isValidArea = validateForm('updateAreaForm');
    if (isValidArea) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showAreaConfirmation();
    } else {
        // Llama a la función en alerts.js para mostrar la alerta de advertencia
        showWarningAlert();
    }
}

// Función de validación y registro de unidad de medida metrics.html
// Función para manejar el registro de unidad de medida
async function registerMetrics() {
    const isValidMetric = validateForm('registerMetricsForm');
    if (isValidMetric) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showMetricConfirmation();
    } else {
        // Llama a la función en alerts.js para mostrar la alerta de advertencia
        showWarningAlert();
    }
}

// Función para actualizar unidad de medida
async function updateMetrics() {
    const isValidMetric = validateForm('updateMetricForm');

    if (isValidMetric) {
        // Llama a la función en alerts.js para mostrar la alerta de confirmación
        showMetricConfirmation();
    } else {
        // Llama a la función en alerts.js para mostrar la alerta de advertencia
        showWarningAlert();
    }
}


// FUNCIONES PARA EL REGISTRO DE MOVIMIENTOS EN entrys.html
// Función para validar los campos del formulario de entrada
function validateEntryForm() {
    var form = document.getElementById('registerEntryMovementForm');
    var valid = form.checkValidity();
    form.classList.add('was-validated');
    return valid;
}

// Función para validar los campos del formulario de salida en outbounds.html
function validateOutboundForm() {
    var form = document.getElementById('registerOutboundForm');
    var valid = form.checkValidity();
    form.classList.add('was-validated');
    return valid;
}

// Función para registrar un movimiento
function registerEntry() {

    if (validateEntryForm()) {
        // Registro de entrada válido
        showEntryConfirmation();
    } else {
        showWarningAlert();
    }
}

// Función para registrar un movimiento
function registerOutbound() {

    if (validateOutboundForm()) {
        // Registro de entrada válido
        showOutboundConfirmation();
    } else {
        showWarningAlert();
    }
}

function showDuplicatedData () {
    duplicatedData("Los datos del registro ya existen");
}


// Función para actualizar una entrada
function updateEntry() {
    var form = document.getElementById('updateEntryForm');
    if (form.checkValidity()) {
        showEntryConfirmation();
    } else {
        form.classList.add('was-validated');
        showWarningAlert();
    }
}

// Función para actualizar una salida
function updateOutbound() {
    var form = document.getElementById('updateOutboundForm');
    if (form.checkValidity()) {
        showOutboundConfirmation();
    } else {
        form.classList.add('was-validated');
        showWarningAlert();
    }
}

// Función para añadir una fila de la tabla
function addRow(button) {
    // Obtener la fila actual (donde se hizo clic en el botón)
    const currentRow = button.closest('tr');
    // Obtener el cuerpo de la tabla
    const tableBody = currentRow.parentElement;

    // Clonar la fila actual para crear una nueva fila vacía
    const newRow = currentRow.cloneNode(true);

    // Limpiar los valores de los campos en la nueva fila
    const inputs = newRow.querySelectorAll('input, select');
    inputs.forEach(input => {
        if (input.type === 'text' || input.type === 'number') {
            input.value = '';
        } else if (input.tagName === 'SELECT') {
            input.selectedIndex = 0;
        }
    });

    // Insertar la nueva fila después de la fila actual
    currentRow.insertAdjacentElement('afterend', newRow);

    // Actualizar los índices de todas las filas
    updateRowIndices();
}

// Función para eliminar una fila de la tabla
function removeRow(button) {
    // Obtener la fila actual y el cuerpo de la tabla
    const row = button.closest('tr');
    const tableBody = row.parentElement;

    // Eliminar la fila si no es la única
    if (tableBody.children.length > 1) {
        row.remove();
        // Actualizar los índices de todas las filas
        updateRowIndices();
    } else {
        showErrorAlert('No se puede eliminar la única fila.');
    }
}

// Función para actualizar los índices de la tabla
function updateRowIndices() {
    const rows = document.querySelectorAll('tbody tr');
    rows.forEach((row, index) => {
        const indexCell = row.querySelector('th');
        if (indexCell) {
            indexCell.textContent = index + 1; // Actualizar el índice de la fila
        }
    });
}


// Función para cerrar modales
function closeModal(modalId) {
    const modalElement = document.querySelector(modalId);
    const modalInstance = bootstrap.Modal.getInstance(modalElement);
    if (modalInstance) {
        modalInstance.hide();
    }
}


// Función para actualizar contraseña newPassword.html
function updatePassword() {
    var form = document.getElementById('updatePasswordForm');
    var password1 = document.getElementById('password1').value;
    var password2 = document.getElementById('password2').value;

    // Limpia las clases de error anteriores
    form.classList.remove('was-validated');
    form.querySelectorAll('.form-control').forEach(input => {
        input.classList.remove('is-invalid');
    });

    var isValid = true;

    if (!password1 && !password2) {
        isValid = false;
        if (!password1) {
            document.getElementById('password1').classList.add('is-invalid');
        }
        if (!password2) {
            document.getElementById('password2').classList.add('is-invalid');
        }
        showWarningAlert("Ambos campos son obligatorios");
    } else if (password1 !== password2) {
        isValid = false;
        document.getElementById('password2').classList.add('is-invalid');
        showErrorAlert("Las contraseñas no coinciden");
    }

    if (isValid) {
        showSuccessAlert('Contraseña actualizada correctamente');
        setTimeout(function() {
            window.location.href = "/login.html";
        }, 2000);

    } else {
        form.classList.add('was-validated');
    }
}

// Función para enviar código de verificación insertCode.html
function sendCode() {
    var form = document.getElementById('sendCodeForm');
    var verificationCode = document.getElementById('verificationCode').value;

    // Limpia las clases de error anteriores
    form.classList.remove('was-validated');
    document.getElementById('verificationCode').classList.remove('is-invalid');

    if (!verificationCode) {
        document.getElementById('verificationCode').classList.add('is-invalid');
        showErrorAlert("El código de verificación no es correcto");
        form.classList.add('was-validated');
    } else {
        // Llama a una función para verificar el código
        // lógica para verificar el código
        // Llamada a tu servidor
        showSuccessAlert('¡Bienvenido de vuelta!');
        setTimeout(function() {
            window.location.href = "/newPassword.html";
        }, 2000);
    }
}

// FUNCIONES DE recoverPassword.html
function redirectToLogin() {
    window.location.href = "/login.html";
}

function validateEmail(email) {
    // Expresión regular para validar el formato básico del correo electrónico
    var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailPattern; // .test(email) Verifica si el correo electrónico cumple con el patrón
}


function sendEmail() {
    'use strict';
    var form = document.getElementById('recoverPasswordForm');
    // Validar el formato del correo electrónico
    if (!form.checkValidity() || !validateEmail(email)) {
        showErrorAlert("El formato del correo electrónico no es válido");
        form.classList.add('was-validated');
    } else {
        // Obtener el correo electrónico ingresado
        var emailInput = form.querySelector('input[type="email"]');
        var email = emailInput.value;
        // Aquí debe ir el método para enviar el correo
        showSuccessAlert(`Correo de verificación enviado a ${email}`);
    }
}


// BOTÓN DE LOGIN EN login.html
// Función para validar y redirigir al usuario en el login
function handleLogin() {
    'use strict';
    var email = document.getElementById("email");
    var password = document.getElementById("password1");

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
    }
}


//Mostrar seccion de Agregar metrica
function showHide(){
    const addMetric = document.getElementById("addMetric");

    if(addMetric.style.display === 'block'){
        addMetric.style.display = 'none';
    }else{
        addMetric.style.display = 'block';
    }

}

function showHideDeleteMetric(){
    const deleteMetric = document.getElementById("deleteMetric");


    if(deleteMetric.style.display === 'block'){
        deleteMetric.style.display = 'none';
    }else{
        deleteMetric.style.display = 'block';
    }
}


//Funcion para mostrar contraseña doble
function showPassword() {
    const eyeOpen = document.querySelector(".eyeOpen");
    const eyeClose = document.querySelector(".eyeClose");

    var password1 = document.getElementById("password1");

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


//Funcion para mostrar contraseña doble
function showDoublePassword() {
    const eyeOpen2 = document.querySelector(".eyeOpen2");
    const eyeClose2 = document.querySelector(".eyeClose2");

    var password2 = document.getElementById("password2");

    if (password2.type === "password") {
        password2.type = "text";
        eyeOpen2.style.display = "none";
        eyeClose2.style.display = "block";
    } else {
        password2.type = "password";
        eyeOpen2.style.display = "block";
        eyeClose2.style.display = "none";
    }
}
// Función para desplegar submenu
function showSubmenu(id) {
    // Selecciona el botón con el id dado
    const button = document.getElementById(id);

    // Dentro de ese botón, selecciona los iconos de flecha
    const arrowOpened = button.querySelector(".arrowOpened");
    const arrowClosed = button.querySelector(".arrowClosed");

    // Cambia la visibilidad de los iconos según el estado actual
    if (arrowOpened.style.display === "none") {
        arrowClosed.style.display = "none";
        arrowOpened.style.display = "block";
    } else {
        arrowClosed.style.display = "block";
        arrowOpened.style.display = "none";
    }
}

