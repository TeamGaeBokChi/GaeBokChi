package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class exchangeInfoDto {
	private String userid;
	private String account;
	private int withdraw;
	private int point;

	public static exchangeInfoDto fromEntity(User user) {
		return exchangeInfoDto.builder().userid(user.getUserid()).point(user.getPoint()).account(user.getAccount())
				.withdraw(user.getWithdraw()).build();
	}

}
