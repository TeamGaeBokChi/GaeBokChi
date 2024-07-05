package com.itwill.gaebokchi.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonFormatTypes;
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

	@JsonFormat(shape = JsonFormat.Shape.STRING , pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime modifiedTime;
	
	public static CommPostListDto fromEntity(CommPost commpost) {
		ByteArrayResource mediaResource = null;
		if (commpost.getMediaPath() != null) {
			// 이미지 파일 경로를 바이트 배열로 변환하여 ByteArrayResource 생성
			byte[] mediaBytes = loadMediaBytes(commpost.getMediaPath());
			mediaResource = new ByteArrayResource(mediaBytes);
		}

		return CommPostListDto.builder().id(commpost.getId()).category(commpost.getCategory())
				.title(commpost.getTitle()).author(commpost.getAuthor()).modifiedTime(commpost.getModifiedTime())
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
}
