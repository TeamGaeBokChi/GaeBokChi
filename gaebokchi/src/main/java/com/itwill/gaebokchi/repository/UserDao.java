package com.itwill.gaebokchi.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserDao {

	User selectByUserid(String userid);

	User selectByNickname(String nickname);
	
	User selectByEmail(String email);

	void insertNormalUser(User user);

	User selectByUseridAndPassword(User user);

	void insertPros(@Param("license") String license);

	void insertExpertUser(User user);

	User FindUserid(User user);

	User FindPassword(User user);

	int UpdatePassword(User user);

	int UpdatePoint(@Param("userid") String userid, @Param("password") String password, @Param ("point") int point);

	String FindNicknameByUserId(String userid);
	
}
