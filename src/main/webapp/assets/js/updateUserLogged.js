let data = {};

const getUserInformation = async id => {
    try {
        const response = await fetch(`/ServletGetLoggedUser?id=${id}`, {
            method: 'GET',
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            }
        });
        if (response.ok) {
            data = await response.json();
        } else {
            console.error('Error fetching user information:', response.statusText);
        }
    } catch (error) {
        console.error('Error:', error);
    }
};

// Llena el formulario con la información del usuario
const populateUserForm = (prefix) => {
    const fields = ['id', 'name', 'surname', 'lastname', 'phone', 'email', 'role', 'status', 'password'];
    fields.forEach(field => {
        const element = document.getElementById(`${prefix}_${field}`);
        if (element) {
            element.value = data[field];
        }
    });
};

// Actualiza la información del usuario logueado
const putUserLoggedInformation = async (button) => {
    const id = button.getAttribute('data-user-id');
    await getUserInformation(id);
    populateUserForm('u');
};

// Actualiza el correo electrónico del usuario logueado
const emailUserLoggedInformation = async (button) => {
    const id = button.getAttribute('data-user-id');
    await getUserInformation(id);
    populateUserForm('r');
};

// Actualiza la contraseña del usuario logueado
const passwordUserLoggedInformation = async (button) => {
    const id = button.getAttribute('data-user-id');
    await getUserInformation(id);
    populateUserForm('p');
};
