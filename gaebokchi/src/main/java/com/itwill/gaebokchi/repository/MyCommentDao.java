package com.itwill.gaebokchi.repository;

import java.util.List;

public interface MyCommentDao {
	
	List<MyComment> selectCommentsByUserid(String userid);
	
}
