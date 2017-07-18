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
			<ul class="list-group">
				<li class="list-group-item" ng-repeat="contact in ctrl.contacts" ng-click="ctrl.selectUser($index)">
					<span>{{contact.firstname + " " + contact.lastname}}</span>
				</li>
			</ul>
        <button ng-click="ctrl.addUser()">Add</button>
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
                    <div>
                    <h4><p>Your Selected Dates:</p></h4>
                    <input ng-show="ctrl.editmode" type="date" ng-model="ctrl.selected.newDate"></input><button ng-show="ctrl.editmode" ng-click="ctrl.addNewDate()">Add</button>
                    
                    <ul ng-repeat="(key, value) in ctrl.selected.mymap">
                    	<h6><p>Month : {{key}}</p></h6>                   	
                    	
                    	<li ng-repeat="v in value track by $index">
                    		{{v}}
                    	<button ng-show="ctrl.editmode" ng-click="ctrl.deleteDate(key,$index)">delete</button>
                    	</li>
                    	
                     </ul>
                    
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
				
				var promise1= $http.put(REST_SERVICE_URI + userdata.id, userdata);
				return promise1;
			};
			
			self.createUser = function (userData) {
	            //$http.put("url",putbody);
	            //update the data on server
	            var promise1 = $http.post(REST_SERVICE_URI, userData);
	            return promise1;

	        };
		}

		function UserCtrl(UserService) {
			var self = this;

			self.title = "My Contact App";
			self.editmode=false;

			self.selectUser = function(index) {
				self.selected = self.contacts[index];
				console.log(self.selected);
			}
			
			self.toggleEditmode=function(){
				self.editmode=!self.editmode;
			};
			
			self.saveUser=function(){
				console.log("save button clicked");
				self.toggleEditmode();
				var userdata=self.selected;
				if(!self.addmode){
					var promise1=UserService.saveUser(userdata);
					promise1.then(
					function(){
						self.successmsg = "SuccessFull";
					},
					function(){
						self.errorsmsg = "Error!!";
					}
					);
				}else{
					var promise1=UserService.createUser(userdata);
					promise1.then(
					function(){
						self.successmsg = "SuccessFull";
					},
					function(){
						self.errorsmsg = "Error!!";
					}
					);
				}
			};
			
			self.addUser = function(){
				//console.log("add button clicked");
				self.editmode = true;
				self.addmode = true;
				self.selected={};
			};

			var promise2 = UserService.getContacts();
			promise2.then(function(data) {
				self.contacts = data;
			});
			
			self.addNewDate = function(){
				
				var monthNames = ["January", "February", "March", "April", "May", "June",
				                  "July", "August", "September", "October", "November", "December"
				                ];
				
				var d = new Date(self.selected.newDate);
				var monthname=monthNames[d.getMonth()];
				
				
				if(self.selected.mymap == undefined){
					self.selected.mymap={"":[],"":[]};
				 	self.selected.mymap[monthname]=[formatDate(new Date(self.selected.newDate))];
				}
				else{
					
					var dateList=self.selected.mymap[monthname];
					
				 	if(dateList != undefined){
						dateList.push(formatDate(new Date(self.selected.newDate)));
					}
				 	else {					
						self.selected.mymap[monthname]=[formatDate(new Date(self.selected.newDate))];
					} 
				
				//console.log("month :"+monthname);
				//console.log("date "+formatDate(new Date(self.selected.newDate)));
				
				//console.log("map e existing "+self.selected.mymap[monthname]);
				}
			}
			
			self.deleteDate = function(key,index){
				//console.log("delete key "+key);
				//console.log("delete index "+index);
				//console.log("selected list "+self.selected.mymap[key]);
				self.selected.mymap[key].splice(index,1);
				//console.log("after delete list "+self.selected.mymap[key].length);
				if(self.selected.mymap[key].length == 0){
				delete self.selected.mymap[key];
				}
				
			}
			
			function formatDate(date){
				var monthNames = ["January", "February", "March", "April", "May", "June",
				                  "July", "August", "September", "October", "November", "December"
				                ];
				var day = date.getDate();
				  var monthIndex = date.getMonth();
				  var year = date.getFullYear();
				  
				  return monthIndex+1 + '/' + day + '/' + year;
			}

		}
	</script>
</body>
</html>