package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.CommPost;
import com.itwill.gaebokchi.repository.ReviewPost;

import lombok.Data;

@Data
// 새 글 작성 요청에서 요청 파라미터들을 저장하기 위한 DTO
public class ReviewPostCreateDto {
    // 필드 이름을 요청 파라미터 이름과 같게 선언 & 기본 생성자 & setter.
    private String title;
    private String content;
    private String author;
    private String category;
    private String clubtype;

    public ReviewPost toEntity() {
        return ReviewPost.builder().title(title).content(content).author(author).clubtype(clubtype).category(category).build();
    }
    
}
