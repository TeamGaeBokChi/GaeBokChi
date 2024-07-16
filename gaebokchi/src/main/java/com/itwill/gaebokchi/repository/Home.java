package com.itwill.gaebokchi.repository;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder @AllArgsConstructor @NoArgsConstructor
public class Home {
	
	//포인트 랭킹 유저 객체
	
	private int id;
	private String name;
	private String nickname;
	private int point;
	private String image;

}
