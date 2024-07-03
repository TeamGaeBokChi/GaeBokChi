package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime; 

import com.itwill.gaebokchi.repository.ReviewPost;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
 
// DTO(Data Transfer Object)
// 뷰 <--> 컨트롤러, 컨트롤러 <--> 서비스 사이에서 데이터를 주고 받을 때 사용하는 객체.
@Data
@NoArgsConstructor @AllArgsConstructor @Builder
public class ReviewPostListDto {
    private Integer id;
    private String title;
    private String author;
    private String category;
    private LocalDateTime modifiedTime;
    private Integer views;
    private Integer likes;

    public static ReviewPostListDto fromEntity(ReviewPost reviewpost) {
        return ReviewPostListDto.builder()
                .id(reviewpost.getId())
                .category(reviewpost.getCategory())
                .title(reviewpost.getTitle())
                .author(reviewpost.getAuthor())
                .modifiedTime(reviewpost.getModifiedTime())
                .views(reviewpost.getViews())
                .likes(reviewpost.getLikes())
                .build();
    }

}
