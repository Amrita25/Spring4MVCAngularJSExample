package com.springmvc.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.springmvc.model.User;
import com.springmvc.service.UserService;

@RestController
@RequestMapping
public class UserController {

	@Autowired
	private UserService userservice;

	@RequestMapping(method=RequestMethod.GET, value="/users")
	public ResponseEntity<List<User>> getAllUser(){

		List<User> users = userservice.findAllUsers();
		return new ResponseEntity<List<User>>(users, HttpStatus.OK);
	}
	@RequestMapping(value = "/users/{id}", method = RequestMethod.PUT)
	public ResponseEntity<User> updateUser(@PathVariable("id") long id, @RequestBody User user){
		System.out.println("inside updateUser");
		
		User currentUser = userservice.findById(id);
		currentUser.setCity(user.getCity());
		currentUser.setEmail(user.getEmail());
		currentUser.setFirstname(user.getFirstname());
		currentUser.setLastname(user.getLastname());
		currentUser.setPhone(user.getPhone());
		currentUser.setStreet(user.getStreet());
		System.out.println("Inside update method my map value  "+user.getMymap());
		currentUser.setMymap(user.getMymap());
		userservice.updateUser(currentUser);
        return new ResponseEntity<User>(currentUser, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/users/", method = RequestMethod.POST)
    public void createUser(@RequestBody User user) {
        System.out.println("Creating User " + user.getFirstname());
        System.out.println("user map "+user.getMymap());
        
  
        userservice.saveUser(user);
        
    } 

	public UserService getUserservice() {
		return userservice;
	}

	public void setUserservice(UserService userservice) {
		this.userservice = userservice;
	}
	
	

}
