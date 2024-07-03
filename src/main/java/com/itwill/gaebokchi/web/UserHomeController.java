package com.itwill.gaebokchi.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class UserHomeController {
	private final UserService userService;
	private String userid = "tojin";

	@GetMapping("/")
	public String main(Model model) {
		log.debug("main()");

		User user = userService.read(userid);
		model.addAttribute("user", user);

//      Point point = userService.change(userid);
//      model.addAttribute("point", point);

		return "main";
	}
}
