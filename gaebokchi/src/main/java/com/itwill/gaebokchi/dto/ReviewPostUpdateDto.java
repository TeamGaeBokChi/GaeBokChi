package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.ReviewPost;

import lombok.Data;

@Data
// 업데이트 요청의 요청 파라미터들을 저장하기 위한 DTO
public class ReviewPostUpdateDto {
    private int id;
    private String title;
    private String content;
    
    public ReviewPost toEntity() {
        return ReviewPost.builder().id(id).title(title).content(content).build();
    }
}
