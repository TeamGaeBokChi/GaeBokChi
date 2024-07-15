package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

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

	// 포맷팅된 날짜를 저장할 필드 추가
	private String formattedCreatedTime;
	private String formattedModifiedTime;

	public String getFormattedCreatedTime() {
		return formatDateTime(this.createdTime);
	}

	public String getFormattedModifiedTime() {
		return formatDateTime(this.modifiedTime);
	}

	private static String formatDateTime(LocalDateTime dateTime) {
		if (dateTime != null) {
			// 포맷 정의
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
			// 포맷 적용
			return dateTime.format(formatter);
		} else {
			return null;
		}
	}
}
