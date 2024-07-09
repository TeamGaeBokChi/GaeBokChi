package com.itwill.gaebokchi.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.gaebokchi.dto.JoinPostCreateDto;
import com.itwill.gaebokchi.dto.JoinPostListDto;
import com.itwill.gaebokchi.dto.JoinPostSearchDto;
import com.itwill.gaebokchi.dto.JoinPostUpdateDto;
import com.itwill.gaebokchi.repository.JoinPost;
import com.itwill.gaebokchi.repository.JoinPostDao;
import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.repository.UserDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class JoinPostService {

	private final JoinPostDao joinPostDao;
	private final UserDao userDao;

	public List<JoinPostListDto> read() {
		log.debug("read()");
		List<JoinPost> list = joinPostDao.selectOrderByIdDesc();
		return list.stream().map(JoinPostListDto::fromEntity).collect(Collectors.toList());
	}

	public JoinPost read(Integer id) {
		log.debug("read(id={})", id);
		return joinPostDao.selectById(id);
	}

	 public List<JoinPostListDto> search(JoinPostSearchDto dto) {
	        log.debug("search({})", dto);
	        List<JoinPost> list = joinPostDao.search(dto);
	        log.debug("Raw search results: {}", list);
	        return list.stream().map(JoinPostListDto::fromEntity).collect(Collectors.toList());
	    }
	
	@Transactional
	public int create(JoinPostCreateDto dto) {
		log.debug("create({})", dto);

		int result = 0;
		try {
			result = joinPostDao.insertPost(dto.toEntity());
			log.debug("insert 결과 = {}", result);
		} catch (Exception e) {
			log.error("Error during insertPost: ", e);
		}

		return result;
	}

	public int delete(int id) {
		log.debug("delete(id={})", id);
		int result = joinPostDao.deletePost(id);
		log.debug("delete 결과 = {}", result);
		return result;
	}

	public int update(JoinPostUpdateDto dto) {
		log.debug("update({})", dto);
		int result = joinPostDao.updatePost(dto.toEntity());
		log.debug("update 결과 = {}", result);
		return result;
	}

	public JoinPost getPreviousPost(LocalDateTime teeoff) {
		return joinPostDao.findPreviousPost(teeoff);
	}

	public JoinPost getNextPost(LocalDateTime teeoff) {
		return joinPostDao.findNextPost(teeoff);
	}

	public List<JoinPostListDto> findByTeeoffDate(LocalDate teeoffDate) {
		log.debug("findByTeeoffDate(teeoffDate={})", teeoffDate);
		List<JoinPost> list = joinPostDao.selectByTeeoffDate(teeoffDate);
		return list.stream().map(JoinPostListDto::fromEntity).collect(Collectors.toList());
	}
	
	public List<JoinPostListDto> getPagedPosts(int page, int pageSize) {
		int startRow = (page - 1) * pageSize;
		int endRow = page * pageSize;
		return joinPostDao.selectPagedPosts(startRow, endRow).stream().map(JoinPostListDto::fromEntity)
				.collect(Collectors.toList());
	}

	public int getTotalPostCount() {
		return joinPostDao.selectTotalPostCount();
	}
	
	public User getLoggedInUser(String userId) {
		return userDao.selectByUserid(userId);
	}

}
