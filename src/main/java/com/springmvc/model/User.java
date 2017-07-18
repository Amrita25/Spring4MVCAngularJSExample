package com.springmvc.model;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class User {
	
	private long id;
    
    private String firstname;
    
    private String lastname;
     
    private String street;
    
    private String city;
    
    private String phone;
     
    private String email;
    
    private String picture;
    
    private Map<String,List<String>> mymap;
    
    public User(){
    	id=0;
    }
    
    public User(long id,String firstname,String lastname,String street,String city,String phone,String email,String picture,Map<String,List<String>> mymap){
    	this.id=id;
    	this.firstname=firstname;
    	this.lastname=lastname;
    	this.street=street;
    	this.city=city;
    	this.phone=phone;
    	this.email=email;
    	this.picture=picture;
    	this.mymap=mymap;
    }

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
    @Override
	public String toString(){
		return firstname;
		
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public Map<String, List<String>> getMymap() {
		return mymap;
	}

	public void setMymap(Map<String, List<String>> mymap) {
		this.mymap = mymap;
	}

	
    
	
	

}
