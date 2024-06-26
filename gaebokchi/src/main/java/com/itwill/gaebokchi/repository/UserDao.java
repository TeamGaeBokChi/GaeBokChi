package com.itwill.gaebokchi.repository;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserDao {
	
	User selectByUserid(String userid);
	User selectByNickname(String nickname);
    void insertNormalUser(User user);
    User selectByUseridAndPassword(User user);
    void insertPros(@Param("license") String license);
    void insertExpertUser(User user);
}
