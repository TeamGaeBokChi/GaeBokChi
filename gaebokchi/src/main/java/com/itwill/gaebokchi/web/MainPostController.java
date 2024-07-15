package com.itwill.gaebokchi.web;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import static com.itwill.gaebokchi.filter.AuthenticationFilter.SESSION_ATTR_USER;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String mainPostList(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "size", required = false, defaultValue = "10") int pageSize,
			@RequestParam(name = "userid", required = false) String userid, HttpSession session, Model model) {
		log.debug("list()");

		List<MainPostListDto> posts;
		int totalPosts;
		int pageBlockSize = 10;

		String sessionUserid = (String) session.getAttribute(SESSION_ATTR_USER);

		if (userid == null) {
			posts = mainPostService.getPagedPosts(page, pageSize);
			totalPosts = mainPostService.getTotalPostCount();
		} else {
			posts = mainPostService.getPagedPostsByUserid(page, sessionUserid, pageSize);
			totalPosts = mainPostService.getTotalPostCountByUserid(sessionUserid);
		}

		int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
		int startPage = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
		int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

		List<Clubs> clubs = mainPostService.clubTypes();

		model.addAttribute("post", posts);
		model.addAttribute("clubs", clubs);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("pageSize", pageSize);

		if (userid != null) {
			return "/user/myLessonList";
		}

		return "/mainPost/list";
	}

	@GetMapping("/details")
	public String mainPostDetails(@RequestParam(name = "id") Integer id,
			@RequestParam(name = "commentId", required = false) Integer commentId, Model model, HttpSession session,
			RedirectAttributes redirectAttributes) {
		log.debug("mainPostDetails(id={})", id);

		// 세션에서 사용자 정보 확인
		Object sessionUser = session.getAttribute(SESSION_ATTR_USER);

		// 로그인하지 않은 사용자인 경우
		if (sessionUser == null) {
			// 경고 메시지 설정
			redirectAttributes.addFlashAttribute("warningMessage", "로그인한 사용자만 볼 수 있습니다.");
			// 홈페이지로 리다이렉트
			return "redirect:/user/signin";
		}

		// 로그인한 사용자인 경우, 기존 로직 수행
		Post post = mainPostService.selectPostId(id);
		log.debug("{}", post);
		model.addAttribute("commentId", commentId);
		model.addAttribute("post", post);

		// 뷰 이름 반환
		return "/mainPost/details"; // 또는 적절한 뷰 이름
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
	public Resource test(@RequestParam(name = "file") String file) throws IOException {
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
	public String deleteMainPost(@RequestParam(name = "id") int id) {
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

}
