package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

public class findPasswordDto {
	private String userid;
	private String email;
	private String phone;

	public User toEntity() {
		return User.builder().userid(userid).email(email).phone(phone).build();
	}
}
