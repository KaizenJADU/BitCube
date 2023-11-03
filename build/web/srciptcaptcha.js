var code;

function createCaptcha() {
  document.getElementById('captcha').innerHTML = "";
  var charsArray = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@!#$%^&*";
  var lengthOtp = 6;
  var captcha = [];

  for (var i = 0; i < lengthOtp; i++) {
    var index = Math.floor(Math.random() * charsArray.length);
    captcha.push(charsArray[index]);
  }

  var canv = document.createElement("canvas");
  canv.id = "captcha";
  canv.width = 100;
  canv.height = 50;
  var ctx = canv.getContext("2d");
  ctx.font = "25px Georgia";
  ctx.strokeText(captcha.join(""), 0, 30);

  code = captcha.join("");
  document.getElementById("captcha").appendChild(canv);
}
function validateCaptcha() {
  event.preventDefault();
  var captchaValue = document.getElementById("captchaTextBox").value;

  if (captchaValue === code) {
    alert("Captcha válido");
    window.location.href = "registro.php";
    // Deshabilitar el botón de envío para evitar envíos múltiples
    document.getElementById("enviar").disabled = true;
  } else {
    alert("Captcha no válido. Inténtalo de nuevo");
    createCaptcha();
  }
}

document.addEventListener("DOMContentLoaded", function () {
  const formulario = document.getElementById("registro");
  const botonEnviar = document.getElementById("enviar");

  // Agrega un indicador para evitar envíos múltiples
  let formSubmitted = false;

  formulario.addEventListener("submit", function (event) {
    event.preventDefault();

    // Verifica si el formulario ya se ha enviado
    if (!formSubmitted) {
      validateCaptcha(); // Llama a la función de validación cuando se envíe el formulario
      formSubmitted = true; // Marca el formulario como enviado
    }
  });
});

// Genera el CAPTCHA cuando se carga la página
createCaptcha();
