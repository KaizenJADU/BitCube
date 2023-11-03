<?php
$rolespermitidos = ['Administrador', 'Usuario'];
if (!array_key_exists('rol', $_SESSION) || !in_array($_SESSION['rol'], $rolespermitidos)) {
    header("Location: index.html");
}
?>