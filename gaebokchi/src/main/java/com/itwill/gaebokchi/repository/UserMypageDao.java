package com.itwill.gaebokchi.repository;

public interface UserMypageDao {
    
	Pro selectProByUserid(String userid);
    UserMypage selectByUserid(String userid);
    UserMypage selectByNickname(String nickname);
    int update(Pro pro);
    int update(UserMypage user);
    int updateNickname(Pro pro);
    int updateProCareer(Pro pro);
    int updateImage(Pro pro);
//    Point selectPointsByUserid(String userid);
    
}