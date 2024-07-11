package com.itwill.gaebokchi.web;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import com.itwill.gaebokchi.dto.CommPostCreateDto;
import com.itwill.gaebokchi.dto.CommPostListDto;
import com.itwill.gaebokchi.dto.CommPostSearchDto;
import com.itwill.gaebokchi.dto.CommPostUpdateDto;
import com.itwill.gaebokchi.dto.CommentCreateDto;
import com.itwill.gaebokchi.dto.CommentItemDto;
import com.itwill.gaebokchi.dto.CommentUpdateDto;
import com.itwill.gaebokchi.filter.AuthenticationFilter;
import com.itwill.gaebokchi.repository.CommPost;
import com.itwill.gaebokchi.repository.Comment;
import com.itwill.gaebokchi.repository.CommentDao;
import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.service.CommPostService;
import com.itwill.gaebokchi.service.MediaService;
import com.itwill.gaebokchi.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.stream.Collectors;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/community")
public class CommunityController {

	private final CommentDao commentDao;
	private final CommPostService commPostService;
	private final MediaService mediaService;
	private final UserService userService;

	@ModelAttribute("loggedInUser")
	public User addLoggedInUserToModel(HttpSession session) {
		String userId = (String) session.getAttribute(AuthenticationFilter.SESSION_ATTR_USER);
		if (userId != null) {
			return commPostService.getLoggedInUser(userId);
		}
		return null;
	}

	@GetMapping("/comm_create")
	public String createCommPost(@ModelAttribute("loggedInUser") User loggedInUser, Model model) {
		if (loggedInUser != null) {
			model.addAttribute("user", loggedInUser);
		}
		return "community/comm_create";
	}

	@PostMapping("/comm_create")
	public String create(@ModelAttribute CommPostCreateDto dto,
			@RequestParam(value = "media", required = false) MultipartFile mediaFile,
			@ModelAttribute("loggedInUser") User loggedInUser) {
		if (loggedInUser != null) {
			log.debug("user={}", loggedInUser);
		}

		if (mediaFile != null && !mediaFile.isEmpty()) {
			String fileName = mediaService.storeFile(mediaFile);
			dto.setMediaPath(fileName);
		}

		commPostService.Create(dto);
		return "redirect:/community/comm_main";
	}

