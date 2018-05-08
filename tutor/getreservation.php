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
// set up a query to get information on sessuibs
$query = "SELECT sessiontime,sessiondate,studentid,courseid,$tabletitle.sessionid as sessionid
FROM $tabletitle, $tabletitle2 WHERE $tabletitle.sessionid=$tabletitle2.sessionid
AND $tabletitle2.tutorid = '$username' AND $tabletitle.cancel IS NULL and
$tabletitle2.cancel IS NULL AND sessiondate>=CURDATE()
ORDER BY sessiondate,sessiontime;";
// run the query to get info on sessions
$result = queryDB($query, $db);
// assign results to an array we can then send back to whomever called
$reservations = array();
$i = 0;
// go through the results one by one
while ($currres = nextTuple($result)) {
    $reservations[$i] = $currres;
    $sessiontime = $reservations[$i]['sessiontime'];
    $sessiondate = $reservations[$i]['sessiondate'];
    $studentid = $reservations[$i]['studentid'];
    $courseid = $reservations[$i]['courseid'];
    $sessionid = $reservations[$i]['sessionid'];
    $i++;
}
// put together a JSON object to send back the data on the reservation
$response = array();
$response['status'] = 'success';
$response['number'] = nTuples($result);
// 'value' corresponds to response.data.value in data.entertainment.controller.js

$response['value']['reservations'] = $reservations;
header('Content-Type: application/json');
echo(json_encode($response));
?>