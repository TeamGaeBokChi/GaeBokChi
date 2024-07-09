package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwill.gaebokchi.dto.CommPostSearchDto;

public interface CommPostDao {
	List<CommPost> selectOrderByIdDesc();

	CommPost selectById(Integer id);

	int insertPost(CommPost commpost);

	int updatePost(CommPost commpost);

	int deletePost(Integer id);

	List<CommPost> search(CommPostSearchDto dto);

	List<CommPost> selectTop5ByF001();

	List<CommPost> selectTop5ByF002();

	List<CommPost> selectByCategoryAndKeyword(CommPostSearchDto dto);

	CommPost findPreviousPost(@Param("createdTime") LocalDateTime createdTime);

	CommPost findNextPost(@Param("createdTime") LocalDateTime createdTime);

	int increaseViews(@Param("id") Integer id);

	int increaseLikes(@Param("id") Integer id);

	List<CommPost> selectPagedPosts(@Param("startRow") int startRow, @Param("endRow") int endRow);

	int selectTotalPostCount();
	
	User selectByUserid(@Param("userid") String userid);
}
