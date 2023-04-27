function mostrar() {
    var usuario = document.getElementById("iUsuario")
    var inputUsuario = usuario.value;

    var contra = document.getElementById("iContra")
    var inputContra = contra.value;

   

    const xhr = new XMLHttpRequest();

    if(true) {
        link.style.display = "block";
        cajita.style.display = "none";  
    } else {
        alert("El usuario o contraseña son incorrectos, intenta de nuevo");
    }
        
    
    console.log(result);   
    xhr.open('GET', '/home');
}


