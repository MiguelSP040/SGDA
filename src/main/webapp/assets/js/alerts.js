// Función para limpiar errores y restablecer el formulario
const clearFormErrors = (formId) => {
    var form = document.getElementById(formId);
    var inputs = form.querySelectorAll('.form-control');

    inputs.forEach(input => {
        input.classList.remove('is-invalid');
    });
};

// Función para mostrar la alerta de éxito
const showSuccessAlert = (message) => {
    Swal.fire({
        icon: 'success',
        title: '¡Hecho!',
        text: message,
        showConfirmButton: false,
        timer: 2000,
        timerProgressBar: true,
        customClass: {
            popup: 'no-select-popup'
        }
    });
    reset();
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

// Función para mostrar alerta de advertencia
const showWarningAlert = () => {
    Swal.fire({
        icon: 'warning',
        title: 'Campos incompletos',
        text: 'Por favor llena todos los campos obligatorios del formulario.',
        confirmButtonText: 'Entendido',
        footer: '<span class="yellow">Nota: Todos los campos con asterisco son obligatorios</span>',
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup'
        }
    });
}


const duplicatedData = (message) => {
    Swal.fire({
        icon: 'error',
        title: 'Registro duplicado',
        text: message,
        showConfirmButton: true,
        confirmButton: 'Aceptar',
        customClass: {
            confirmButton: 'btn botonCafe',
            popup:'no-select-popup'
        }
    });
}


// Función para registrar un proveedor y contacto
const showSupplierConfirmation = async () => {
    const result = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: '¿Estás seguro de que deseas registrar a este proveedor?',
        confirmButtonText: 'Sí, registrar',
        showCancelButton: true,
        cancelButtonText: 'Cancelar',
        footer: '<span class="green">Nota: Puedes desactivarlo después</span>',
        reverseButtons: false,
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup'
        }
    });

    if (result.isConfirmed) {
        closeModal('#registerSupplier');
        closeModal('#updateSupplier');
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El registro se ha creado exitosamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
        reset()
        // Enviar el formulario o realizar el registro
    }
}

// Función para registrar un area de destino
const showAreaConfirmation = async () => {
    const result = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: '¿Estás seguro de que deseas registrar esta área de destino?',
        confirmButtonText: 'Sí, registrar',
        showCancelButton: true,
        cancelButtonText: 'Cancelar',
        footer: '<span class="red">Nota: Si aceptas, no podrás desactivarla</span>',
        reverseButtons: false,
        allowOutsideClick: false,
        allowEscapeKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup'
        }
    });

    if (result.isConfirmed) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El registro se ha creado exitosamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
        reset()
        // Enviar el formulario o realizar el registro
    }
}

// Función para registrar una unidad de medida
const showMetricConfirmation = async () => {
    const result = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: '¿Estás seguro de que deseas registrar esta unidad de medida?',
        confirmButtonText: 'Sí, registrar',
        showCancelButton: true,
        cancelButtonText: 'Cancelar',
        footer: '<span class="green">Nota: Puedes desactivarla después</span>',
        reverseButtons: false,
        allowOutsideClick: false,
        allowEscapeKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup'
        }
    });

    if (result.isConfirmed) {
        closeModal('#registerMetric');
        closeModal('#updateMetric');
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El registro se ha creado exitosamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
        reset()
        // Enviar el formulario o realizar el registro
    }
}

// Función para registrar un movimiento de entrada
const showEntryConfirmation = async () => {
    const result = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: '¿Estás seguro de que deseas registrar esta entrada?',
        confirmButtonText: 'Sí, registrar',
        showCancelButton: true,
        cancelButtonText: 'Cancelar',
        footer: '<span class="green">Nota: Puedes desactivarla después</span>',
        reverseButtons: false,
        allowOutsideClick: false,
        allowEscapeKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup'
        }
    });

    if (result.isConfirmed) {
        closeModal('#registerMovement');
        closeModal('#updateEntryModal');
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El registro se ha creado exitosamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
        reset();
        // Enviar el formulario o realizar el registro
    }
};

// Función para registrar un movimiento de salida
const showOutboundConfirmation = async () => {
    const result = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: '¿Estás seguro de que deseas registrar esta salida?',
        confirmButtonText: 'Sí, registrar',
        showCancelButton: true,
        cancelButtonText: 'Cancelar',
        footer: '<span class="green">Nota: Puedes desactivarla después</span>',
        reverseButtons: false,
        allowOutsideClick: false,
        allowEscapeKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup'
        }
    });

    if (result.isConfirmed) {
        closeModal('#registerMovement');
        closeModal('#updateOutboundModal');
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El registro se ha creado exitosamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
        reset();
        // Enviar el formulario o realizar el registro
    }
};

// Función para registrar usuario
const showUserConfirmation = async () => {
        const result = await Swal.fire({
            icon: 'warning',
            title: '¡Cuidado!',
            text: '¿Estás seguro de que deseas registrar a este usuario?',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Sí, registrar',
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
        });

        if (result.isConfirmed) {
            closeModal('#newUser');
            closeModal('#updateUser');
            await Swal.fire({
                icon: 'success',
                title: '¡Hecho!',
                text: 'El registro se ha creado exitosamente.',
                showConfirmButton: false,
                timer: 2000,
                timerProgressBar: true,
            });
            reset()
            // Enviar el formulario o realizar el registro
        }
}

