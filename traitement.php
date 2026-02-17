<?php
// Connexion à la base de données
$host = 'localhost'; // Adresse du serveur MySQL
$dbname = 'immobilier_db'; // Nom de la base de données
$username = 'root'; // Nom d'utilisateur MySQL
$password = ''; // Mot de passe MySQL

try {
    // Connexion à la base de données avec PDO
    $bdb = new PDO("mysql:host=$servername;dbname=immobilier_db", $username, $password);
    $bdb->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Récupérer les données du formulaire
    $name = $_POST['name'];
    $email = $_POST['email'];

    if (empty($name) || empty($email)) {
        die("Tous les champs sont obligatoires.");
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        die("L'email n'est pas valide.");
    }

    // Préparer la requête SQL pour insérer les données
    $sql = "INSERT INTO contacts (name, email) VALUES (:name, :email)";
    $stmt = $pdo->prepare($sql);

    // Lier les valeurs aux paramètres
    $stmt->bindParam(':name', $name);
    $stmt->bindParam(':email', $email);

    // Exécuter la requête
    $stmt->execute();

    // Afficher un message de succès
    echo "Données enregistrées avec succès !";
} catch (PDOException $e) {
    // En cas d'erreur, afficher un message d'erreur
    echo "Erreur : " . $e->getMessage();
}
?>
