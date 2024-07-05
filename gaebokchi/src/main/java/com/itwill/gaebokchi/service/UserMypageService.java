package com.itwill.gaebokchi.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.gaebokchi.dto.UserProfileDto;
import com.itwill.gaebokchi.dto.UserUpdateDto;
import com.itwill.gaebokchi.repository.Pro;
// import com.itwill.gaebokchi.repository.Point;
import com.itwill.gaebokchi.repository.UserMypage;
import com.itwill.gaebokchi.repository.UserMypageDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserMypageService {

	private final UserMypageDao userDao;

	public UserMypage read(String userid) {
		log.debug("read(userid={})", userid);

		UserMypage user = userDao.selectByUserid(userid);
		log.debug("select 결과 = {}", user);

		return user;
	}

	public Pro readPro(String userid) {
		log.debug("read(userid={})", userid);

		Pro pro = userDao.selectProByUserid(userid);
		log.debug("select 결과 = {}", pro);

		return pro;
	}
	
	// 닉네임 중복 체크: true - 중복되지 않은 닉네임(사용 가능한 닉네임), false - 중복된 닉네임
	public boolean checkNickname(String nickname) {
		log.debug("checkNickname(nickname={})", nickname);

		UserMypage user = userDao.selectByNickname(nickname);
		if (user == null) {
			return true;
		} else {
			return false;
		}
	}

	public void update(UserUpdateDto user) {
		log.debug("update(user={})", user);

		userDao.update(user.toEntity());
	}
	
	public void updateImage(UserProfileDto user) {
		log.debug("updateImage(dto={})");

		userDao.updateImage(user.toEntity());
	}
	
	@Transactional
    public Pro updateProfile(UserProfileDto user) {
		log.debug("updateProfile(user={})", user);
		
		if (user.getNickname() != null) {
			userDao.updateNickname(user.toEntity());
		}
        
        if (user.getCareer() != null) {
        	userDao.updateProCareer(user.toEntity());
        }
        
        return userDao.selectProByUserid(user.getUserid());
	}
//	public Point change(String userid) {
//		log.debug("read(userid={})", userid);
//		
//		Point point = userDao.selectPointsByUserid(userid);
//		log.debug("select 결과 = {}", point);
//		
//		return point;
//	}
}