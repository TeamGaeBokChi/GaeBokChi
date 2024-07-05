package com.itwill.gaebokchi.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwill.gaebokchi.repository.UserMypage;
import com.itwill.gaebokchi.service.UserMypageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class UserHomeController {
//	private final UserMypageService userService;
//	private String userid = "banggu";
//
//	@GetMapping("/")
//	public String main(Model model) {
//		log.debug("main()");
//
//		UserMypage user = userService.read(userid);
//		model.addAttribute("user", user);
//
////      Point point = userService.change(userid);
////      model.addAttribute("point", point);
//
//		return "main";
//	}
}
