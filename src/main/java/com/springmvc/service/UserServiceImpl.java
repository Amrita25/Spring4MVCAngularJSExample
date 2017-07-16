package com.springmvc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.springmvc.model.User;

@Service
public class UserServiceImpl implements UserService {
	
	private static List<User> users = populateDummyUsers();

	public List<User> findAllUsers() {
		
		return users;
	}
	
	private static List<User> populateDummyUsers(){
		List<User> users = new ArrayList<User>();
		users.add(new User(1,"amrita","Majumder","old calcutta","barrackpore","9038000","amrita.maj@mail.com","https://randomuser.me/api/portraits/med/men/95.jpg"));
		users.add(new User(1,"abc","def","xyz street","kol","12345","abc.efg@mail.com","https://randomuser.me/api/portraits/med/men/52.jpg"));
		users.add(new User(1,"pq","rs","mn street","how","5678","pq.rs@mail.com","https://randomuser.me/api/portraits/med/women/91.jpg"));
		return users;
	}

	public User findById(long id) {
		User finaluser=null;
		for(User user : users){
			if(id==user.getId()){
				finaluser=user;
			}
		}
		return finaluser;
	}

	public void updateUser(User user) {
		int index = users.indexOf(user);
        users.set(index, user);
		
	}

	
	

}
