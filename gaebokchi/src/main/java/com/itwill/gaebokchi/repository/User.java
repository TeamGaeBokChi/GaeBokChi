package com.itwill.gaebokchi.repository;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor @AllArgsConstructor @Builder
public class User {
	private int id;
	private String password;
	private String nickname;
	private String phone;
	private String email;
	private String address;
	private String license;
	private String account;
	private int point;
	private String grade;
	private String name;
	private int birth;
	private String userid;
	private int gender;
}
