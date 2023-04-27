function mostrar() {
    var usuario = document.getElementById("iUsuario")
    var inputUsuario = usuario.value;

    var contra = document.getElementById("iContra")
    var inputContra = contra.value;

    const xhr = new XMLHttpRequest();

    xhr.onload = function() {
        if (xhr.status === 200) {
            let result = JSON.parse(xhr.responseText);
            if (inputUsuario === result[0].nombre && inputContra === result[0].contraseña) {
                link.style.display = "block";
                cajita.style.display = "none";  
                return;
                }
        alert("El usuario o contraseña son incorrectos, intenta de nuevo");
        } else {
            alert('Error al conectarse con el servidor');
        }
    }
    
    xhr.open('GET', '/home');
    xhr.send();
}


