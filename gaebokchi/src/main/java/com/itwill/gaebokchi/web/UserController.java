package com.itwill.gaebokchi.web;

import static com.itwill.gaebokchi.filter.AuthenticationFilter.SESSION_ATTR_USER;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwill.gaebokchi.dto.expertUserCreateDto;
import com.itwill.gaebokchi.dto.findIdDto;
import com.itwill.gaebokchi.dto.findPasswordDto;
import com.itwill.gaebokchi.dto.normalUserCreateDto;
import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.service.UserService;
import com.itwill.gaebokchi.dto.AcceptListDto;
import com.itwill.gaebokchi.dto.UpdatePasswordDto;
import com.itwill.gaebokchi.dto.UpdatePointDto;
import com.itwill.gaebokchi.dto.UserSignInDto;
import com.itwill.gaebokchi.dto.exchangeInfoDto;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {
	private static final String SESSION_USER_GRADE = "signedInUserGrade";
	public static int SESSION_TIME = 30 * 60; // 30분

	private final UserService userService;

	@GetMapping("/signin")
	public String signIn() {
		log.debug("GET signIn()");
		return "/user/signin";
	}

	@PostMapping("/signin")
	public String signIn(UserSignInDto dto, Model model, HttpSession session) {
		log.debug("POST signIn({})", dto);

		try {
			User user = userService.read(dto);
			if (user != null) {
				session.setMaxInactiveInterval(SESSION_TIME);
				session.setAttribute(SESSION_ATTR_USER, user.getUserid());
				session.setAttribute(SESSION_USER_GRADE, user.getGrade());

				if ("admin".equals(user.getUserid())) {
					return "redirect:/admin/adminHome";
				}
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
			expertUserCreateDto expertDto, RedirectAttributes redirectAttributes) throws Exception {
		log.debug("POST signUp()");
		if (userType.equals("일반회원")) {
			userService.nomalUserCreate(normalDto);
			redirectAttributes.addFlashAttribute("signupSuccess", "normal");
		} else if (userType.equals("전문가")) {
			userService.expertUserCreate(expertDto);
			redirectAttributes.addFlashAttribute("signupSuccess", "expert");
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

	@GetMapping("checkEmail")
	@ResponseBody
	public ResponseEntity<String> checkEmail(@RequestParam(name = "email") String email) {
		log.debug("checkEmail(email={})", email);

		boolean result = userService.checkEmail(email);
		if (result) {
			return ResponseEntity.ok("Y");
		} else {
			return ResponseEntity.ok("N");
		}
	}

	@PostMapping("/findId")
	public ResponseEntity<?> findID(@RequestBody findIdDto dto) {
		log.debug("findId(findIdDto={})", dto);

		try {
			User user = userService.findUserid(dto);

			if (user != null) {
				return ResponseEntity.ok().body(Map.of("userid", user.getUserid()));
			} else {
				// 사용자를 찾지 못한 경우
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", "일치하는 사용자 정보를 찾을 수 없습니다."));
			}
		} catch (Exception e) {
			// 예외 발생 시 처리
			log.error("아이디 찾기 중 오류 발생", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("error", "서버 오류가 발생했습니다. 나중에 다시 시도해주세요."));
		}
	}

	@PostMapping("/findPw")
	public ResponseEntity<String> findPw(@RequestBody findPasswordDto dto) {
		log.debug("findPw(findPwDto={})", dto);

		boolean result = userService.findPassword(dto);
		if (result) {
			return ResponseEntity.ok("Y");
		} else {
			return ResponseEntity.ok("N");
		}

	}

	@PostMapping("/updatePw")
	public ResponseEntity<String> updatePw(@RequestBody UpdatePasswordDto dto) {
		log.debug("updatePw(updatePw={})", dto);

		int result = userService.UpdatePassword(dto);
		if (result == 1) {
			return ResponseEntity.ok("Y");
		} else {
			return ResponseEntity.ok("N");
		}

	}

	@GetMapping("/signout")
	public String signOut(HttpSession session) {
		log.debug("singOut()");

		session.removeAttribute(SESSION_ATTR_USER);
		session.removeAttribute(SESSION_USER_GRADE);
		session.invalidate();

		return "redirect:/user/signin";
	}

	@GetMapping("/exchange")
	public String exchange(Model model, HttpSession session) {
		Object userIdObj = session.getAttribute(SESSION_ATTR_USER);

		String userId = userIdObj.toString();
		log.debug("User ID from session: {}", userId);

		exchangeInfoDto dto = userService.exchangeInfo(userId);

		model.addAttribute("userPoint", dto.getPoint());
		model.addAttribute("userAccount", dto.getAccount());
		return "/user/exchange";
	}

	@PostMapping("/exchange")
	public ResponseEntity<String> updatePoint(@RequestBody UpdatePointDto dto, HttpSession session) {
		Object userIdObj = session.getAttribute(SESSION_ATTR_USER);

		String userid = userIdObj.toString();
		log.debug("sessionId: {}", userid);

		exchangeInfoDto edto = userService.exchangeInfo(userid);
		int currentPoints = edto.getPoint();

		// 출금 요청 금액 검사
		if (dto.getPoint() > currentPoints) {
			return ResponseEntity.ok("P");
		}

		try {
			int result = userService.UpdatePoint(userid, dto);
			if (result == 1) {
				return ResponseEntity.ok("Y");
			} else {
				return ResponseEntity.ok("N");
			}
		} catch (Exception e) {
			return ResponseEntity.ok("N");
		}
	}

}
