function mostrar () {
    var usuario = document.getElementById("iUsuario")
    var inputUsuario = usuario.value;
    
    var contra = document.getElementById("iContra")
    var inputContra = contra.value;
    
    fetch('/home/')
        .then(response => response.json())
        .then(data => {
            let cuentaEncontrada = false;
            for (let cuenta of data) {
                if (cuenta.nombre === inputUsuario && cuenta.contraseña === inputContra) {
                    cuentaEncontrada = true;
                    break;
                }
            }
            if (cuentaEncontrada) {
                link.style.display = "block";
                cajita.style.display = "none"; 
            } else {
                alert("El usuario o contraseña son incorrectos, intenta de nuevo");
            }
        })
        .catch(error => console.error(error));
}