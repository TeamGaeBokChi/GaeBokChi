package com.itwill.gaebokchi.dto;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.gaebokchi.repository.CommPost;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Component
// 업데이트 요청의 요청 파라미터들을 저장하기 위한 DTO
public class CommPostUpdateDto {
	private int id;
	private String title;
	private String content;
	private String category;
	private MultipartFile media;

	private String mediaPath;

	public CommPost toEntity() {
		return CommPost.builder().id(id).title(title).content(content).media(mediaPath).category(category).build();
	}
}
