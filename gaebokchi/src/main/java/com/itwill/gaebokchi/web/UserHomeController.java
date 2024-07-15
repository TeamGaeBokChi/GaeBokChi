package com.itwill.gaebokchi.web;
import static com.itwill.gaebokchi.filter.AuthenticationFilter.SESSION_ATTR_USER;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.gaebokchi.repository.UserMypage;
import com.itwill.gaebokchi.service.UserMypageService;

import jakarta.servlet.http.HttpSession;
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
	public void mypage(HttpSession session, Model model) {
		log.debug("mypage()");
		String userid = (String) session.getAttribute(SESSION_ATTR_USER);
		UserMypage user = userService.read(userid);
		model.addAttribute("user", user);

//      Point point = userService.change(userid);
//      model.addAttribute("point", point);
	}
}
