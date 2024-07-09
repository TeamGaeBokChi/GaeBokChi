package com.itwill.gaebokchi.dto;

import java.security.Timestamp;

import com.itwill.gaebokchi.repository.MainComment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder @NoArgsConstructor @AllArgsConstructor
public class MainCommentItemDto {
	
	private Integer id;
	private String author;
	private String nickname;
	private String image;
	private String content;
	private Integer selection;
	private Timestamp modifiedTime;
	
	public static MainCommentItemDto fromEntity(MainComment mainComment) {
		return MainCommentItemDto.builder().id(mainComment.getId())
				.nickname(mainComment.getNickname())
				.image(mainComment.getImage())
				.author(mainComment.getAuthor())
				.content(mainComment.getContent())
				.selection(mainComment.getSelection()).build();
	}

}
