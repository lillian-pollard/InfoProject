/*
 * Controller where we get the data on entertainment films
 */
(function () {
    'use strict';
    
    // the 'entertainment' part comes from the name of the app we created in entertainment.module.js
    var myApp = angular.module("tutor");
    
    // 'dataControl' is used in the html file when defning the ng-controller attribute
    myApp.controller("dataControl", function($scope, $http, $window) {
        $http.get('gettimes.php')
            .then(function(response) {
                // response.data.value has value come from the getfilms.php file $response['value']['films'] = $films;
                $scope.data = response.data.value;
                }
            );
        //get budget
        $http.get('getbudget.php')
            .then(function(response) {
                // response.data.value has value come from the getfilms.php file $response['value']['films'] = $films;
                $scope.data2 = response.data.value;
                }
            );
            
        $http.get('getreservation.php')
            .then(function(response) {
                // response.data.value has value come from the getfilms.php file $response['value']['films'] = $films;
                $scope.data3 = response.data.value;
                }
            );
        $http.get('getproblems.php')
            .then(function(response) {
                // response.data.value has value come from the getfilms.php file $response['value']['films'] = $films;
                $scope.data4 = response.data.value;
                }
            );
            
        
        // define data for the app
        // in the html code we will refer to data.films. The data part comes from $scope.data, the films part comes from the JSON object below
       
        $scope.query = {};
        $scope.queryBy = "$";
            
        // this variable will hold the page number that should be highlighted in the menu bar
        // 0 is for index.html
        // 1 is for newfilm.html
        $scope.menuHighlight = 0;
        
        $scope.cancel = function(reservationid) {
          var cancelres = angular.copy(reservationid);
          
          $http.post("cancelreservation.php", {"reservationid": cancelres})
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // send user back to home page
                        $window.location.href = "calendar.html";
                    }
               } else {
                    alert('unexpected error');
               }
            });
        };
        
        $scope.addres = function(sessionid) {          
          $http.post("addreservation.php", {"sessionid": sessionid})
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // send user back to home page
                        $window.location.href = "calendar.html";
                    }
               } else {
                    alert('unexpected error');
               }
            
          });              
        };

       
        // function to send new account information to web api to add it to the database
        $scope.login = function(accountDetails) {
          var accountupload = angular.copy(accountDetails);
          
          $http.post("login.php", accountupload)
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // send user back to home page
                        $window.location.href = "index.html";
                    }
               } else {
                    alert('unexpected error');
               }
            });                        
        };
        
        
        // function to log the user out
        $scope.logout = function() {
          $http.post("logout.php")
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // send user back to home page
                        $window.location.href = "home.html";
                    }
               } else {
                    alert('unexpected error');
               }
            });                        
        };             
        
        // function to check if user is logged in
        $scope.checkifloggedin = function() {
          $http.post("isloggedin.php")
            .then(function (response) {
               if (response.status == 200) {
                    if (response.data.status == 'error') {
                        alert('error: ' + response.data.message);
                    } else {
                        // successful
                        // set $scope.isloggedin based on whether the user is logged in or not
                        $scope.isloggedin = response.data.loggedin;
                    }
               } else {
                    alert('unexpected error');
               }
            });                        
        };
    });
    
    
} )();
