package com.itwill.gaebokchi.repository;

public interface UserMypageDao {
    
	Pro selectProByUserid(String userid);
    Normal selectByUserid(String userid);
    UserMypage selectByNickname(String nickname);
    int update(UserMypage user);
    int updateNickname(UserMypage user);
    int updateProCareer(UserMypage user);
    int updateImage(UserMypage user);
//    Point selectPointsByUserid(String userid);
    
}