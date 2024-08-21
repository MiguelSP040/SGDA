let data = {};

const getEntryInformation = async id => {
    await fetch(`/ServletGetEntry?id=${id}`, {
        method: 'GET',
        headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
        }
    })
        .then(response => response.json())
        .then(responseData => {
            data = responseData;
            console.log(data); // Agregado para depuración
        })
        .catch(error => {
            console.log(error);
        });
}

const showEntryInformation = async id => {
    await getEntryInformation(id);
    if (data) {
        document.getElementById('r_folioNumber').value = data.folioNumber || '';
        document.getElementById('r_invoiceNumber').value = data.invoiceNumber || '';
        document.getElementById('r_id_provider').value = data.providerName || ''; // Cambiar si necesitas el ID
        document.getElementById('r_id_user').value = data.userName || ''; // Cambiar si necesitas el ID

        let tableBody = document.querySelector('#reviewEntryTable tbody');
        tableBody.innerHTML = ''; // Limpiar la tabla antes de añadir nuevas filas

        // Agrega datos de productos si hay
        // Cambiar esta parte según el diseño de tu objeto BeanEntry
        let row = `<tr>
            <th scope="row">1</th>
            <td><input class="form-control w-100" type="text" value="${data.productName || ''}" readonly></td>
            <td><input class="form-control w-100" type="text" value="${data.metricName || ''}" readonly></td>
            <td><input class="form-control" type="number" value="${data.unitPrice || ''}" readonly></td>
            <td><input class="form-control" type="number" value="${data.quantity || ''}" readonly></td>
            <td><input class="form-control" type="number" value="${data.totalPrice || ''}" readonly></td>
        </tr>`;
        tableBody.innerHTML += row;
    } else {
        console.error("Data is null");
    }
}

const putEntryInformation = async id => {
    await getEntryInformation(id);
    if (data) {
        document.getElementById('u_folioNumber').value = data.folioNumber || '';
        document.getElementById('u_invoiceNumber').value = data.invoiceNumber || '';
        document.getElementById('u_id_provider').value = data.providerName || ''; // Cambiar si necesitas el ID
        document.getElementById('u_id_user').value = data.userName || ''; // Cambiar si necesitas el ID

        let tableBody = document.querySelector('#updateEntryTable tbody');
        tableBody.innerHTML = ''; // Limpiar la tabla antes de añadir nuevas filas

        // Agrega datos de productos si hay
        // Cambiar esta parte según el diseño de tu objeto BeanEntry
        let row = `<tr>
            <th scope="row">1</th>
            <td><input class="form-control w-100" type="text" value="${data.productName || ''}" readonly></td>
            <td><input class="form-control w-100" type="text" value="${data.metricName || ''}" readonly></td>
            <td><input class="form-control" type="number" value="${data.unitPrice || ''}" readonly></td>
            <td><input class="form-control" type="number" value="${data.quantity || ''}" readonly></td>
            <td><input class="form-control" type="number" value="${data.totalPrice || ''}" readonly></td>
        </tr>`;
        tableBody.innerHTML += row;
    } else {
        console.error("Data is null");
    }
}
