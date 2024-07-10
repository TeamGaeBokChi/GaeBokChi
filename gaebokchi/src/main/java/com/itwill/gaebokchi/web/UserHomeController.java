package com.itwill.gaebokchi.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.gaebokchi.repository.UserMypage;
import com.itwill.gaebokchi.service.UserMypageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
@Controller
public class UserHomeController {
	private final UserMypageService userService;
//	private String userid = "banggu";

	@GetMapping("/mypage")
	public void mypage(@RequestParam(name = "userid") String userid, Model model) {
		log.debug("mypage()");

		UserMypage user = userService.read(userid);
		model.addAttribute("user", user);

//      Point point = userService.change(userid);
//      model.addAttribute("point", point);
	}
}
