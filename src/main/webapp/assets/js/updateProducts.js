let data = {};

const getProductInformation = async id => {
    await fetch(`/ServletGetProduct?id=${id}`, {
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

const putProductInformation = async id => {
    await getProductInformation(id);
    document.getElementById('u_id').value= data.id;
    document.getElementById('u_name').value = data.name;
    document.getElementById('u_code').value = data.code;
    document.getElementById('u_id_metric').value = data.id_metric;
    document.getElementById('u_description').value = data.description;
}

const showProductInformation = async id => {
    await getProductInformation(id);
    document.getElementById('r_id').value= data.id;
    document.getElementById('r_name').value = data.name;
    document.getElementById('r_code').value = data.code;
    document.getElementById('r_id_metric').value = data.id_metric;
    document.getElementById('r_description').value = data.description;
}