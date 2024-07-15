package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.itwill.gaebokchi.repository.Comment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommentItemDto {
	private Integer id;
	private String content;
	private String author;
	private LocalDateTime modifiedTime;

	private String formattedModifiedTime;

	// Comment 타입의 객체를 CommentItemDto 타입 객체로 변환해서 리턴하는 메서드.
	public static CommentItemDto fromEntity(Comment comment) {
		// LocalDateTime을 포맷팅하여 문자열로 변환
		String formattedModifiedTime = formatDateTime(comment.getModifiedTime());

		return CommentItemDto.builder().id(comment.getId()).content(comment.getContent()).author(comment.getAuthor())
				.modifiedTime(comment.getModifiedTime()).formattedModifiedTime(formattedModifiedTime).build();
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
