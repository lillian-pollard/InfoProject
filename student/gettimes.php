<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tabletitle = "sessions";
$tabletitle2 = "scourselist";
$tabletitle3 = "tcourselist";
$tabletitle4 = "reservation";
//
//// set up a query to get information on films
$query = "SELECT DISTINCT sessiontime, sessiondate, tutorid, $tabletitle.sessionid as sessionid FROM $tabletitle, $tabletitle2, $tabletitle3, $tabletitle4
WHERE $tabletitle2.courseid = $tabletitle3.courseid
AND $tabletitle.tutorid = $tabletitle3.hawkid
AND ($tabletitle.sessionid NOT IN (SELECT sessionid from $tabletitle4)) OR ($tabletitle.sessionid=$tabletitle4.sessionid AND $tabletitle4.cancel=1);";
// 
//$query = "SELECT * FROM $tabletitle;";
// run the query to get info on films
$result = queryDB($query, $db);

// assign results to an array we can then send back to whomever called
$times = array();
$i = 0;

// go through the results one by one
while ($currtime = nextTuple($result)) {
    $times[$i] = $currtime;
    $sessiontime = $times[$i]['sessiontime'];
    $sessiondate = $times[$i]['sessiondate'];
    $tutorid = $times[$i]['tutorid'];
    $i++;
}

// put together a JSON object to send back the data on the films
$response = array();
$response['status'] = 'success';

// 'value' corresponds to response.data.value in data.entertainment.controller.js
// 'films' corresponds to ng-repeat="film in data.films | filter:query" in the index.html file
$response['value']['times'] = $times;
header('Content-Type: application/json');
echo(json_encode($response));

?>