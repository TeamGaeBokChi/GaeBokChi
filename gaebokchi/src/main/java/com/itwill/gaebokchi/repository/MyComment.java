package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder @NoArgsConstructor @AllArgsConstructor
public class MyComment {
	
	private Integer id;
	private Integer postId;
	private String category;
	private String content;
	private String author;
	private LocalDateTime modifiedTime;
	private Integer selection;
	
}
