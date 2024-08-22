let data = {};

const getAreaInfo = async id => {
    await fetch(`/ServletGetArea?id=${id}`, {
        method: 'GET',
        headers: {
            "Accept": "application/json",
            "Content_Type": "application/json"
        }
    }).then(response => response.json()).then(response => {
        data = response;
    }).catch(error => {
        console.log(error);
    })
}

const putAreaInfo = async id => {
    await getAreaInfo(id);
    document.getElementById('u_id').value = data.id;
    document.getElementById('u_name').value = data.name;
    document.getElementById('u_shortName').value = data.shortName;
    document.getElementById('u_description').value = data.description;
    document.getElementById('u_status').value = data.status;
}