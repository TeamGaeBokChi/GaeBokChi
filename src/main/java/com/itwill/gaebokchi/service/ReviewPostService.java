package com.itwill.gaebokchi.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.gaebokchi.dto.CommPostListDto;
import com.itwill.gaebokchi.dto.CommentCreateDto;
import com.itwill.gaebokchi.dto.CommentItemDto;
import com.itwill.gaebokchi.dto.CommentUpdateDto;
import com.itwill.gaebokchi.dto.ReviewPostCreateDto;
import com.itwill.gaebokchi.dto.ReviewPostListDto;
import com.itwill.gaebokchi.dto.ReviewPostSearchDto;
import com.itwill.gaebokchi.dto.ReviewPostUpdateDto;
import com.itwill.gaebokchi.dto.ReviewPostCreateDto;
import com.itwill.gaebokchi.dto.ReviewPostListDto;
import com.itwill.gaebokchi.dto.ReviewPostUpdateDto;
import com.itwill.gaebokchi.repository.CommPost;
import com.itwill.gaebokchi.repository.Comment;
import com.itwill.gaebokchi.repository.CommentDao;
import com.itwill.gaebokchi.repository.ReviewPost;
import com.itwill.gaebokchi.repository.ReviewPostDao;
import com.itwill.gaebokchi.repository.ReviewPost;
import com.itwill.gaebokchi.repository.ReviewPostDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ReviewPostService {

	private final ReviewPostDao reviewPostDao;
	private final CommentDao commentDao;

	public List<ReviewPostListDto> read() {
		log.debug("read()");
		List<ReviewPost> list = reviewPostDao.selectOrderByIdDesc();
		return list.stream().map(ReviewPostListDto::fromEntity).collect(Collectors.toList());
	}

	public ReviewPost read(Integer id) {
		log.debug("read(id={})", id);
		return reviewPostDao.selectById(id);
	}

	@Transactional
	public int create(ReviewPostCreateDto dto) {
		log.debug("create({})", dto);

		int result = 0;
		try {
			result = reviewPostDao.insertPost(dto.toEntity());
			log.debug("insert 결과 = {}", result);
		} catch (Exception e) {
			log.error("Error during insertPost: ", e);
		}

		return result;
	}

	public int delete(int id) {
		log.debug("delete(id={})", id);
		int result = reviewPostDao.deletePost(id);
		log.debug("delete 결과 = {}", result);
		return result;
	}

	public int update(ReviewPostUpdateDto dto) {
		log.debug("update({})", dto);
		int result = reviewPostDao.updatePost(dto.toEntity());
		log.debug("update 결과 = {}", result);
		return result;
	}

	public List<ReviewPostListDto> search(ReviewPostSearchDto dto) {
		log.debug("search({})", dto);
		List<ReviewPost> list = reviewPostDao.search(dto);
		log.debug("Raw search results: {}", list);
		return list.stream().map(ReviewPostListDto::fromEntity).collect(Collectors.toList());
	}

	public ReviewPost getPreviousPost(LocalDateTime createdTime) {
		return reviewPostDao.findPreviousPost(createdTime);
	}

	public ReviewPost getNextPost(LocalDateTime createdTime) {
		return reviewPostDao.findNextPost(createdTime);
	}

	@Transactional
	public void increaseViews(Integer id) {
		reviewPostDao.increaseViews(id);
	}

	@Transactional
	public void increaseLikes(Integer id) {
		reviewPostDao.increaseLikes(id);
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

	public List<ReviewPostListDto> getPagedPosts(int page, int pageSize) {
		int startRow = (page - 1) * pageSize;
		int endRow = page * pageSize;
		return reviewPostDao.selectPagedPosts(startRow, endRow).stream().map(ReviewPostListDto::fromEntity)
				.collect(Collectors.toList());
	}

	public int getTotalPostCount() {
		return reviewPostDao.selectTotalPostCount();
	}

}
