package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString @EqualsAndHashCode
@NoArgsConstructor @AllArgsConstructor @Builder
public class JoinPost {
    private Integer id;
    private String title;
    private String gcadress;
    private LocalDateTime teeoff;
    private Integer greenfee;
    private Integer hole;
    private String content;
    private String author;
    private String clubtype;
    private String category;
    private Integer views;
    private LocalDateTime createdTime;
    private LocalDateTime modifiedTime;
}
