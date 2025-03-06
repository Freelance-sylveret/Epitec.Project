<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "immobilier_db";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Échec de connexion : " . $conn->connect_error);
}

echo "Connexion réussie à la base de données.";
?>
