package com.itwill.gaebokchi.repository;

import java.util.List;

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

	int UpdatePoint(@Param("userid") String userid, @Param("password") String password, @Param ("withdraw") int withdraw);
	
	List<User> AdminSignup();
	List<User> AdminExchange();
	
	void deleteAccept(String userid);
	void updateGrade(String userid);
	void intoLicense(String userid);
	void intoPros(String userid);
	void setPoint(@Param("userid") String userid, @Param ("withdraw") int withdraw);
	void setWithdraw(@Param("userid") String userid, @Param ("withdraw") int withdraw);

	String FindNicknameByUserId(String userid);
	
}
