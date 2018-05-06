<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tabletitle = "reservation";
$tabletitle2 = "sessions";
$username = $_SESSION['hawkid'];

// set up a query to get information on films
$query = "SELECT * FROM $tabletitle, $tabletitle2 WHERE $tabletitle.sessionid=$tabletitle2.sessionid AND $tabletitle.studentid = '$username' ORDER BY SESSIONDATE,SESSIONTIME;";

// run the query to get info on films
$result = queryDB($query, $db);

// assign results to an array we can then send back to whomever called
$reservations = array();
$i = 0;

// go through the results one by one
while ($currres = nextTuple($result)) {
    $reservations[$i] = $currres;
    $sessiontime = $reservations[$i]['sessiontime'];
    $sessiondate = $reservations[$i]['sessiondate'];
    $tutorid = $reservations[$i]['tutorid'];
    $courseid = $reservations[$i]['courseid'];
    $sessionid = $reservations[$i]['sessionid'];
    $i++;
}

// put together a JSON object to send back the data on the films
$response = array();
$response['status'] = 'success';
$response['number'] = nTuples($result);
// 'value' corresponds to response.data.value in data.entertainment.controller.js
// 'films' corresponds to ng-repeat="film in data.films | filter:query" in the index.html file
$response['value']['reservations'] = $reservations;
header('Content-Type: application/json');
echo(json_encode($response));

?>