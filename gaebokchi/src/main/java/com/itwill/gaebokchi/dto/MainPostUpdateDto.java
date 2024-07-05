package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.gaebokchi.repository.Post;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@Builder
@NoArgsConstructor @AllArgsConstructor
@Component
public class MainPostUpdateDto {
	
	private Integer id;
	private String title;
	private String content;
	private LocalDateTime modifiedTime;
	private MultipartFile media;
	private String mediaPath;
	
	public Post toEntity() {
		return Post.builder().id(id).title(title).content(content).modifiedTime(modifiedTime).media(mediaPath).build();
	}

}
