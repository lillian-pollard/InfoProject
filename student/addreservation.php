<?php


// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');


// get a handle to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

// get data from the angular controller
// decode the json object
$data = json_decode(file_get_contents('php://input'), true);

session_start();
// get each piece of data
$sessionid = $data['sessionid'];
$username = $_SESSION['hawkid'];
$tabletitle = "reservation";
$tabletitle2 = "scourselist";
$tabletitle3 = "sessions";
$tabletitle4 = "tcourselist";
// set up variables to handle errors
// is complete will be false if we find any problems when checking on the data
$isComplete = true;

// error message we'll send back to angular if we run into any problems
$errorMessage = "";

// if we got this far and $isComplete is true it means we should add the film to the database
if ($isComplete) {
    // we will set up the insert statement to add this new record to the database
    $insertquery = "INSERT INTO $tabletitle(sessionid,studentid) VALUES('$sessionid','$username');";
    
    // run the insert statement
    queryDB($insertquery, $db);
    //update student budget for course which session is tutoring
    $updatequery = "UPDATE $tabletitle2, $tabletitle,$tabletitle3 SET $tabletitle2.currbudget=$tabletitle2.currbudget-1
    WHERE hawkid='$username' and $tabletitle.sessionid=$tabletitle3.sessionid and $tabletitle2.courseid=$tabletitle3.courseid
    AND $tabletitle.sessionid='$sessionid';";
    
    // run the insert statement
    queryDB($updatequery, $db);
    //update tutor budget for course which session is tutoring
    $updatequery2 = "UPDATE $tabletitle4,$tabletitle3 SET $tabletitle4.currbudget=$tabletitle4.currbudget-1
    WHERE sessionid='$sessionid' and $tabletitle3.courseid=$tabletitle4.courseid and $tabletitle3.tutorid=$tabletitle4.hawkid;";
    
    // run the insert statement
    queryDB($updatequery2, $db);

    
    // get the id of the reservation we just entered
    $reservationid = mysqli_insert_id($db);
    
    // send a response back to angular
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $reservationid;
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