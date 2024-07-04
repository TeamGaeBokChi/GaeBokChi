package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

import lombok.Data;

@Data
public class UserSignInDto {
	private String userid;
	private String password;

	public User toEntity() {

		return User.builder().userid(userid).password(password).build();

	}

}
