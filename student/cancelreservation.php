<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tabletitle = "reservation";
$tabletitle2="scourselist";
$tabletitle3="tcourselist";
$tabletitle4 = "sessions";
$username = $_SESSION['hawkid'];
$reservationid = $data['reservationid'];

// set up a query to get information on films
$query = "UPDATE $tabletitle SET cancel=1
WHERE  studentid='$username'
AND sessionid='$sessionid';";

// run the query to get info on films
$result = queryDB($query, $db);

// update student budget after cancelled session
$query2 = "UPDATE $tabletitle2 SET budget=budget+1
WHERE  studentid='$username'
AND $;";

// run the query to get info on films
$result2 = queryDB($query2, $db);

// set up a query to get information on films
$query3 = "UPDATE $tabletitle3 SET budget=budget+1
WHERE  hawkid='$tutorid' and ;";

// run the query to get info on films
$result3 = queryDB($query3, $db);


// assign results to an array we can then send back to whomever called
$response = array();
    $response['status'] = 'success';
    header('Content-Type: application/json');
    echo(json_encode($response)); 
?>