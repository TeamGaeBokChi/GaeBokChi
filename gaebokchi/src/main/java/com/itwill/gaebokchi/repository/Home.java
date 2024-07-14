package com.itwill.gaebokchi.repository;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder @AllArgsConstructor @NoArgsConstructor
public class Home {
	
	//포인트 랭킹 유저 객체
	
	private String name;
	private String nickname;
	private int points;
	private String image;

}
