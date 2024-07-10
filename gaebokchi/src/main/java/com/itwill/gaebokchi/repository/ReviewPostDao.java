package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.ibatis.annotations.Param;

import com.itwill.gaebokchi.dto.CommPostListDto;
import com.itwill.gaebokchi.dto.ReviewPostSearchDto;

public interface ReviewPostDao {
	List<ReviewPost> selectOrderByIdDesc();

	ReviewPost selectById(Integer id);

	int insertPost(ReviewPost reviewpost);

	int updatePost(ReviewPost reviewpost);

	int deletePost(Integer id);

	List<ReviewPost> search(ReviewPostSearchDto dto);

	ReviewPost findPreviousPost(@Param("createdTime") LocalDateTime createdTime);

	ReviewPost findNextPost(@Param("createdTime") LocalDateTime createdTime);
	
	int increaseViews(@Param("id")Integer id);
	int increaseLikes(@Param("id")Integer id);
	
	List<ReviewPost> selectPagedPosts(@Param("startRow") int startRow, @Param("endRow") int endRow);

	int selectTotalPostCount();

	List<ReviewPost> Fixingthetop();
}
