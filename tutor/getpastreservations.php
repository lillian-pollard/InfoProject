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
$query = "SELECT $tabletitle.sessionid as sessionid, sessiontime, sessiondate, studentid, courseid, reservationid FROM $tabletitle, $tabletitle2
WHERE $tabletitle.sessionid=$tabletitle2.sessionid
AND $tabletitle2.tutorid = '$username' AND $tabletitle.cancel IS NULL AND $tabletitle.notes IS NULL
AND sessiondate<CURDATE()
ORDER BY SESSIONDATE,SESSIONTIME;";
// run the query to get info on films
$result = queryDB($query, $db);
// assign results to an array we can then send back to whomever called
$pastreservations = array();
$i = 0;
// go through the results one by one
while ($currpast = nextTuple($result)) {
    $pastreservations[$i] = $currpast;
    $sessiontime = $pastreservations[$i]['sessiontime'];
    $sessiondate = $pastreservations[$i]['sessiondate'];
    $courseid = $pastreservations[$i]['courseid'];
    $studentid = $pastreservations[$i]['studentid'];
    $reservationid = $pastreservations[$i]['reservationid'];
    $i++;
}
// put together a JSON object to send back the data on the films
$response = array();
$response['status'] = 'success';
$response['number'] = nTuples($result);
// 'value' corresponds to response.data.value in data.entertainment.controller.js
// 'films' corresponds to ng-repeat="film in data.films | filter:query" in the index.html file
$response['value']['pastreservations'] = $pastreservations;
header('Content-Type: application/json');
echo(json_encode($response));
?>