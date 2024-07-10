package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class AcceptListDto {
	private String userid;
	private String name;
	private String email;
	private String accept;
	
	public static AcceptListDto fromEntity(User user) {
		return AcceptListDto.builder().userid(user.getUserid()).name(user.getName()).email(user.getEmail()).accept(user.getAccept()).build();
	}
}
