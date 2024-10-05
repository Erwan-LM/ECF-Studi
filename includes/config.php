<?php
// Activer la gestion des erreurs en développement
ini_set('display_errors', 1);
error_reporting(E_ALL);

try {
    $connection = new PDO("mysql:host=localhost;port=3307;dbname=garage_ecf;charset=utf8mb4", "root", "root", [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false
    ]);
} catch (PDOException $e) {
    error_log("Erreur de connexion : " . $e->getMessage(), 3, __DIR__ . '/logs/db_error.log');
    die("Erreur de connexion à la base de données.");
}
?>
