package com.itwill.gaebokchi.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.gaebokchi.dto.CommPostCreateDto;
import com.itwill.gaebokchi.dto.CommPostListDto;
import com.itwill.gaebokchi.dto.CommPostSearchDto;
import com.itwill.gaebokchi.dto.CommPostUpdateDto;
import com.itwill.gaebokchi.dto.CommentCreateDto;
import com.itwill.gaebokchi.dto.CommentItemDto;
import com.itwill.gaebokchi.dto.CommentUpdateDto;
import com.itwill.gaebokchi.repository.CommPost;
import com.itwill.gaebokchi.repository.CommPostDao;
import com.itwill.gaebokchi.repository.Comment;
import com.itwill.gaebokchi.repository.CommentDao;
import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.repository.UserDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class CommPostService {

	private final CommPostDao commPostDao;
	private final CommentDao commentDao;
	private final MediaService mediaService;
	private final UserDao userDao;

	public List<CommPostListDto> read() {
		log.debug("read()");
		List<CommPost> list = commPostDao.selectOrderByIdDesc();
		return list.stream().map(CommPostListDto::fromEntity).collect(Collectors.toList());
	}
	
	public List<CommPostListDto> readAll() {
		log.debug("readAll()");
		List<CommPost> list = commPostDao.adminposts();
		return list.stream().map(CommPostListDto::fromEntity).collect(Collectors.toList());		
	}

	public CommPost read(Integer id) {
		log.debug("read(id={})", id);
		return commPostDao.selectById(id);
	}

	@Transactional
	public int Create(CommPostCreateDto dto) {
		log.debug("CommPostCreate(post={})", dto);

		if (dto.getMedia() != null && !dto.getMedia().isEmpty()) {
			String fileName = mediaService.storeFile(dto.getMedia());
			dto.setMediaPath(fileName);
		}

		return commPostDao.insertPost(dto.toEntity());
	}

	public int delete(int id) {
		log.debug("delete(id={})", id);
		return commPostDao.deletePost(id);
	}

	public int update(CommPostUpdateDto dto) {
		log.debug("update({})", dto);

		if (dto.getMedia() != null && !dto.getMedia().isEmpty()) {
			String fileName = mediaService.storeFile(dto.getMedia());
			dto.setMediaPath(fileName);
		}

		return commPostDao.updatePost(dto.toEntity());
	}

	public List<CommPostListDto> search(CommPostSearchDto dto) {
		log.debug("search({})", dto);
		List<CommPost> list = commPostDao.search(dto);
		log.debug("Raw search results: {}", list);
		return list.stream().map(CommPostListDto::fromEntity).collect(Collectors.toList());
	}

	public List<CommPostListDto> getTop5ByF001() {
		log.debug("getTop5ByF001()");
		List<CommPost> list = commPostDao.selectTop5ByF001();
		return list.stream().map(CommPostListDto::fromEntity).collect(Collectors.toList());
	}
	
	public List<CommPostListDto> Fixingthetop() {
		log.debug("Fixingthetop()");
		List<CommPost> list = commPostDao.Fixingthetop();
		return list.stream().map(CommPostListDto::fromEntity).collect(Collectors.toList());
	}

	public List<CommPostListDto> getTop5ByF002() {
		log.debug("getTop5ByF002()");
		List<CommPost> list = commPostDao.selectTop5ByF002();
		return list.stream().map(CommPostListDto::fromEntity).collect(Collectors.toList());
	}

	public List<CommPostListDto> searchByCategoryAndKeyword(CommPostSearchDto dto) {
		log.debug("searchByCategoryAndKeyword({})", dto);
		List<CommPost> list = commPostDao.selectByCategoryAndKeyword(dto);
		return list.stream().map(CommPostListDto::fromEntity).collect(Collectors.toList());
	}

	public CommPost getPreviousPost(LocalDateTime createdTime) {
		return commPostDao.findPreviousPost(createdTime);
	}

	public CommPost getNextPost(LocalDateTime createdTime) {
		return commPostDao.findNextPost(createdTime);
	}

	@Transactional
	public void increaseViews(Integer id) {
		commPostDao.increaseViews(id);
	}

	@Transactional
	public void increaseLikes(Integer id) {
		commPostDao.increaseLikes(id);
	}

	public CommentItemDto readComment(Integer id) {
		log.debug("selectCommentById(id={})", id);
		Comment comment = commentDao.selectCommentById(id);
		return CommentItemDto.fromEntity(comment);
	}

	public List<CommentItemDto> readAllComment(Integer postId) {
		log.debug("selectByPostId(postId={})", postId);
		List<Comment> list = commentDao.selectByPostId(postId);
		return list.stream().map(CommentItemDto::fromEntity).collect(Collectors.toList());
	}

	public int inserComment(CommentCreateDto dto) {
		log.debug("create({})", dto);
		return commentDao.insertComment(dto.toEntity());
	}

	public int updateComment(CommentUpdateDto dto) {
		log.debug("update({})", dto);
		return commentDao.updateComment(dto.toEntity());
	}

	public int deleteCommentById(Integer id) {
		log.debug("deleteById(id={})", id);
		return commentDao.deleteCommentById(id);
	}

	public List<CommPostListDto> getPagedPosts(int page, int pageSize) {
		int startRow = (page - 1) * pageSize;
		int endRow = page * pageSize;
		return commPostDao.selectPagedPosts(startRow, endRow).stream().map(CommPostListDto::fromEntity)
				.collect(Collectors.toList());
	}

	public int getTotalPostCount() {
		return commPostDao.selectTotalPostCount();
	}

	public int selectCommentCount(Integer id) {
		int result = commentDao.selectCommentCount(id);
		return result;
	}

	public User getLoggedInUser(String userId) {
		return userDao.selectByUserid(userId);
	}
	
	public Map<String, String> catrgoryname() {
		List<Map<String, String>> category_name = commPostDao.categoryname();
		log.debug("category_name={}", category_name);
		Map<String, String> result = category_name.stream().collect(Collectors.toMap(category -> category.get("ID"), category -> category.get("NAME")));
		log.debug("result={}", result);
		return result;
	}
	

}
