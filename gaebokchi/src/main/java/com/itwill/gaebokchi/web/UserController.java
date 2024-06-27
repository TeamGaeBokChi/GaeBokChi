package com.itwill.gaebokchi.web;

import static com.itwill.gaebokchi.filter.AuthenticationFilter.SESSION_ATTR_USER;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwill.gaebokchi.dto.expertUserCreateDto;
import com.itwill.gaebokchi.dto.normalUserCreateDto;
import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.service.UserService;
import com.itwill.gaebokchi.dto.UserSignInDto;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

	private final UserService userService;

	@GetMapping("/signin")
	public void signIn() {
		log.debug("GET signIn()");
	}

	@PostMapping("/signin")
	public String signIn(UserSignInDto dto, Model model, HttpSession session) {
		log.debug("POST signIn({})", dto);

		try {
			User user = userService.read(dto);
			if (user != null) {
				session.setAttribute(SESSION_ATTR_USER, user.getUserid());
				return "redirect:/"; 
			} else {
				model.addAttribute("errorMessage", "일치하는 아이디와 비밀번호가 없습니다.");
				return "user/signin"; 
			}
		} catch (Exception e) {
			log.error("로그인 처리 중 오류 발생", e);
			return "redirect:/signin";
		}
	}

	@GetMapping("/signup") // GET 방식의 /user/signup 요청을 처리하는 컨트롤러 메서드
	public void signUp() {
		log.debug("GET signUp()");
	}

	@PostMapping("/signup")
	public String signUp(@RequestParam(name = "userType") String userType, normalUserCreateDto normalDto,
			expertUserCreateDto expertDto) throws Exception {
		log.debug("POST signUp()");
		if (userType.equals("일반회원")) {
			userService.nomalUserCreate(normalDto);
		} else if (userType.equals("전문가")) {
			userService.expertUserCreate(expertDto);
		}

		return "redirect:/user/signin";
	}

	@GetMapping("checkUserid")
	@ResponseBody
	public ResponseEntity<String> checkUserid(@RequestParam(name = "userid") String userid) {
		log.debug("checkId(userid={})", userid);

		boolean result = userService.checkUserid(userid);
		if (result) {
			return ResponseEntity.ok("Y");
		} else {
			return ResponseEntity.ok("N");
		}
	}

	@GetMapping("checkNickname")
	@ResponseBody
	public ResponseEntity<String> checkNickname(@RequestParam(name = "nickname") String nickname) {
		log.debug("checkId(userid={})", nickname);

		boolean result = userService.checkNickname(nickname);
		if (result) {
			return ResponseEntity.ok("Y");
		} else {
			return ResponseEntity.ok("N");
		}
	}

	@GetMapping("/exchange")
	public void exchange() {
		log.debug("GET exchange()");
	}

}
