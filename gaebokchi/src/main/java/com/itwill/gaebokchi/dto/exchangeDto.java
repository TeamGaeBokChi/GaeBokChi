package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

import lombok.Data;

@Data
public class exchangeDto {
	private String userid;
	private int amount;

	public User toEntity() {
		return User.builder().userid(userid).point(amount).build();
	}

}
