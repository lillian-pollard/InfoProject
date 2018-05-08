<?php
session_start();
// We need to include these two files in order to work with the database
include_once('config.php');
include_once('dbutils.php');
// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);
$tabletitle = "tcourselist";
$username = $_SESSION['hawkid'];
// set up a query to get information on films
$query = "SELECT * FROM $tabletitle WHERE hawkid='$username';";
//$query = "SELECT * FROM $tabletitle';";
// run the query to get info on films
$result = queryDB($query, $db);
// assign results to an array we can then send back to whomever called
$budgets = array();
$i = 0;
// go through the results one by one
while ($currbudget = nextTuple($result)) {
    $budgets[$i] = $currbudget;
    $courseid = $budgets[$i]['courseid'];
    $budget = $budgets[$i]['budget'];
    $currbudget = $budgets[$i]['currbudget'];
    $i++;
}
// put together a JSON object to send back the data on the films
$response = array();
$response['status'] = 'success';
// 'value' corresponds to response.data.value in data.entertainment.controller.js
// 'films' corresponds to ng-repeat="film in data.films | filter:query" in the index.html file
$response['value']['budgets'] = $budgets;
header('Content-Type: application/json');
echo(json_encode($response));
?>