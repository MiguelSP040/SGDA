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
    const toggleIcons = document.querySelectorAll('#sidebarCerrado .toggle-menu');
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









function searchProduct() {
    // Implementa la lógica para guardar el nuevo producto
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


// [ALERTAS]
//Agregar nuevo producto exitosamente 
const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
      toast.onmouseenter = Swal.stopTimer;
      toast.onmouseleave = Swal.resumeTimer;
    }
  });
  Toast.fire({
    icon: "success",
    title: "Signed in successfully"
  });