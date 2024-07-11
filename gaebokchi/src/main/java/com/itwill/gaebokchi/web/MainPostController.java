package com.itwill.gaebokchi.web;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwill.gaebokchi.dto.MainPostCreateDto;
import com.itwill.gaebokchi.dto.MainPostListDto;
import com.itwill.gaebokchi.dto.MainPostSearchDto;
import com.itwill.gaebokchi.dto.MainPostUpdateDto;
import com.itwill.gaebokchi.dto.MyPostSearchDto;
import com.itwill.gaebokchi.repository.Clubs;
import com.itwill.gaebokchi.repository.Post;
import com.itwill.gaebokchi.service.MainPostService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import static com.itwill.gaebokchi.filter.AuthenticationFilter.SESSION_ATTR_USER;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/mainPost")
public class MainPostController {
	private final MainPostService mainPostService;

//	private final MainPostCreateDto mainPostCreatDto;

	@GetMapping("/create")
	public void mainPostCreate(Model model) {
		List<Clubs> clubs = mainPostService.clubTypes();
		model.addAttribute("clubs", clubs);
	}

	@PostMapping("/create")
	public String mainPostCreate(@ModelAttribute MainPostCreateDto dto) {
		log.debug("POST: create(dto = {})", dto);
		log.debug("file={}", dto.getMedia());
		mainPostService.mainCreate(dto);
		return "redirect:/mainPost/list";
	}

	@GetMapping("/list")
	public void mainPostList(@RequestParam(name = "userid", required = false) String userid, Model model) {
		log.debug("list()");

		if (userid == null) {
			List<MainPostListDto> list = mainPostService.readAll();
			List<Clubs> clubs = mainPostService.clubTypes();
			model.addAttribute("post", list);
			model.addAttribute("clubs", clubs);
		} else {
			List<MainPostListDto> list = mainPostService.readAllByUserid(userid);
			List<Clubs> clubs = mainPostService.clubTypes();
			model.addAttribute("post", list);
			model.addAttribute("clubs", clubs);
			model.addAttribute("userid", userid);
		}
	}

	@GetMapping("/details")
	public void mainPostDetails(@RequestParam(name = "id") Integer id, @RequestParam(name = "commentId", required = false) Integer commentId, Model model, HttpSession session) {
		log.debug("mainPostDetails(id={})", id);
		
//		Object sessionUser = session.getAttribute(SESSION_ATTR_USER);
//		String sunman = sessionUser.toString();
		
		Post post = mainPostService.selectPostId(id);
		log.debug("{}", post);
		model.addAttribute("commentId", commentId);
		model.addAttribute("post", post);
	}

	@GetMapping("/modify")
	public void mainPostModify(@RequestParam(name = "id") Integer id, Model model) {

		List<Clubs> clubs = mainPostService.clubTypes();

		log.debug("mainPostDetails(id={})", id);
		Post post = mainPostService.selectPostId(id);
		model.addAttribute("clubs", clubs);
		model.addAttribute("post", post);
	}

	@GetMapping("/video")
	@ResponseBody
	public Resource test(@RequestParam (name = "file") String file) throws IOException {
		log.info("file={}", file);

		Path path = Paths.get(file);
		log.info("path={}", path);

		ByteArrayResource resource = new ByteArrayResource(Files.readAllBytes(path));

		return resource;
	}

	@PostMapping("/update")
	public String mainPostUpdate(MainPostUpdateDto dto) {
		log.debug("mainPostUpdate(dto={})", dto);
		mainPostService.mainPostUpdate(dto);

		return "redirect:/mainPost/details?id=" + dto.getId();
	}

	@GetMapping("/delete")
	public String deleteMainPost(Integer id) {
		log.debug("deleteMainPost(id={})", id);

		mainPostService.deleteById(id);
		return "redirect:/mainPost/list";
	}

	@PutMapping("/likes/{id}")
	public ResponseEntity<Void> updateLikes(@PathVariable(name = "id") Integer id) {
		log.debug("updateLikes(id={})", id);
		mainPostService.updatePostLikes(id);
		return ResponseEntity.ok().build();
	}

	@GetMapping("/likes/{id}")
	@ResponseBody
	public int getLikes(@PathVariable(name = "id") Integer id) {
		log.debug("getLikes(id={})", id);
		return mainPostService.getPostLikes(id);
	}

	@GetMapping("/search")
	public String searchPosts(MainPostSearchDto dto, MyPostSearchDto myDto, Model model) {
		if (myDto.getUserid().equals("")) {
			log.debug("searchPosts()");
			List<MainPostListDto> posts = mainPostService.searchRead(dto);
			model.addAttribute("post", posts);

			List<Clubs> clubs = mainPostService.clubTypes();
			model.addAttribute("clubs", clubs);
			
			return "/mainPost/list"; // 해당하는 뷰의 경로와 이름
		} else {
			log.debug("searchPosts()");
			List<MainPostListDto> posts = mainPostService.searchReadByUserid(myDto);
			model.addAttribute("post", posts);

			List<Clubs> clubs = mainPostService.clubTypes();
			model.addAttribute("clubs", clubs);
			
			model.addAttribute("userid", myDto.getUserid());
			
			return "/mainPost/list";
		}
	}

//	// mainPost/paging?page=number 를 구현 
//	// 첫 페이지 요청은 1페이지로 본값 설정 
//	@GetMapping("/paging")
//	public String Paging(@RequestParam(value = "page", required = false, defaultValue = "1") int page), Model model) {
//		System.out.println("page = " + page);
//		return "/list";
//	}
}
