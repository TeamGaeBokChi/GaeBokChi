package com.itwill.gaebokchi.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwill.gaebokchi.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

	@RequestMapping("adminHome")
	public String AdminHome() {
		return "/admin/adminHome";
	}

	@RequestMapping("adminPosts")
	public String AdminPosts() {
		return "/admin/adminPosts";
	}

	@RequestMapping("adminExchange")
	public String AdminExchange() {
		return "/admin/adminExchange";
	}

	@RequestMapping("adminMembers")
	public String AdminMembers() {
		return "/admin/adminMembers";
	}

	@RequestMapping("adminSignup")
	public String AdminSignup() {
		return "/admin/adminSignup";
	}

}
