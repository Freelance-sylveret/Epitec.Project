<?php
// Connexion à la base de données
$host = 'localhost';
$dbname = 'immobilier_db';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    // Récupérer tous les contacts
    $sql = "SELECT nom, email, telephone, service, message, date_contact FROM contacts ORDER BY date_contact DESC";
    $stmt = $pdo->prepare($sql);
    $stmt->execute();
    
    $contacts = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Créer le fichier CSV
    $filename = 'contacts_epitec_' . date('Y-m-d') . '.csv';
    
    header('Content-Type: text/csv');
    header('Content-Disposition: attachment; filename="' . $filename . '"');
    
    $output = fopen('php://output', 'w');
    
    // En-têtes CSV
    fputcsv($output, ['Nom', 'Email', 'Téléphone', 'Service', 'Message', 'Date']);
    
    // Données
    foreach ($contacts as $contact) {
        fputcsv($output, [
            $contact['nom'],
            $contact['email'],
            $contact['telephone'],
            $contact['service'],
            $contact['message'],
            date('d/m/Y H:i', strtotime($contact['date_contact']))
        ]);
    }
    
    fclose($output);
    
} catch (PDOException $e) {
    header('Content-Type: application/json');
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>
