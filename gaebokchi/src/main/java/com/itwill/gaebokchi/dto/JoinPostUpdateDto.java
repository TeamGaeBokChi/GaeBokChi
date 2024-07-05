package com.itwill.gaebokchi.dto;

import java.time.LocalDateTime;

import com.itwill.gaebokchi.repository.JoinPost;

import lombok.Data;

@Data
// 업데이트 요청의 요청 파라미터들을 저장하기 위한 DTO
public class JoinPostUpdateDto {
		private Integer id;
	  	private String title;
	    private String content;
	    private String clubtype;
	    private String gcadress;
	    private LocalDateTime teeoff;
	    private Integer greenfee;
	    private Integer hole;

	    public JoinPost toEntity() {
	        return JoinPost.builder().id(id).title(title).content(content).clubtype(clubtype).gcadress(gcadress)
	        		.teeoff(teeoff).greenfee(greenfee).hole(hole).build();
	    }
	    
}
