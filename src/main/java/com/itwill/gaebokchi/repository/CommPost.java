package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommPost {

	private Integer id;
	private String title;
	private String content;
	private String author;
	private String clubtype;
	private String category;
	private String media;
	private String mediaPath;
	private String mediaResource; // 새로 추가한 mediaResource 속성
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
	private Integer views;
	private Integer likes;
}
