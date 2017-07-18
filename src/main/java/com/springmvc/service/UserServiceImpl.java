package com.springmvc.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.stereotype.Service;

import com.springmvc.model.User;

@Service
public class UserServiceImpl implements UserService {
	
	private static List<User> users = populateDummyUsers();
	private static final AtomicLong counter = new AtomicLong();

	public List<User> findAllUsers() {
		
		return users;
	}
	
	private static List<User> populateDummyUsers(){
		List<User> users = new ArrayList<User>();
		Map<String,List<String>> map1 = populateMap1();
		Map<String,List<String>> map2 = populateMap2();
		Map<String,List<String>> map3 = populateMap3();
		users.add(new User(10,"amrita","Majumder","old calcutta","barrackpore","9038000","amrita.maj@mail.com","https://randomuser.me/api/portraits/med/men/95.jpg",map1));
		users.add(new User(11,"abc","def","xyz street","kol","12345","abc.efg@mail.com","https://randomuser.me/api/portraits/med/men/52.jpg",map2));
		users.add(new User(12,"pq","rs","mn street","how","5678","pq.rs@mail.com","https://randomuser.me/api/portraits/med/women/91.jpg",map3));
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
	private static Map<String, List<String>>  populateMap1(){
		Map<String,List<String>> finalmap = new HashMap<String, List<String>>();
		
		List<String> augustdates=new ArrayList();
		augustdates.add("28/08/2017");
		augustdates.add("27/08/2017");
		
		List<String> septdates=new ArrayList();
		septdates.add("01/09/2017");
		septdates.add("02/09/2017");
		
		finalmap.put("August",augustdates);
		finalmap.put("September",septdates);
		
		return finalmap;
	}
	private static Map<String, List<String>>  populateMap2(){
		Map<String,List<String>> finalmap = new HashMap<String, List<String>>();
		
		List<String> augustdates=new ArrayList();
		augustdates.add("12/08/2017");
		augustdates.add("13/08/2017");
		
		List<String> septdates=new ArrayList();
		septdates.add("04/09/2017");
		septdates.add("05/09/2017");
		
		finalmap.put("August",augustdates);
		finalmap.put("September",septdates);
		
		return finalmap;
	}
	private static Map<String, List<String>>  populateMap3(){
		Map<String,List<String>> finalmap = new HashMap<String, List<String>>();
		
		List<String> augustdates=new ArrayList();
		augustdates.add("09/08/2017");
		augustdates.add("10/08/2017");
		
		List<String> septdates=new ArrayList();
		septdates.add("05/09/2017");
		septdates.add("06/09/2017");
		
		finalmap.put("August",augustdates);
		finalmap.put("September",septdates);
		
		return finalmap;
	}
	/*private static Map<String, List<Date>>  populateMap1(){
		Map<String,List<Date>> finalmap = new HashMap<String, List<Date>>();
		
		List<Date> augustdates=new ArrayList();
		augustdates.add(parseMyDateString("28/08/2017"));
		augustdates.add(parseMyDateString("27/08/2017"));
		
		List<Date> septdates=new ArrayList();
		septdates.add(parseMyDateString("01/09/2017"));
		septdates.add(parseMyDateString("02/09/2017"));
		
		finalmap.put("August",augustdates);
		finalmap.put("September",septdates);
		
		return finalmap;
	}
	private static Map<String, List<Date>>  populateMap2(){
		Map<String,List<Date>> finalmap = new HashMap<String, List<Date>>();
		
		List<Date> augustdates=new ArrayList();
		augustdates.add(parseMyDateString("12/08/2017"));
		augustdates.add(parseMyDateString("13/08/2017"));
		
		List<Date> septdates=new ArrayList();
		septdates.add(parseMyDateString("04/09/2017"));
		septdates.add(parseMyDateString("05/09/2017"));
		
		finalmap.put("August",augustdates);
		finalmap.put("September",septdates);
		
		return finalmap;
	}
	private static Map<String, List<Date>>  populateMap3(){
		Map<String,List<Date>> finalmap = new HashMap<String, List<Date>>();
		
		List<Date> augustdates=new ArrayList();
		augustdates.add(parseMyDateString("09/08/2017"));
		augustdates.add(parseMyDateString("10/08/2017"));
		
		List<Date> septdates=new ArrayList();
		septdates.add(parseMyDateString("05/09/2017"));
		septdates.add(parseMyDateString("06/09/2017"));
		
		finalmap.put("August",augustdates);
		finalmap.put("September",septdates);
		
		return finalmap;
	}*/
	
	private static Date parseMyDateString(String datestr){
		
		SimpleDateFormat format=new SimpleDateFormat("dd/MM/yyyy");
		Date date=null;
		try {
			date = format.parse(datestr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}

	public void saveUser(User user) {
		user.setId(counter.incrementAndGet());
        users.add(user);
		
	}
	
	

}
