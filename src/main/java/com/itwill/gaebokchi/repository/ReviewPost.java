package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString @EqualsAndHashCode
@NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewPost {
    private Integer id;
    private String title;
    private String content;
    private String author;
    private String clubtype;
    private String category;
	private String media;
	private String mediaPath;
	private String mediaResource; 
    private Integer views;
    private Integer likes;
    private LocalDateTime createdTime;
    private LocalDateTime modifiedTime;
}
