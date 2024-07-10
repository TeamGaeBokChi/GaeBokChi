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
public class ExchangeListDto {
	private String userid;
	private String name;
	private int withdraw;

	public static ExchangeListDto fromEntity(User user) {
		return ExchangeListDto.builder().userid(user.getUserid()).name(user.getName()).withdraw(user.getWithdraw())
				.build();
	}
}
