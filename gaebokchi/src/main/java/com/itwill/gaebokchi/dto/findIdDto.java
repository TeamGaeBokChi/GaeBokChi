package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

import lombok.Data;

@Data

public class findIdDto {
	private String name;
	private String email;

	public User toEntity() {
		return User.builder().name(name).email(email).build();
	}
}
