<?php
// Activer l'affichage des erreurs pour le débogage
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Connexion à la base de données
$host = 'localhost'; // Adresse du serveur MySQL
$dbname = 'immobilier_db'; // Nom de la base de données
$username = 'root'; // Nom d'utilisateur MySQL
$password = ''; // Mot de passe MySQL

try {
    // Connexion à la base de données avec PDO
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connexion réussie<br>";

    // Récupérer les données du formulaire
    $nom = $_POST['nom'] ?? '';
    $email = $_POST['email'] ?? '';
    $telephone = $_POST['telephone'] ?? '';
    $service = $_POST['service'] ?? '';
    $message = $_POST['message'] ?? '';
    
    echo "Données reçues: $nom, $email<br>";

    if (empty($nom) || empty($email)) {
        die("Le nom et l'email sont obligatoires.");
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        die("L'email n'est pas valide.");
    }

    // Préparer la requête SQL pour insérer les données
    $sql = "INSERT INTO contacts (nom, email, telephone, service, message, date_contact) VALUES (:nom, :email, :telephone, :service, :message, NOW())";
    $stmt = $pdo->prepare($sql);
    echo "Requête préparée<br>";

    // Lier les valeurs aux paramètres
    $stmt->bindParam(':nom', $nom);
    $stmt->bindParam(':email', $email);
    $stmt->bindParam(':telephone', $telephone);
    $stmt->bindParam(':service', $service);
    $stmt->bindParam(':message', $message);
    
    // Exécuter la requête
    if ($stmt->execute()) {
        echo "Données enregistrées avec succès<br>";
        // Rediriger vers la page de confirmation
        header('Location: confirmation.html');
        exit();
    } else {
        echo "Erreur lors de l'enregistrement des données.";
    }
} catch (PDOException $e) {
    // En cas d'erreur, afficher un message d'erreur
    echo "Erreur : " . $e->getMessage();
}
?>
