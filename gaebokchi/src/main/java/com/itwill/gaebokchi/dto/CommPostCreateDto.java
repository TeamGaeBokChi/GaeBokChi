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
public class CommPostCreateDto {
	private String author;
	private String title;
	private MultipartFile media;
	private String content;
	private String category;

	private String mediaPath;

	public CommPost toEntity() {
		log.debug("postToEntity()");
		return CommPost.builder().category(category).media(mediaPath).author(author).title(title)
				.content(content).build();
	}
}
