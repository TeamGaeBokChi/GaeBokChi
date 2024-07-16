package com.itwill.gaebokchi.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwill.gaebokchi.dto.MainPostSearchDto;
import com.itwill.gaebokchi.dto.MyPostSearchDto;

public interface PostDao {
	int insertMainPost(Post post);
	List<Clubs> selectByClubType();
	List<Post> selectReadAll();
	List<Post> selectReadAllByUserid(String userid);
	Post selectByPostId(Integer id);
	int updateMainPost(Post post);
	int selectDeleteById(Integer id);
	int updatePostView(Integer id);
	int updatePostLikes(Integer id);
	int selectLikes(Integer id);
	List<Post> search(MainPostSearchDto dto);
	List<Post> searchMyPost(MyPostSearchDto dto);
    
	List<Post> getPostList(@Param("startRow") int startRow, @Param("endRow") int endRow);
	List<Post> getPostListByUserid(@Param("startRow") int startRow, String author, @Param("endRow") int endRow);

	int getTotalCount();
	int getTotalCountByUserid(String author);
	

    List<Post> getUsersViewsRank();
    List<Post> getUsersLikesRank();  
}
