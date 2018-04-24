<?php

// We need to include these two files in order to work with the databas
include_once('config.php');
include_once('dbutils.php');

// get a connection to the database
$db = connectDB($DBHost, $DBUser, $DBPassword, $DBName);

$tablename ="tcourselist";

//set up a query to get info on movies
$query = "SELECT * FROM $tablename;";

//run the query to get ino on movies
$result = queryDB($query, $db);

// assign results to an array we can then send back to whomever called
$movie = array();
$i = 0;

//go throug th results one by one
while($currentMovie = nextTuple($result)) {
    $movie[$i] = $currentMovie;
    $i++;
}

// Put together a JSON aboject to send back the data on the movies
$response = array();
$response['status'] = 'success';


$response['value']['budget'] = $tablename;
header('Content-Type: application/json');
echo(json_encode($response));

?>           