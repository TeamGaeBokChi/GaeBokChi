package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder @NoArgsConstructor @AllArgsConstructor
public class MainComment {
	
	private Integer id;
	private Integer postId;
	private String content;
	private String author;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;	
	private Integer selection;
	
}
