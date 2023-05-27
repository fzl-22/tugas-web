<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: DELETE');
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

// Check if the request method is DELETE
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Get the ID of the record to be deleted from the query parameters
    $id = $_GET['id'];

    if (empty($id)) {
        // Return error response if 'id' parameter is missing
        $response = [
            'success' => false,
            'message' => 'Missing parameter: id',
        ];
        echo json_encode($response);
        exit();
    }

    // Prepare the SQL statement to delete the record
    $sql = "DELETE FROM data_mahasiswa WHERE NIM = :nim";

    try {
        // Prepare and execute the SQL statement
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':nim', $id);
        $stmt->execute();

        // Check if the deletion was successful
        if ($stmt->rowCount() > 0) {
            // Return success response
            $response = [
                'success' => true,
                'message' => 'Record deleted successfully',
            ];
            echo json_encode($response);
        } else {
            // Return error response if the record is not found
            $response = [
                'success' => false,
                'message' => 'Record not found',
            ];
            echo json_encode($response);
        }
    } catch (PDOException $e) {
        // Return error response
        $response = [
            'success' => false,
            'message' => 'Failed to delete record',
        ];
        echo json_encode($response);
    }
} else {
    // Return error response for unsupported request method
    $response = [
        'success' => false,
        'message' => 'Invalid request method',
    ];
    echo json_encode($response);
}
