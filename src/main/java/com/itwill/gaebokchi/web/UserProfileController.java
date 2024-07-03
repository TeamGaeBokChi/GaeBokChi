package com.itwill.gaebokchi.web;

import java.util.HashMap;

import org.springframework.http.ResponseEntity;

// import static com.itwill.gaebokchi.filter.AuthenticationFilter.SESSION_ATTR_USER;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwill.gaebokchi.dto.UserUpdateDto;
import com.itwill.gaebokchi.repository.Pro;
// import com.itwill.gaebokchi.repository.Point;
import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
@Controller
public class UserProfileController {

	private final UserService userService;
	private String userid = "tojin";
	
	@GetMapping({ "/profile", "/privacy" })
	public void privacy(Model model) {
		User user = userService.read(userid);
        model.addAttribute("user", user);
        
        log.debug("user={}", user);
	}

	@GetMapping("/modify")
    public void details(@RequestParam(name = "userid") String userid, Model model) {
        log.debug("modify(userid={})", userid);
        
        User user = userService.read(userid);
        
        model.addAttribute("user", user);
    }
	
	// 사용자 닉네임 중복체크 REST 컨트롤러
    @GetMapping("/checkname")
    @ResponseBody // 메서드 리턴 값이 클라이언트로 전달되는 데이터.
    public ResponseEntity<String> checkNickname(@RequestParam(name = "nickname") String nickname) {
        log.debug("checkname(nickname={})", nickname);
        
        boolean result = userService.checkNickname(nickname);
        if (result) {
            return ResponseEntity.ok("Y");
        } else {
            return ResponseEntity.ok("N");
        }
    }
	
	@PostMapping("/update")
    public String update(UserUpdateDto user) {
        log.debug("update(dto={})", user);
        
        // 서비스 컴포넌트의 메서드를 호출해서 데이터베이스 테이블 업데이트를 수행.
        userService.update(user);
        
        if (!user.getLicense().equals("")) {
        	userService.insert(user);
        }
        
        // 내 정보 페이지로 리다이렉트.
        return "redirect:/";
    }
	
	@PutMapping("/{userid}")
    @ResponseBody
    public ResponseEntity<String> saveNickname(@PathVariable String userid, @RequestBody UserUpdateDto dto) {
		log.debug("saveNickname(nickname={})", dto.getNickname());
        
        dto.setUserid(userid);
        userService.update(dto);
        
        return ResponseEntity.ok().build();
    }
	
	@GetMapping("/{userid}")
    @ResponseBody
    public ResponseEntity<HashMap<String, String>> selectInfo(@PathVariable String userid) {
        log.debug("selectInfo(userid={})", userid);
        
        Pro pro = userService.readPro(userid);
        
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("userid", pro.getUserid());
        map.put("career", pro.getCareer());
        
        return ResponseEntity.ok(map);
    }
}