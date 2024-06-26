package com.itwill.gaebokchi.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.gaebokchi.dto.expertUserCreateDto;
import com.itwill.gaebokchi.dto.normalUserCreateDto;
import com.itwill.gaebokchi.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

	private final UserService userService;

	@GetMapping("/signin")
	public void signIn() {

	}

	@GetMapping("/signup") // GET 방식의 /user/signup 요청을 처리하는 컨트롤러 메서드
	public void signUp() {

	}

	@PostMapping("/signup")
	public String signUp(@RequestParam(name = "userType") String userType, normalUserCreateDto normalDto,
			expertUserCreateDto expertDto) throws Exception {
		if (userType.equals("일반회원")) {
			userService.nomalUserCreate(normalDto);
		} else if (userType.equals("전문가")) {
			userService.expertUserCreate(expertDto);
		}

		return "redirect:/user/signin";
	}

	@GetMapping("/exchange")
	public void exchange() {

	}


}
