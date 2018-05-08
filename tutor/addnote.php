<?php
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');
// get a handle to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
// get data from the angular controller
// decode the json object
$data = json_decode(file_get_contents('php://input'), true);

$tabletitle= "reservation";
$reservationid = $data['reservationid'];
$note = $data['note'];


// set up variables to handle errors
// is complete will be false if we find any problems when checking on the data
$isComplete = false;
// error message we'll send back to angular if we run into any problems
$errorMessage = "";
//

// check if we already have a HawkID that matches the one the user entered
// if we got this far and $isComplete is true it means we should add the player to the database
if ($isComplete) {
    // create a hashed version of the name    
    // we will set up the insert statement to add this new record to the database
    $updatequery = "update $tabletile set note='$note' WHERE reservationid=$reservationid";

    
    // run the insert statement
    queryDB($updatequery, $db);
    
    // get the id of the account we just entered
    $resid = mysqli_insert_id($db);
    
    // send a response back to angular
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $resid;
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
?>