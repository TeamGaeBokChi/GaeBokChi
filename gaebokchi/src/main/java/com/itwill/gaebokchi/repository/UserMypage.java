package com.itwill.gaebokchi.repository;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 데이터베이스 테이블 users 테이블의 모델 객체
@Data
@NoArgsConstructor @AllArgsConstructor @Builder
public class UserMypage {
    private Integer id; // PK
    private String userid; // 로그인 아이디
    private String password; // 로그인 비밀번호
    private String name; // 사용자 이름
    private String nickname; // 사용자 별명
    private Integer birth; // 생년월일
    private Integer gender; // 성별
    private String phone; // 전화번호
    private String email; // 이메일
    private String address; // 주소
    private String license; // 자격번호
    private String account; // 계좌번호
    private Integer point; // 포인트
    private String grade; // 등급
    private String image; // 프로필 이미지
}