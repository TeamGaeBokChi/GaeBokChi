package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime;

import com.itwill.gaebokchi.repository.CommPost;
import com.itwill.gaebokchi.repository.JoinPost;
import com.itwill.gaebokchi.repository.ReviewPost;

import lombok.Data;

@Data
// 새 글 작성 요청에서 요청 파라미터들을 저장하기 위한 DTO
public class JoinPostCreateDto {
    // 필드 이름을 요청 파라미터 이름과 같게 선언 & 기본 생성자 & setter.
    private String title;
    private String content;
    private String author;
    private String category;
    private String clubtype;
    private String gcadress;
    private LocalDateTime teeoff;
    private Integer greenfee;
    private Integer hole;

    public JoinPost toEntity() {
        return JoinPost.builder().title(title).content(content).author(author).clubtype(clubtype).category(category).gcadress(gcadress)
        		.teeoff(teeoff).greenfee(greenfee).hole(hole).build();
    }
    
}
