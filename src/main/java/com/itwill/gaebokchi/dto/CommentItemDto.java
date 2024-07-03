package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime;

import com.itwill.gaebokchi.repository.Comment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor @AllArgsConstructor @Builder
public class CommentItemDto {
    private Integer id;
    private String content;
    private String author;
    private LocalDateTime modifiedTime;

    // Comment 타입의 객체를 CommentItemDto 타입 객체로 변환해서 리턴하는 메서드.
    public static CommentItemDto fromEntity(Comment comment) {
        return CommentItemDto.builder()
                .id(comment.getId())
                .content(comment.getContent())
                .author(comment.getAuthor())
                .modifiedTime(comment.getModifiedTime())
                .build();
    }
}
