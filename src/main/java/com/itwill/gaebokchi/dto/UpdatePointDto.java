package com.itwill.gaebokchi.dto;

import com.itwill.gaebokchi.repository.User;

import lombok.Builder;
import lombok.Data;

@Data
public class UpdatePointDto {
	private String userid;
	private String password;
	private int point;
	
}
