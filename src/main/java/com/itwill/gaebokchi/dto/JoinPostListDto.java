package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime;

import com.itwill.gaebokchi.repository.JoinPost;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
 
// DTO(Data Transfer Object)
// 뷰 <--> 컨트롤러, 컨트롤러 <--> 서비스 사이에서 데이터를 주고 받을 때 사용하는 객체.
@Data
@NoArgsConstructor @AllArgsConstructor @Builder
public class JoinPostListDto {
    private Integer id;
    private String title;
    private String gcadress;
    private LocalDateTime teeoff;
    private Integer hole;
    private Integer greenfee;
    private String author;
    private String content;
    private Integer views;


    public static JoinPostListDto fromEntity(JoinPost joinpost) {
        return JoinPostListDto.builder()
                .id(joinpost.getId()).title(joinpost.getTitle()).gcadress(joinpost.getGcadress()).teeoff(joinpost.getTeeoff())
                .hole(joinpost.getHole()).greenfee(joinpost.getGreenfee()).author(joinpost.getAuthor()).content(joinpost.getContent())
                .views(joinpost.getViews()).build();

    }

}
