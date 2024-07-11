package com.itwill.gaebokchi.web;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.gaebokchi.dto.AcceptListDto;
import com.itwill.gaebokchi.dto.CommPostListDto;
import com.itwill.gaebokchi.dto.ExchangeListDto;
import com.itwill.gaebokchi.service.CommPostService;
import com.itwill.gaebokchi.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

	private final UserService userService;
	private final CommPostService commPostService;

	@RequestMapping("adminHome")
	public String AdminHome() {
		return "/admin/adminHome";
	}

	@GetMapping("adminPosts")
	public String AdminPosts(Model model) {

		List<CommPostListDto> posts = commPostService.readAll();

		List<CommPostListDto> pinnedPosts = commPostService.Fixingthetop();

		List<Integer> pinnedPostIds = pinnedPosts.stream().map(CommPostListDto::getId).collect(Collectors.toList());

		posts = posts.stream().filter(post -> !pinnedPostIds.contains(post.getId())).collect(Collectors.toList());

		model.addAttribute("pinnedPosts", pinnedPosts);
		model.addAttribute("posts", posts);

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

}
