package com.itwill.gaebokchi.repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwill.gaebokchi.dto.JoinPostSearchDto;

public interface JoinPostDao {
	List<JoinPost> selectOrderByIdDesc();

	JoinPost selectById(Integer id);

	int insertPost(JoinPost Joinpost);

	int updatePost(JoinPost Joinpost);

	int deletePost(Integer id);

	JoinPost findPreviousPost(@Param("teeoff") LocalDateTime teeoff);

	JoinPost findNextPost(@Param("teeoff") LocalDateTime teeoff);

	List<JoinPost> selectByTeeoffDate(@Param("teeoffDate") LocalDate teeoffDate);
	
	List<JoinPost> search(JoinPostSearchDto dto);
	
	List<JoinPost> selectPagedPosts(@Param("startRow") int startRow, @Param("endRow") int endRow);

	int selectTotalPostCount();

	
}