	@GetMapping("/comm_main")
	public String viewCommunityMain(@RequestParam(name = "post-cate", required = false) String category,
			@RequestParam(name = "search-category", required = false) String searchCategory,
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "size", required = false, defaultValue = "10") int pageSize, Model model) {
		log.debug("GET: ViewCommMain()");

		int pageBlockSize = 10;

		List<CommPostListDto> posts;

		if ((category != null && !category.isEmpty())
				|| (searchCategory != null && keyword != null && !keyword.isEmpty())) {
			CommPostSearchDto searchDto = new CommPostSearchDto();
			searchDto.setCategory(category);
			searchDto.setSearchCategory(searchCategory);
			searchDto.setKeyword(keyword);
			posts = commPostService.searchByCategoryAndKeyword(searchDto);
		} else {
			posts = commPostService.getPagedPosts(page, pageSize);
		}

		int totalPosts = commPostService.getTotalPostCount();
		int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
		int startPage = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
		int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

		List<CommPostListDto> pinnedPosts = commPostService.Fixingthetop();

		List<Integer> pinnedPostIds = pinnedPosts.stream().map(CommPostListDto::getId).collect(Collectors.toList());

		posts = posts.stream().filter(post -> !pinnedPostIds.contains(post.getId())).collect(Collectors.toList());

		model.addAttribute("pinnedPosts", pinnedPosts);
		model.addAttribute("top5ByF001", commPostService.getTop5ByF001());
		model.addAttribute("top5ByF002", commPostService.getTop5ByF002());

		// 카테고리 매핑 정보 추가하기
		Map<String, String> categoryMap = new HashMap<>();
		categoryMap.put("F001", "잡담");
		categoryMap.put("F002", "팁/노하우");
		categoryMap.put("F003", "라운드 후기");

		Map<String, String> userNicknames = userService.getUserNicknames();

		model.addAttribute("userNicknames", userNicknames);
		model.addAttribute("categoryMap", categoryMap);
		model.addAttribute("selectedCategory", category);
		model.addAttribute("selectedSearchCategory", searchCategory);
		model.addAttribute("keyword", keyword);
		model.addAttribute("posts", posts);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);

		return "community/comm_main";
	}

	private Map<String, Set<Integer>> userViewedPosts = new HashMap<>();

	@GetMapping("/comm_details")
	public String detailsCommunityPost(@ModelAttribute("loggedInUser") User loggedInUser,
			@RequestParam("id") Integer id, Model model, HttpSession session) {
		if (loggedInUser != null) {
			log.debug("user={}", loggedInUser);
			model.addAttribute("user", loggedInUser);

			@SuppressWarnings("unchecked")
			Set<Integer> viewedPosts = (Set<Integer>) session.getAttribute("viewedPosts");
			if (viewedPosts == null) {
				viewedPosts = new HashSet<>();
			}

			if (!viewedPosts.contains(id)) {
				commPostService.increaseViews(id); // 조회수 증가
				viewedPosts.add(id);
				session.setAttribute("viewedPosts", viewedPosts);
			} else {
				log.debug("이미 조회한 게시물입니다.");
			}
		} else {
			log.debug("로그인하지 않은 사용자는 조회수가 증가하지 않습니다.");
		}

		// 게시물 조회
		CommPost post = commPostService.read(id);

		// 이전 글과 다음 글 찾기
		CommPost previousPost = commPostService.getPreviousPost(post.getCreatedTime());
		CommPost nextPost = commPostService.getNextPost(post.getCreatedTime());

		// 댓글 목록 조회
		List<CommentItemDto> commentlist = commPostService.readAllComment(id);
		int commentcount = commPostService.selectCommentCount(id);

		Map<String, String> userNicknames = userService.getUserNicknames();

		model.addAttribute("userNicknames", userNicknames);

		// 모델에 속성 추가
		model.addAttribute("post", post); // 불러온 게시물 속성 추가
		model.addAttribute("previousPost", previousPost); // 이전 글
		model.addAttribute("nextPost", nextPost); // 다음 글
		model.addAttribute("commentlist", commentlist); // 댓글 목록 추가하기
		model.addAttribute("commentcount", commentcount);

		return "community/comm_details";
	}

	@GetMapping("/comm_modify")
	public String modifyCommunityPost(@RequestParam("id") Integer id, Model model) {
		CommPost post = commPostService.read(id);

		// 모델에 속성 추가
		model.addAttribute("post", post);

		return "community/comm_modify";
	}

	@PostMapping("/update")
	public String update(CommPostUpdateDto dto) {
		log.debug("update(dto={})", dto);

		// 서비스 컴포넌트의 메서드를 호출해서 데이터베이스 테이블 업데이트를 수행.
		commPostService.update(dto);

		return "redirect:/community/comm_details?id=" + dto.getId();
	}

	@GetMapping("/delete")
	public String delete(@RequestParam(name = "id") int id) {
		log.debug("delete(id={})", id);

		commPostService.delete(id);

		return "redirect:/community/comm_main";
	}

	@PostMapping("/increaseLikes")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> increaseLikes(@RequestParam("id") Integer id, HttpSession session) {
		String userId = (String) session.getAttribute(AuthenticationFilter.SESSION_ATTR_USER);

		if (userId == null) {
			// 로그인이 되어있지 않은 경우 예외 처리
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}

		// 해당 사용자가 이미 좋아요를 눌렀는지 확인
		Set<Integer> likedPosts = userLikedPosts.getOrDefault(userId, new HashSet<>());
		if (likedPosts.contains(id)) {
			// 이미 좋아요를 누른 경우 예외 처리
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body(Collections.singletonMap("error", "이미 좋아요를 눌렀습니다."));
		}

		// 좋아요를 증가시키고, 사용자의 좋아요 목록에 추가
		commPostService.increaseLikes(id);
		likedPosts.add(id);
		userLikedPosts.put(userId, likedPosts);

		// 업데이트된 좋아요 개수 반환
		CommPost updatedPost = commPostService.read(id);
		Map<String, Object> response = new HashMap<>();
		response.put("likes", updatedPost.getLikes());
		return ResponseEntity.ok(response);
	}

	@GetMapping("/media/{fileName}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> getMedia(@PathVariable("fileName") String fileName) {
		ByteArrayResource resource = mediaService.loadFileAsResource(fileName);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
				.body(resource);
	}

	// 댓글 목록 조회
	@GetMapping("/comments/{postId}")
	public String getCommentsByPostId(@PathVariable Integer postId, Model model) {
		List<Comment> comments = commentDao.selectByPostId(postId);	
		Map<String, String> userNicknames = userService.getUserNicknames();
		
		model.addAttribute("comments", comments);
		model.addAttribute("userNicknames", userNicknames);

		return "community/comm_details";
	}

	@PostMapping("/comments")
	@ResponseBody
	public Comment addComment(@RequestBody CommentCreateDto commentCreateDto,
			@ModelAttribute("loggedInUser") User loggedInUser) {
		Comment comment = new Comment();
		comment.setPostId(commentCreateDto.getPostId());
		comment.setContent(commentCreateDto.getContent());

		if (loggedInUser != null) {
			comment.setAuthor(loggedInUser.getUserid()); // 댓글 작성자 설정

			// 댓글을 데이터베이스에 저장하고 자동 생성된 id를 받아옴
			int result = commentDao.insertComment(comment);

			// 저장된 댓글 객체를 반환하여 클라이언트에게 전달
			if (result > 0) {
				return comment;
			} else {
				// 저장에 실패한 경우 처리
				return null;
			}
		} else {
			// 로그인 되지 않은 경우 처리
			return null;
		}
	}

	private Map<String, Set<Integer>> userLikedPosts = new HashMap<>();

	@PutMapping("/comments")
	@ResponseBody
	public Comment updateComment(@RequestBody CommentUpdateDto commentUpdateDto) {
		Comment comment = commentDao.selectCommentById(commentUpdateDto.getId());
		if (comment != null) {
			comment.setContent(commentUpdateDto.getContent());
			int result = commentDao.updateComment(comment);
			if (result > 0) {
				return comment; // 수정된 댓글 객체 반환
			}
		}
		return null;
	}

	// DELETE 요청의 URL 수정
	@DeleteMapping("/comments/{id}")
	@ResponseBody
	public String deleteComment(@PathVariable("id") Integer id) {
		int result = commentDao.deleteCommentById(id);
		if (result > 0) {
			return "Deleted comment with id: " + id;
		} else {
			return "Failed to delete comment with id: " + id;
		}
	}
}