<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
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

// Read the request body
$requestData = json_decode(file_get_contents('php://input'), true);

// Prepare the SQL statement
$sql = "INSERT INTO data_mahasiswa (NIM, NAMA, ALAMAT, NO_TELEPON, HOBBY, PRODI, FAKULTAS, JENIS_KELAMIN)
        VALUES (:nim, :nama, :alamat, :no_telepon, :hobby, :prodi, :fakultas, :jenis_kelamin)";

try {
    // Prepare the PDO statement
    $stmt = $pdo->prepare($sql);

    // Bind the parameters
    $stmt->bindParam(':nim', $requestData['NIM']);
    $stmt->bindParam(':nama', $requestData['NAMA']);
    $stmt->bindParam(':alamat', $requestData['ALAMAT']);
    $stmt->bindParam(':no_telepon', $requestData['NO_TELEPON']);
    $stmt->bindParam(':hobby', $requestData['HOBBY']);
    $stmt->bindParam(':prodi', $requestData['PRODI']);
    $stmt->bindParam(':fakultas', $requestData['FAKULTAS']);
    $stmt->bindParam(':jenis_kelamin', $requestData['JENIS_KELAMIN']);

    // Execute the statement
    $stmt->execute();

    // Return a success message
    $response = [
        'message' => 'Data inserted successfully',
    ];
    echo json_encode($response);
} catch (PDOException $e) {
    // Return an error message
    $response = [
        'error' => 'Failed to insert data',
    ];
    echo json_encode($response);
}