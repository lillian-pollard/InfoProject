/*
 * Controller where we get the data on entertainment films
 */
(function () {
    'use strict';
    
    // the 'entertainment' part comes from the name of the app we created in entertainment.module.js
    var myApp = angular.module("tutor");
    
    // 'dataControl' is used in the html file when defning the ng-controller attribute
    myApp.controller("dataControl", function($scope, $http, $window) {
        
        // define data for the app
        // in the html code we will refer to data.films. The data part comes from $scope.data, the films part comes from the JSON object below
        
        $http.get('getfilms.php')
            .then(function(response) {
                // response.data.value has value come from the getfilms.php file $response['value']['films'] = $films;
                $scope.data = response.data.value;
            }
                   );

        
        
        /*
         *    Code for search bar
         *    With queryBy you can say which attribute you want to search under. For example if it is "name" it will only search under names. If you want to search under everything, then use "$"
         *    We are assuming there is an input element with an ng-model="query[queryBy]"
         *    We are also assuming that you are filtering through this query when you get data under ng-repeat
         */
        $scope.query = {};
        $scope.queryBy = "$";
            
        // this variable will hold the page number that should be highlighted in the menu bar
        // 0 is for index.html
        // 1 is for newfilm.html
        $scope.menuHighlight = 0;
        
        
        // function to send new film information to web api to add it to the database
        //$scope.newfilm = function(filmDetails) {
        //  var filmupload = angular.copy(filmDetails);
        //  
        //  $http.post("newfilm.php", filmupload)
        //    .then(function (response) {
        //       if (response.status == 200) {
        //            if (response.data.status == 'error') {
        //                alert('error: ' + response.data.message);
        //            } else {
        //                // successful
        //                // send user back to home page
        //                $window.location.href = "index.html";
        //            }
        //       } else {
        //            alert('unexpected error');
        //       }
        //    });
        //};
        //
        
        // function to delete a film. it receives the film's name and id and call a php web api to complete deletion from the database
        //$scope.deletefilm = function(name, id) {
        //    if (confirm("Are you sure you want to delete " + name + "?")) {
        //  
        //        $http.post("deletefilm.php", {"id" : id})
        //          .then(function (response) {
        //             if (response.status == 200) {
        //                  if (response.data.status == 'error') {
        //                      alert('error: ' + response.data.message);
        //                  } else {
        //                      // successful
        //                      // send user back to home page
        //                      $window.location.href = "index.html";
        //                  }
        //             } else {
        //                  alert('unexpected error');
        //             }
        //          }
        //        );
        //    }
        //};
        
        

        /*
         * Set edit mode of a particular film
         * on is true if we are setting edit mode to be on, false otherwise
         * film corresponds to the film for which we are setting an edit mode
         */
        //$scope.setEditMode = function(on, film) {
        //    if (on) {
        //        // if film had a birth, for example, you'd include the line below
        //        // film.birthyear = parseInt(film.birthyear);
        //        // editfilm matches the ng-model used in the form we use to edit film information
        //        $scope.editfilm = angular.copy(film);
        //        film.editMode = true;
        //    } else {
        //        // if editfilm is null we assume no film is currently being edited
        //        $scope.editfilm = null;
        //        film.editMode = false;
        //    }
        //};
        //
        ///*
        // * Gets the edit mode for a particular film
        // */
        //$scope.getEditMode = function(film) {
        //    return film.editMode;
        //};
        
        
        // function to send new account information to web api to add it to the database
        $scope.newAccount = function(accountDetails) {
          var accountupload = angular.copy(accountDetails);
          
          $http.post("newaccount.php", accountupload)
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
                        $window.location.href = "index.html";
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
