package com.itwill.gaebokchi.repository;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
	private int id;
	private String password;
	private String nickname;
	private String email;
	private String address;
	private String license;
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
	private int point;
	private String grade;
}
