<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>my app</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
<!-- <script src="app.js" type="text/javascript"></script> -->
</head>

<body ng-app="UserApp">

	<div class='container' ng-controller="UserCtrl as ctrl">
		<h1>{{ctrl.title}}</h1>
		<div class="col-md-6">

			<li class="list-group-item" ng-repeat="contact in ctrl.contacts" ng-click="ctrl.selectUser($index)">
			<span>{{contact.firstname
					+ " " + contact.lastname}}</span></li>
		</div>

		<div class="col-md-6">
			<div class="media">
				<div class="media-left">
					<a href="#"> 
					<img src="{{ctrl.selected.picture}}" />
					</a>
				</div>
				<div class="media-body">
				<button ng-hide="ctrl.editmode" ng-click="ctrl.toggleEditmode()">Edit</button>
				<button ng-show="ctrl.editmode" ng-click="ctrl.saveUser()">Save</button>
					<p>
						<span>First Name :</span> 
						<span ng-hide="ctrl.editmode">{{ctrl.selected.firstname}}</span>
						<span ng-show="ctrl.editmode"><input type="text" ng-model="ctrl.selected.firstname"></input></span>						
					</p>
					<p>
						<span>Last Name :</span> 
						<span ng-hide="ctrl.editmode">{{ctrl.selected.lastname}}</span>	
						<span ng-show="ctrl.editmode"><input type="text" ng-model="ctrl.selected.lastname"></input></span>					
					</p>
					
					<h4 class="media-heading">
                        {{ctrl.selected.firstname + " " + ctrl.selected.lastname}}
                    </h4>
                    
                    <div>
                        <p>
                            <h4>Location</h4>
                        </p>
                        <p>
                            <span>Street :</span>
                            <span ng-hide="ctrl.editmode">{{ctrl.selected.street}}</span>
                            <span ng-show="ctrl.editmode"><input type="text" ng-model="ctrl.selected.street"></input></span>
                            
                        </p>
                        <p>
                            <span>City :</span>
                            <span ng-hide="ctrl.editmode">{{ctrl.selected.city}}</span>
                            <span ng-show="ctrl.editmode"><input type="text" ng-model="ctrl.selected.city"></input></span>
                            
                        </p>                        

                    </div>
                    <div>
                        <p>
                            <span>Phone :</span>
                            <span ng-hide="ctrl.editmode">{{ctrl.selected.phone}}</span>
                            <span ng-show="ctrl.editmode"><input type="text" ng-model="ctrl.selected.phone"></input></span>
                            
                        </p>   

                    </div>
				</div>

			</div>
		</div>
	</div>


	<script>
		var app = angular.module("UserApp", []);
		app.controller("UserCtrl", UserCtrl);
		app.service("UserService", UserService);

		function UserService($http) {
			var REST_SERVICE_URI = 'http://localhost:8080/Spring4MVCAngularJSExample/users/';
			var self = this;
			self.getContacts = function() {
				var promise1 = $http.get(REST_SERVICE_URI);
				var promise2 = promise1.then(function(response) {
					return response.data;
				});
				return promise2;
			};
			
			self.saveUser = function(userdata){
				console.log("save button service");
				return $http.put('http://localhost:8080/Spring4MVCAngularJSExample/users/' + userdata.id, userdata);
			};
		}

		function UserCtrl(UserService) {
			var self = this;

			self.title = "My Contact App";
			self.editmode=false;

			self.selectUser = function(index) {
				self.selected = self.contacts[index];
			}
			
			self.toggleEditmode=function(){
				self.editmode=!self.editmode;
			};
			
			self.saveUser=function(){
				console.log("save button clicked");
				self.toggleEditmode();
				var userdata=self.selected;
				UserService.saveUser(userdata);
			};

			var promise2 = UserService.getContacts();
			promise2.then(function(data) {
				self.contacts = data;
			});

		}
	</script>
</body>
</html>