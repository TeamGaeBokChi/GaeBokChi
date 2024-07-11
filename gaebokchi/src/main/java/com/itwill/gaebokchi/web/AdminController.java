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
import com.itwill.gaebokchi.dto.MemberListDto;
import com.itwill.gaebokchi.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

	private final UserService userService;

	@GetMapping("adminHome")
	public String AdminHome() {
		return "/admin/adminHome";
	}

	@GetMapping("/adminPosts")
	public String AdminPosts() {
		return "/admin/adminPosts";
	}

	@GetMapping("/adminMembers")
	public void AdminMembers(Model model) {
		List<MemberListDto> members = userService.AllMembers();
		model.addAttribute("members", members);
	}
	
	@PostMapping("/changeGrade")
	public String setGrade(@RequestParam(name = "userid") String userid, @RequestParam(name = "grade") String grade) {
		userService.setGrade(userid, grade);
		return "redirect:/admin/adminMembers";
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
	public String approveUser(@RequestParam(name = "userid") String userid, @RequestParam(name = "accept") String accept) {
		userService.acceptUser(userid,accept);
		return "redirect:/admin/adminSignup";
	}

	@PostMapping("reject")
	public String rejectUser(@RequestParam(name = "userid") String userid, @RequestParam(name = "accept") String accept) {
		userService.rejectUser(userid);
		return "redirect:/admin/adminSignup";
	}

	@PostMapping("exapprove")
	public String approveEx(@RequestParam(name = "userid") String userid,
			@RequestParam(name = "withdraw") int withdraw) {
		userService.acceptEx(userid, withdraw);
		return "redirect:/admin/adminExchange";
	}

	@PostMapping("exreject")
	public String rejectEx(@RequestParam(name = "userid") String userid,
			@RequestParam(name = "withdraw") int withdraw) {
		userService.rejectEx(userid, withdraw);
		return "redirect:/admin/adminExchange";
	}

	@PostMapping("deleteUser")
	public String deleteUser(@RequestParam(name = "userid") String userid) {
		userService.deleteUser(userid);
		return "redirect:/admin/adminMembers";
	}
	
	

}
