<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

// Database credentials
$host = 'localhost';
$username = 'faisal';
$password = 'SudoNano06!';
$database = 'Mahasiswa';

// Create a new PDO instance
try {
    $pdo = new PDO("mysql:host=$host;dbname=$database;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Prepare the SQL statement
$sql = "SELECT * FROM data_mahasiswa";

try {
    // Execute the query
    $stmt = $pdo->query($sql);
    
    // Fetch all rows as an associative array
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Return the result as JSON
    echo json_encode($result);
} catch (PDOException $e) {
    // Return an error message
    $response = [
        'error' => 'Failed to fetch data',
    ];
    echo json_encode($response);
}

