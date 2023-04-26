function mostrar () {
    var usuario = document.getElementById("iUsuario")
    var inputUsuario = usuario.value;
    
    var contra = document.getElementById("iContra")
    var inputContra = contra.value;
    
    if (inputUsuario === "Manja" && inputContra === "123" ) {
        link.style.display = "block";
        cajita.style.display ="none"; 
    } else {
        alert("El usuario o contraseña son incorrectos, intenta de nuevo");
    }
}