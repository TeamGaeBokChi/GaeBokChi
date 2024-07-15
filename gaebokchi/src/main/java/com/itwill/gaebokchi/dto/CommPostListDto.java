package com.itwill.gaebokchi.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.itwill.gaebokchi.repository.CommPost;
import org.springframework.core.io.ByteArrayResource;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommPostListDto {
	private Integer id;
	private String title;
	private String author;
	private String category;
	private Integer views;
	private Integer likes;
	private ByteArrayResource mediaResource; // 이미지 데이터 필드 추가
	private LocalDateTime createdTime;

	// 포맷팅된 날짜를 저장할 필드 추가
	private String formattedCreatedTime;

	public static CommPostListDto fromEntity(CommPost commpost) {
		ByteArrayResource mediaResource = null;
		if (commpost.getMediaPath() != null) {
			// 이미지 파일 경로를 바이트 배열로 변환하여 ByteArrayResource 생성
			byte[] mediaBytes = loadMediaBytes(commpost.getMediaPath());
			mediaResource = new ByteArrayResource(mediaBytes);
		}

		LocalDateTime createdTime = commpost.getCreatedTime();
		String formattedCreatedTime = formatDateTime(createdTime);

		return CommPostListDto.builder().id(commpost.getId()).category(commpost.getCategory())
				.title(commpost.getTitle()).author(commpost.getAuthor()).createdTime(createdTime)
				.formattedCreatedTime(formattedCreatedTime) // 포맷팅된 날짜 설정
				.views(commpost.getViews()).likes(commpost.getLikes()).mediaResource(mediaResource) // 이미지 데이터 설정
				.build();
	}

	// 이미지 파일 경로를 바이트 배열로 변환하는 메서드 (실제 구현 필요)
	private static byte[] loadMediaBytes(String mediaPath) {
		try {
			Path path = Paths.get(mediaPath);
			return Files.readAllBytes(path);
		} catch (IOException e) {
			// 예외 처리: 파일을 읽을 수 없는 경우 등
			e.printStackTrace();
			return new byte[0]; // 빈 바이트 배열 리턴
		}
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
