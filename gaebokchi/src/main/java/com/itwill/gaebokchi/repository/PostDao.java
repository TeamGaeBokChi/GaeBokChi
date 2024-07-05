package com.itwill.gaebokchi.repository;

import java.util.List;

import com.itwill.gaebokchi.dto.MainPostCreateDto;
import com.itwill.gaebokchi.dto.MainPostSearchDto;

public interface PostDao {
	int insertMainPost(Post post);
	List<Clubs> selectByClubType();
	List<Post> selectReadAll();
	Post selectByPostId(Integer id);
	int updateMainPost(Post post);
	int selectDeleteById(Integer id);
	int updatePostView(Integer id);
	int updatePostLikes(Integer id);
	int selectLikes(Integer id);
	List<Post> search(MainPostSearchDto dto);
}
