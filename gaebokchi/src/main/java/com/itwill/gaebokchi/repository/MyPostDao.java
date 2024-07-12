package com.itwill.gaebokchi.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwill.gaebokchi.dto.MyPostListSearchDto;

public interface MyPostDao {

	List<MyPost> search(MyPostListSearchDto dto);

	List<MyPost> selectPagedPosts(@Param("startRow") int startRow, String author, @Param("endRow") int endRow);

	int selectTotalPostCount(String author);
	
	List<MyPost> selectAll();
	
	int deletePost(Integer id);

}
