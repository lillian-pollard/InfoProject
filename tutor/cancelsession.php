<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');
// get data from the angular controller
// decode the json object
$data = json_decode(file_get_contents('php://input'), true);
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
$sessionid = $data['sessionid'];
$username = $_SESSION['hawkid'];
$tabletitle = "sessions";
// set up variables to handle errors
// is complete will be false if we find any problems when checking on the data
$isComplete = true;
// error message we'll send back to angular if we run into any problems
$errorMessage = "";
// if we got this far and $isComplete is true it means we should add the film to the database
if ($isComplete) {
    // we will set up the insert statement to add this new record to the database
    $updatequery = "UPDATE $tabletitle SET CANCEL=1 WHERE sessionid='$sessionid' AND tutorid='$username';";
    
    // run the insert statement
    queryDB($updatequery, $db);
    
    // get the id of the reservation we just entered
    $cancelid = mysqli_insert_id($db);
    
    // send a response back to angular
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $cancelid;
    header('Content-Type: application/json');
    echo(json_encode($response));    
} else {
    // there's been an error. We need to report it to the angular controller.
    
    // one of the things we want to send back is the data that his php file received
    ob_start();
    var_dump($data);
    $postdump = ob_get_clean();
    
    // set up our response array
    $response = array();
    $response['status'] = 'error';
    $response['message'] = $errorMessage . $postdump;
    header('Content-Type: application/json');
    echo(json_encode($response));    
}