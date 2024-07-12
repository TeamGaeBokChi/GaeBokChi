package com.itwill.gaebokchi.dto;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.itwill.gaebokchi.repository.Post;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder @NoArgsConstructor @AllArgsConstructor
public class MainPostListDto {
	
	private Integer id;
	private String clubType;
	private String title;
	private String author;
	private Integer views;
	private Integer likes;
	private Timestamp createdTime;
	private String selection;
	private LocalDateTime modifiedTime;
	private String category;
	
	
	public static MainPostListDto fromEntity(Post post) {
		return MainPostListDto.builder().id(post.getId()).clubType(post.getClubType()).title(post.getTitle()).author(post.getAuthor()).selection(post.getSelection())
<<<<<<< HEAD
				.views(post.getViews()).likes(post.getLikes()).createdTime(Timestamp.valueOf(post.getCreatedTime())).build();
=======
				.views(post.getViews()).likes(post.getLikes()).createdTime(post.getCreatedTime()).category(post.getCategory()).modifiedTime(post.getModifiedTime()).build();
>>>>>>> branch 'final' of https://github.com/TeamGaeBokChi/GaeBokChi.git
				
	}
	

}
