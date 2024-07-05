package com.itwill.gaebokchi.repository;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor @AllArgsConstructor @Builder
public class Point {
 //	private Integer postid; // 댓글이 달린 게시글의 id
    private String title; // 게시글 제목
 // private Integer exchange; // 환전한 금액  
    private Integer plus; // 획득한 포인트
 // private Integer minus; // 차감된 포인트
    private Integer total; // 현재 포인트
}
