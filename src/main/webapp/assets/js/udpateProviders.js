let data = {};

const getProviderInformation = async id => {
    await fetch (`/ServletGetProvider?id=${id}`, {
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

const putProviderInformation = async id => {
    await getProviderInformation(id);
    document.getElementById('u_id').value= data.id;
    document.getElementById('u_name').value = data.name;
    document.getElementById('u_socialCase').value = data.socialCase;
    document.getElementById('u_rfc').value = data.rfc;
    document.getElementById('u_phone').value = data.phone;
    document.getElementById('u_email').value = data.email;
    document.getElementById('u_postCode').value = data.postCode;
    document.getElementById('u_address').value = data.address;
    document.getElementById('u_contactName').value = data.contactName;
    document.getElementById('u_contactPhone').value = data.contactPhone;
    document.getElementById('u_contactEmail').value = data.contactEmail;
}

const showProviderInformation = async id => {
    await getProviderInformation(id);
    document.getElementById('r_id').value= data.id;
    document.getElementById('r_name').value = data.name;
    document.getElementById('r_socialCase').value = data.socialCase;
    document.getElementById('r_rfc').value = data.rfc;
    document.getElementById('r_phone').value = data.phone;
    document.getElementById('r_email').value = data.email;
    document.getElementById('r_postCode').value = data.postCode;
    document.getElementById('r_address').value = data.address;
    document.getElementById('r_contactName').value = data.contactName;
    document.getElementById('r_contactPhone').value = data.contactPhone;
    document.getElementById('r_contactEmail').value = data.contactEmail;
}