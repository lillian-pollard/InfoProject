<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
$tabletitle = "problemset";
$tabletitle2 = "tcourselist";
$username = $_SESSION['hawkid'];
//
//// set up a query to get information on films
$query = "SELECT * FROM $tabletitle, $tabletitle2  WHERE $tabletitle.courseid = $tabletitle2.courseid AND hawkid='$username';";
//$query = "SELECT * FROM $tabletitle;";
// run the query to get info on films
$result = queryDB($query, $db);
// assign results to an array we can then send back to whomever called
$problems = array();
$i = 0;
// go through the results one by one
while ($currprob = nextTuple($result)) {
    $problems[$i] = $currprob;
    $file = $problems[$i]['filename'];
    $courseid = $problems[$i]['courseid'];
    $i++;
}
// put together a JSON object to send back the data on the films
$response = array();
$response['status'] = 'success';
// 'value' corresponds to response.data.value in data.entertainment.controller.js
// 'films' corresponds to ng-repeat="film in data.films | filter:query" in the index.html file
$response['value']['problems'] = $problems;
header('Content-Type: application/json');
echo(json_encode($response));
?>