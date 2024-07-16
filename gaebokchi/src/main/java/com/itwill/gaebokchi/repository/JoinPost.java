package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;
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
public class JoinPost {
	private Integer id;
	private String title;
	private String gcadress;
	private LocalDateTime teeoff;
	private Integer greenfee;
	private Integer hole;
	private String content;
	private String author;
	private String clubtype;
	private String category;
	private Integer views;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;

	// 포맷팅된 teeoff 시간을 저장할 필드 추가
	// private String formattedTeeoff;

	public String getFormattedTeeoff() {
		return formatDateTime(this.teeoff);
	}

	// LocalDateTime을 포맷팅하여 문자열로 변환하는 메서드
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
