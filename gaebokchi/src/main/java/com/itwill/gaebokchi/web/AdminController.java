package com.itwill.gaebokchi.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.gaebokchi.dto.AcceptListDto;
import com.itwill.gaebokchi.dto.ExchangeListDto;
import com.itwill.gaebokchi.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

	private final UserService userService;

	@RequestMapping("adminHome")
	public String AdminHome() {
		return "/admin/adminHome";
	}

	@RequestMapping("adminPosts")
	public String AdminPosts() {
		return "/admin/adminPosts";
	}

	@GetMapping("/adminExchange")
	public void exchangeList(Model model) {
		List<ExchangeListDto> exlist = userService.AdminExchange();
		model.addAttribute("exlist", exlist);
	}

	@GetMapping("/adminSignup")
	public void acceptList(Model model) {
		List<AcceptListDto> list = userService.AdminSignup();
		model.addAttribute("list", list);
	}

	@PostMapping("approve")
	public String approveUser(@RequestParam(name = "userid") String userid) {
		userService.acceptUser(userid);
		return "redirect:/admin/adminSignup";
	}

	@PostMapping("reject")
	public String rejectUser(@RequestParam(name = "userid") String userid) {
		userService.rejectUser(userid);
		return "redirect:/admin/adminSignup";
	}
	
	@PostMapping("exapprove")
	public String approveEx(@RequestParam(name = "userid") String userid,@RequestParam(name = "withdraw") int withdraw ) {
		userService.acceptEx(userid,withdraw);
		return "redirect:/admin/adminExchange";
	}

}
