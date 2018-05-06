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

$tabletitle = "reservation";
$tabletitle2="scourselist";
$tabletitle3="tcourselist";
$tabletitle4 = "sessions";
$username = $_SESSION['hawkid'];
$sessionid = $data['sessionid'];
// set up variables to handle errors
// is complete will be false if we find any problems when checking on the data
$isComplete = true;

// error message we'll send back to angular if we run into any problems
$errorMessage = "";

// if we got this far and $isComplete is true it means we should add the film to the database
if ($isComplete) {
    // set up a query to get information on films
    $query = "UPDATE $tabletitle SET cancel=1
    WHERE sessionid='$sessionid' AND studentid='$username';";
    
    // run the query to get info on films
    $result = queryDB($query, $db);
    
    // assign results to an array we can then send back to whomever called
    $response = array();
        $response['status'] = 'success';
        header('Content-Type: application/json');
        echo(json_encode($response));
}
else {
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