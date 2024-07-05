package com.itwill.gaebokchi.dto;

import java.util.List;

import lombok.Data;


public class MainPostPageDto {
	
	private int nowPage; // 현재 페이지
	private int pageSize; // 각 페이지 당 보여줄 게시글 수
	private int totalPosts; // 전체 게시물 수
	private List<MainPostListDto> mainPosts; // 페이지에 개설 될 포스트 리스트 객체
	
	
	public int getTotalPage() { // 전체 페이지 수를 계산하는 메서드 (Math.ceil은 반올림처리 하는 기능)
		return (int)Math.ceil((double) totalPosts / pageSize);
	}
	
	public boolean hashNext() { // 다음 페이지가 존재 하는지 확인하는 메서드
		return nowPage < getTotalPage();
	}
	
	public boolean hashPrevious() { // 이전 페이지가 존재 하는지 확인하는 메서드
		return nowPage > 1;
	}
	
	
}
