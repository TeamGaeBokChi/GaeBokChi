package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.gaebokchi.repository.Post;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor @AllArgsConstructor
@Component
public class MainPostUpdateDto {
	
	private Integer id;
	private String clubType;
	private String title;
	private String content;
	private LocalDateTime modifiedTime;
	private String mediaPath;
	private Integer height;
	private Integer career;
	private Integer handy;
	 private MultipartFile media; // MultipartFile 타입의 필드 추가
	private Integer driverDistance;
	private Integer ironDistance;
	
	public Post toEntity() {
	    return Post.builder()
	            .id(id)
	            .clubType(clubType)
	            .title(title)
	            .content(content)
	            .media(media != null ? media.getOriginalFilename() : null) // MultipartFile에서 파일 이름을 가져와서 설정
	            .createdTime(LocalDateTime.now()) // 예시로 현재 시간을 설정
	            .modifiedTime(modifiedTime)
	            .height(height)
	            .career(career)
	            .handy(handy)
	            .ironDistance(ironDistance)
	            .driverDistance(driverDistance)
	            .build();
	}

}
