package com.itwill.lab05.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.itwill.lab05.repository.User;
import com.itwill.lab05.repository.UserDao;

// 서비스(비즈니스) 계층 싱글턴 객체.
public enum UserService {
	instance;
	
	private static final Logger log = LoggerFactory.getLogger(UserService.class);
	private final UserDao userDao = UserDao.instance;
	
	// 회원 가입에 필요한 메서드. userDao.insert() 호출.
	public int create(User user) {
		log.debug("create(post={})", user);

		int result = userDao.insert(user);
		log.debug("insert result = {}", result);
		
		return result;		
	}
	
	public User signIn(String userid, String password) {
		log.debug("singIn(userid={}, password={})", userid, password);
		
		// DTO(Data Transfer Object)
		User dto = User.builder().userid(userid).password(password).build();
		User user = userDao.selectByUseridAndPassword(dto);
		log.debug("로그인 결과 = {}", user);
		
		return user;
	}
	
	public User MyPage(String id) {
		User mypage = userDao.MyPage(id);
		
		return mypage;
	}
	
}
