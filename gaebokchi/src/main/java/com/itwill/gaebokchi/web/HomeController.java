package com.itwill.gaebokchi.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwill.gaebokchi.repository.Home;
import com.itwill.gaebokchi.repository.Post;
import com.itwill.gaebokchi.service.HomeService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller // 디스패쳐 서블릿에서 메서드를 호출할 컨트롤러 컴포넌트.
public class HomeController {
	
	@Autowired
	private HomeService homeService;
	
	@GetMapping("/") // GET 방식의 요청 주소가 context path인 요청을 처리하는 메서드
	public String home(Model model) {
		log.debug("home()");
		List<Home> home = homeService.pointsRank();
		List<Post> likesRank = homeService.likesRank();
		System.out.println(home);
		model.addAttribute("rank", home);
		model.addAttribute("likesRank", likesRank);
		return "home"; // 뷰(JSP 파일)의 이름.
	}
	
}
