package com.springmvc.service;

import java.util.List;

import com.springmvc.model.User;



public interface UserService {

	List<User> findAllUsers();
	User findById(long id);
	void updateUser(User user);
}
