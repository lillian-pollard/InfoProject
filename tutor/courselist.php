<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
$tabletitle = "tcourselist";
$username = $_SESSION['hawkid'];
//
//// set up a query to get information on course
$query = "SELECT courseid FROM $tabletitle
WHERE hawkid='$username'";
//
// 
//$query = "SELECT * FROM $tabletitle;";
// run the query to get info on tcourslist
$result = queryDB($query, $db);
// assign results to an array we can then send back to whomever called
$courses = array();
$i = 0;
// go through the results one by one
while ($currcourse = nextTuple($result)) {
    $courses[$i] = $currcourse;
    $courseid = $courses[$i]['courseid'];
    $i++;
}
// put together a JSON object to send back the data on the session
$response = array();
$response['status'] = 'success';
// 'value' corresponds to response.data.value in data.entertainment.controller.js

$response['value']['courses'] = $courses;
header('Content-Type: application/json');
echo(json_encode($response));
?>