// Función para registrar producto
const showProductConfirmation = async () => {
        const result = await Swal.fire({
            icon: 'warning',
            title: '¡Cuidado!',
            text: '¿Estás seguro de que deseas registrar este producto?',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Sí, registrar',
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
        });

        if (result.isConfirmed) {
            closeModal('#newProduct');
            closeModal('#updateProduct');
            await Swal.fire({
                icon: 'success',
                title: '¡Hecho!',
                text: 'El registro se ha creado exitosamente.',
                showConfirmButton: false,
                timer: 2000,
                timerProgressBar: true,
            });
            reset();
            // Enviar el formulario o realizar el registro
        }
}




// Función para desactivar usuario
const deleteUser = async () => {
    const { value: decision } = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: 'Estás a punto de desactivar un usuario del sistema ¿Deseas continuar?',
        confirmButtonText: 'Sí, desactivar',
        cancelButtonText: 'Cancelar',
        showCancelButton: true,
        footer: '<span class="red">Nota: Si aceptas, no podrás recuperarlo</span>',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup',
        }
    });

    if (decision) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El usuario ha sido eliminado correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    }
}

// Función para desactivar producto
const deleteProduct = async () => {
    const { value: decision } = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: 'Estás a punto de desactivar un producto del sistema ¿Deseas continuar?',
        confirmButtonText: 'Sí, desactivar',
        cancelButtonText: 'Cancelar',
        showCancelButton: true,
        footer: '<span class="red">Nota: Si aceptas, no podrás recuperarlo</span>',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup',
        }
    });

    if (decision) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El producto ha sido eliminado correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    }
}

// Función para desactivar producto
const deleteProvider = async () => {
    const { value: decision } = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: 'Estás a punto de desactivar un proveedor del sistema ¿Deseas continuar?',
        confirmButtonText: 'Sí, desactivar',
        cancelButtonText: 'Cancelar',
        showCancelButton: true,
        footer: '<span class="red">Nota: Si aceptas, no podrás recuperarlo</span>',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup',
        }
    });

    if (decision) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'El producto ha sido eliminado correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    }
}

// Función para desactivar entrada
const deleteEntry = async () => {
    const { value: decision } = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: 'Estás a punto de desactivar una entrada del sistema ¿Deseas continuar?',
        confirmButtonText: 'Sí, desactivar',
        cancelButtonText: 'Cancelar',
        showCancelButton: true,
        footer: '<span class="red">Nota: Si aceptas, no podrás recuperarlo</span>',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup',
        }
    });

    if (decision) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'La entrada ha sido eliminada correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    }
}

// Función para desactivar salida
const deleteOutbound = async () => {
    const { value: decision } = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: 'Estás a punto de desactivar una salida del sistema ¿Deseas continuar?',
        confirmButtonText: 'Sí, desactivar',
        cancelButtonText: 'Cancelar',
        showCancelButton: true,
        footer: '<span class="red">Nota: Si aceptas, no podrás recuperarlo</span>',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup',
        }
    });

    if (decision) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'La salida ha sido eliminada correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    }
}

// Función para desactivar usuario
const deleteMetric = async () => {
    const { value: decision } = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: 'Estás a punto de desactivar una unidad de medida del sistema ¿Deseas continuar?',
        confirmButtonText: 'Sí, desactivar',
        cancelButtonText: 'Cancelar',
        showCancelButton: true,
        footer: '<span class="red">Nota: Si aceptas, no podrás recuperarla</span>',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup',
        }
    });

    if (decision) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'La unidad de medida ha sido eliminada correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    }
}


// Función para desactivar usuario
const deleteArea = async () => {
    const { value: decision } = await Swal.fire({
        icon: 'warning',
        title: '¡Cuidado!',
        text: 'Estás a punto de desactivar un área de destino del sistema. ¿Deseas continuar?',
        confirmButtonText: 'Sí, desactivar',
        cancelButtonText: 'Cancelar',
        showCancelButton: true,
        footer: '<span class="red">Nota: Si aceptas, no podrás recuperarla</span>',
        allowOutsideClick: false,
        allowEscapeKey: false,
        allowEnterKey: false,
        stopKeydownPropagation: true,
        customClass: {
            confirmButton: 'btn botonCafe',
            cancelButton: 'btn botonGris',
            popup: 'no-select-popup',
        }
    });

    if (decision) {
        Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'La unidad de medida ha sido eliminada correctamente.',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
        });
    }
}


// Función para cerrar sesión
const logout = async () => {
    const result = await Swal.fire({
        icon: 'warning',
        title: '¿Estás seguro de cerrar sesión?',
        showCancelButton: true,
        confirmButtonText: 'Sí, cerrar sesión',
        cancelButtonText: 'Cancelar',
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
    });

    if (result.isConfirmed) {
        await Swal.fire({
            icon: 'success',
            title: '¡Hecho!',
            text: 'Has cerrado sesión correctamente. Volviendo al login.',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
            customClass: {
                popup: 'no-select-popup',
            }
        });
        window.location.href = "/login.html";
    }
}

// Limpia los errores cuando se oculta el modal
document.querySelectorAll('.modal').forEach(modalElement => {
    modalElement.addEventListener('hidden.bs.modal', () => {
        var form = modalElement.querySelector('form');
        if (form) {
            clearFormErrors(form.id);
        }
    });
});
