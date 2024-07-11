package com.itwill.gaebokchi.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserDao {

	User selectByUserid(String userid);

	User selectByNickname(String nickname);

	User selectByEmail(String email);
	
	User selectByPhone(String phone);
	
	User selectByAccept(String accept);

	void insertNormalUser(User user);

	User selectByUseridAndPassword(User user);

	void insertPros(@Param("license") String license);

	void insertExpertUser(User user);

	User FindUserid(User user);

	User FindPassword(User user);

	int UpdatePassword(User user);

	int UpdatePoint(@Param("userid") String userid, @Param("password") String password,
			@Param("withdraw") int withdraw);

	List<User> AdminSignup();

	List<User> AdminExchange();

	List<User> AllMembers();

	void deleteAccept(String userid);

	void updateGrade(String userid);

	void intoLicense(@Param("userid") String userid, @Param("accept") String accept);

	void intoPros(@Param("userid") String userid, @Param("accept") String accept );

	void setPoint(@Param("userid") String userid, @Param("withdraw") int withdraw);

	void setWithdraw(@Param("userid") String userid, @Param("withdraw") int withdraw);

	void changeGrade(@Param("userid") String userid, @Param("grade") String grade);

	void deleteUser(String userid);

	void setGrade(@Param("userid") String userid, @Param("grade") String grade);
	
	
	
	String FindNicknameByUserId(String userid);

}
