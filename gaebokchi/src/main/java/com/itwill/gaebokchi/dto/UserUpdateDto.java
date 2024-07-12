package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.UserMypage;

import lombok.Data;

@Data
public class UserUpdateDto {
	private String userid;
	private String password;
	private String changePassword;
	private String nickname;
	private String carrier;
	private String number;
	private String phone;
	private String postcode;
	private String mainAddress;
	private String detailAddress;
	private String address;
	private String grade;
	private String license;
	private String bank;
	private String bank_account;
	private String account;

	public UserMypage toEntity() {
		address = postcode + "/" + mainAddress + "/" + detailAddress;
		phone = carrier + "/" + number;
		account = bank + "/" + bank_account;

		if (!changePassword.equals("")) {
			return UserMypage
					.builder()
					.userid(userid)
					.password(changePassword)
					.nickname(nickname)
					.phone(phone)
					.address(address)
					.license(license)
					.account(account)
					.build();
		}

		return UserMypage
				.builder()
				.userid(userid)
				.password(password)
				.nickname(nickname)
				.phone(phone)
				.address(address)
				.build();

	}
}
