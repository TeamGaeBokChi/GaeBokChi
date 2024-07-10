package com.itwill.gaebokchi.repository;

import java.util.List;

public interface MainCommentDao {
	int insertComment(MainComment comment);
	List<MainComment> selectCommentsByPostId(Integer postId);
	List<MainComment> selectCommentsByUserid(String userid);
	int selectComment(Integer id);
	int updateUserPoint(Integer id);
	int deleteCommentById(Integer id);
}
