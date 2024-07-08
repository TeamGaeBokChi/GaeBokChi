package com.itwill.gaebokchi.web;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
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

import com.itwill.gaebokchi.dto.ReviewPostListDto;
import com.itwill.gaebokchi.dto.CommentCreateDto;
import com.itwill.gaebokchi.dto.CommentItemDto;
import com.itwill.gaebokchi.dto.CommentUpdateDto;
import com.itwill.gaebokchi.dto.ReviewPostCreateDto;
import com.itwill.gaebokchi.dto.ReviewPostSearchDto;
import com.itwill.gaebokchi.dto.ReviewPostUpdateDto;
import com.itwill.gaebokchi.repository.ReviewPost;
import com.itwill.gaebokchi.repository.Comment;
import com.itwill.gaebokchi.repository.CommentDao;
import com.itwill.gaebokchi.service.MediaService;
import com.itwill.gaebokchi.service.ReviewPostService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/review")
public class ReviewController {

	private final CommentDao commentDao;
	private final ReviewPostService reviewPostService;
	private final MediaService mediaService;

	@GetMapping("/review_create")
	public void createReviewPost() {
		log.debug("GET: create()");
	}

	@PostMapping("/review_create")
	public String create(@ModelAttribute ReviewPostCreateDto dto,
			@RequestParam(value = "media", required = false) MultipartFile mediaFile) {
		log.debug("POST: create(dto = {}, mediaFile = {})", dto, mediaFile);

		if (mediaFile != null && !mediaFile.isEmpty()) {
			String fileName = mediaService.storeFile(mediaFile);
			dto.setMediaPath(fileName);
		}

		reviewPostService.Create(dto);
		return "redirect:/review/review_main";
	}

	@GetMapping("/review_main")
	public String viewreviewMain(@RequestParam(name = "search-category", required = false) String Category,
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "page", required = false, defaultValue = "1") int page,
			@RequestParam(name = "size", required = false, defaultValue = "10") int pageSize, Model model) {
		log.debug("GET: ViewCommMain()");

		List<ReviewPostListDto> posts;
		List<ReviewPostListDto> pinnedPosts = List.of(ReviewPostListDto.fromEntity(reviewPostService.read(62)),
				ReviewPostListDto.fromEntity(reviewPostService.read(65)));

		int pageBlockSize = 10;

		List<Integer> pinnedPostIds = pinnedPosts.stream().map(ReviewPostListDto::getId).collect(Collectors.toList());

		if (Category != null && keyword != null && !keyword.isEmpty()) {
			ReviewPostSearchDto searchDto = new ReviewPostSearchDto();
			searchDto.setCategory(Category);
			searchDto.setKeyword(keyword);
			posts = reviewPostService.search(searchDto);
		} else {
			posts = reviewPostService.getPagedPosts(page, pageSize);
		}

		int totalPosts = reviewPostService.getTotalPostCount();
		int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
		int startPage = ((page - 1) / pageBlockSize) * pageBlockSize + 1;
		int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);

		posts = posts.stream().filter(post -> !pinnedPostIds.contains(post.getId())).collect(Collectors.toList());

		model.addAttribute("posts", posts);
		model.addAttribute("pinnedPosts", pinnedPosts);

		// 카테고리 매핑 정보 추가하기
		Map<String, String> categoryMap = new HashMap<>();
		categoryMap.put("P004", "리뷰");

		model.addAttribute("posts", posts);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("categoryMap", categoryMap);
		model.addAttribute("keyword", keyword);

		return "review/review_main";
	}

	@GetMapping("/review_details")
	public String detailsReviewPost(@RequestParam("id") Integer id, Model model) {
		// 조회수 증가
		reviewPostService.increaseViews(id);

		// 게시물 조회
		ReviewPost post = reviewPostService.read(id);

		// 이전 글과 다음 글 찾기
		ReviewPost previousPost = reviewPostService.getPreviousPost(post.getCreatedTime());
		ReviewPost nextPost = reviewPostService.getNextPost(post.getCreatedTime());

		// 댓글 목록 조회
		List<CommentItemDto> commentlist = reviewPostService.readAllComment(id);

		int commentcount = reviewPostService.selectCommentCount(id);

		// 모델에 속성 추가
		model.addAttribute("post", post);
		model.addAttribute("previousPost", previousPost);
		model.addAttribute("nextPost", nextPost);
		model.addAttribute("commentlist", commentlist);
		model.addAttribute("commentcount", commentcount);

		return "review/review_details";
	}

	@GetMapping("/review_modify")
	public String modifyReviewPost(@RequestParam("id") Integer id, Model model) {
		ReviewPost post = reviewPostService.read(id);

		// 모델에 속성 추가
		model.addAttribute("post", post);

		return "review/review_modify";
	}

	@PostMapping("/update")
	public String update(ReviewPostUpdateDto dto) {
		log.debug("update(dto={})", dto);

		// 서비스 컴포넌트의 메서드를 호출해서 데이터베이스 테이블 업데이트를 수행.
		reviewPostService.update(dto);

		return "redirect:/review/review_details?id=" + dto.getId();
	}

	@GetMapping("/delete")
	public String delete(@RequestParam(name = "id") int id) {
		log.debug("delete(id={})", id);

		reviewPostService.delete(id);

		return "redirect:/review/review_main";
	}

	@PostMapping("/increaseLikes")
	@ResponseBody
	public ResponseEntity<Map<String, Integer>> increaseLikes(@RequestParam("id") Integer id) {
		reviewPostService.increaseLikes(id);
		ReviewPost updatedPost = reviewPostService.read(id);
		Map<String, Integer> response = new HashMap<>();
		response.put("likes", updatedPost.getLikes());
		return ResponseEntity.ok(response);
	}

	// 댓글 목록 조회
	@GetMapping("/comments/{postId}")
	public String getCommentsByPostId(@PathVariable Integer postId, Model model) {
		List<Comment> comments = commentDao.selectByPostId(postId);
		model.addAttribute("comments", comments);
		return "review/review_details";
	}

	@PostMapping("/comments")
	@ResponseBody
	public CommentItemDto addComment(@RequestBody CommentCreateDto commentCreateDto) {
		Comment comment = new Comment();
		comment.setPostId(commentCreateDto.getPostId());
		comment.setAuthor(commentCreateDto.getAuthor());
		comment.setContent(commentCreateDto.getContent());
		comment.setModifiedTime(LocalDateTime.now()); // 현재 시간 설정

		// 댓글을 데이터베이스에 저장
		commentDao.insertComment(comment);

		// 저장된 댓글의 ID가 설정되었는지 확인
		System.out.println("Saved Comment ID: " + comment.getId());

		// 저장된 댓글을 다시 읽어옴 (매퍼 사용)
		Comment savedComment = commentDao.selectCommentById(comment.getId());

		// 반환할 DTO 객체 생성
		CommentItemDto commentItemDto = CommentItemDto.fromEntity(savedComment);
		System.out.println("Returning CommentItemDto: " + commentItemDto);

		// CommentItemDto로 변환하여 반환
		return commentItemDto;
	}

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

	@GetMapping("/media/{fileName}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> getMedia(@PathVariable("fileName") String fileName) {
		ByteArrayResource resource = mediaService.loadFileAsResource(fileName);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
				.body(resource);
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
