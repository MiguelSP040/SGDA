let data = {};

const getUserInformation = async id => {
    await fetch (`http://localhost:8080/ServletGetUser?id=${id}`, {
        method: 'GET',
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
        }
    }).then(response => response.json()).then(response => {
        data = response;
    }).catch(error => {
        console.log(error);
    })
}

const putUserInformation = async id => {
    await getUserInformation(id);
    document.getElementById('u_id' || 'r_id').value= data.id;
    document.getElementById('u_name' || 'r_name').value = data.name;
    document.getElementById('u_surname' || 'r_surname').value = data.surname;
    document.getElementById('u_lastname' || 'r_lastname').value = data.lastname;
    document.getElementById('u_phone' || 'r_phone').value = data.phone;
    document.getElementById('u_email' || 'r_email').value = data.email;
    document.getElementById('u_role' || 'r_role').value = data.role;
    document.getElementById('u_status' || 'r_status').value = data.status;
    document.getElementById('u_password' || 'r_password').value = data.password;
}

const showUserInformation = async id => {
    await getUserInformation(id);
    document.getElementById('r_id').value= data.id;
    document.getElementById('r_name').value = data.name;
    document.getElementById('r_surname').value = data.surname;
    document.getElementById('r_lastname').value = data.lastname;
    document.getElementById('r_phone').value = data.phone;
    document.getElementById('r_email').value = data.email;
    document.getElementById('r_role').value = data.role;
    document.getElementById('r_status').value = data.status;
    document.getElementById('r_password').value = data.password;
}