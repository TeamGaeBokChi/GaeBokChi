package com.itwill.gaebokchi.web;

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

import com.itwill.gaebokchi.dto.CommPostCreateDto;
import com.itwill.gaebokchi.dto.CommPostListDto;
import com.itwill.gaebokchi.dto.CommPostSearchDto;
import com.itwill.gaebokchi.dto.CommPostUpdateDto;
import com.itwill.gaebokchi.dto.CommentCreateDto;
import com.itwill.gaebokchi.dto.CommentItemDto;
import com.itwill.gaebokchi.dto.CommentUpdateDto;
import com.itwill.gaebokchi.repository.CommPost;
import com.itwill.gaebokchi.repository.Comment;
import com.itwill.gaebokchi.repository.CommentDao;
import com.itwill.gaebokchi.service.CommPostService;
import com.itwill.gaebokchi.service.MediaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.stream.Collectors;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/community")
public class CommunityController {

	private final CommentDao commentDao;
	private final CommPostService commPostService;
	private final MediaService mediaService;

	@GetMapping("/comm_create")
	public String createCommPost() {
		log.debug("GET: create()");
		return "community/comm_create";
	}

	@PostMapping("/comm_create")
	public String create(@ModelAttribute CommPostCreateDto dto,
			@RequestParam(value = "media", required = false) MultipartFile mediaFile) {
		log.debug("POST: create(dto = {}, mediaFile = {})", dto, mediaFile);

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

		List<CommPostListDto> pinnedPosts = List.of(CommPostListDto.fromEntity(commPostService.read(62)),
				CommPostListDto.fromEntity(commPostService.read(65)));
		
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

	@GetMapping("/comm_details")
	public String detailsCommunityPost(@RequestParam("id") Integer id, Model model) {
		// 조회수 증가
		commPostService.increaseViews(id);

		// 게시물 조회
		CommPost post = commPostService.read(id);

		// 이전 글과 다음 글 찾기
		CommPost previousPost = commPostService.getPreviousPost(post.getCreatedTime());
		CommPost nextPost = commPostService.getNextPost(post.getCreatedTime());

		// 댓글 목록 조회
		List<CommentItemDto> commentlist = commPostService.readAllComment(id);
		int commentcount = commPostService.selectCommentCount(id);
		
		// 모델에 속성 추가
		model.addAttribute("commentlist" , commentlist); // 댓글 목록 추가하기
		model.addAttribute("post", post);	// 불러온 게시물 속성 추가
		model.addAttribute("previousPost", previousPost);	// 이전 글
		model.addAttribute("nextPost", nextPost);	// 다음 글
		model.addAttribute("commentcount" , commentcount);

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
	public ResponseEntity<Map<String, Integer>> increaseLikes(@RequestParam("id") Integer id) {
		commPostService.increaseLikes(id);
		CommPost updatedPost = commPostService.read(id);
		Map<String, Integer> response = new HashMap<>();
		response.put("likes", updatedPost.getLikes());
		return ResponseEntity.ok(response);
	}

	@GetMapping("/media/{fileName}")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> getMedia(@PathVariable String fileName) {
		ByteArrayResource resource = mediaService.loadFileAsResource(fileName);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
				.body(resource);
	}

	// 댓글 목록 조회
	@GetMapping("/comments/{postId}")
	public String getCommentsByPostId(@PathVariable Integer postId, Model model) {
		List<Comment> comments = commentDao.selectByPostId(postId);
		model.addAttribute("comments", comments);
		return "community/comm_details";
	}

	@PostMapping("/comments")
	@ResponseBody
	public Comment addComment(@RequestBody CommentCreateDto commentCreateDto) {
		Comment comment = new Comment();
		comment.setPostId(commentCreateDto.getPostId());
		comment.setAuthor(commentCreateDto.getAuthor());
		comment.setContent(commentCreateDto.getContent());
		int result = commentDao.insertComment(comment);

		// 저장된 댓글 객체를 반환하여 클라이언트에게 전달
		return comment;
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