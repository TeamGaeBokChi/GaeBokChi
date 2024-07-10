package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

import lombok.Data;

@Data
public class expertUserCreateDto {
	private int id;
	private String password;
	private String nickname;
	private String email;
	private String address;
	private String accept;
	private String account;
	private String name;
	private int birth;
	private String userid;
	private int gender;
	private int birthYear;
	private int birthMonth;
	private int birthDay;
	private String phone;
	private String carrier;
	private String phone1;
	private String phone2;
	private String phone3;
	private String postCode;
	private String addressMain;
	private String addressDetail;
	private String bank;
	private String accountNumber;
	private int male;
	private int female;
	private String emailPrefix;
	private String emailSeparator;

	public User toEntity() {
		birth = Integer.parseInt(String.format("%04d%02d%02d", birthYear, birthMonth, birthDay));
		phone = carrier + "/" + phone1 + "-" + phone2 + "-" + phone3;
		address = postCode + "/" + addressMain + "/" + addressDetail;
		email = emailPrefix + "@" + emailSeparator;
		account = bank + "/" + accountNumber;
		if (male == 1) {
			gender = male;
		} else {
			gender = female;
		}
		return User.builder().userid(userid).password(password).name(name).nickname(nickname).phone(phone).email(email)
				.birth(birth).gender(gender).address(address).account(account).accept(accept).build();
	}
}
