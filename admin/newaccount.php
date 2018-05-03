<?php

// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');


// get a handle to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

// get data from the angular controller
// decode the json object
$data = json_decode(file_get_contents('php://input'), true);


// get each piece of data

// 
$HawkID = $data['HawkID'];
$name = $data['name'];
$student = $data['student'];
$tutor = $data['tutor'];
$administrator = $data['administrator'];
$faculty = $data['faculty'];


// set up variables to handle errors
// is complete will be false if we find any problems when checking on the data
$isComplete = true;

// error message we'll send back to angular if we run into any problems
$errorMessage = "";

//
// Validation
//

// check if HawkID meets criteria
if (!isset($HawkID) || (strlen($HawkID) < 2)) {
    $isComplete = false;
    $errorMessage .= "Please enter a HawkID with at least two characters. ";
} else {
    $HawkID = makeStringSafe($db, $HawkID);
}


// check if we already have a HawkID that matches the one the user entered
if ($isComplete) {
    // set up a query to check if this HawkID is in the database already
    $query = "SELECT hawkid FROM account WHERE HawkID='$HawkID'";
    
    // we need to run the query
    $result = queryDB($query, $db);
    
    // check on the number of records returned
    if (nTuples($result) > 0) {
        // if we get at least one record back it means the HawkID is taken
        $isComplete = false;
        $errorMessage .= "The HawkID $HawkID is already taken. Please select a different HawkID. ";
    }
}

// if we got this far and $isComplete is true it means we should add the player to the database
if ($isComplete) {
    // create a hashed version of the name    
    // we will set up the insert statement to add this new record to the database
    $insertquery = "INSERT INTO account(hawkid, name, hashedpass,student,tutor,administrator,faculty) VALUES ('$HawkID', '$name', 'True', '$student', '$tutor','$administrator', '$faculty')";
    
    // run the insert statement
    queryDB($insertquery, $db);
    
    // get the id of the account we just entered
    $accountid = mysqli_insert_id($db);
    
    // send a response back to angular
    $response = array();
    $response['status'] = 'success';
    $response['id'] = $accountid;
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