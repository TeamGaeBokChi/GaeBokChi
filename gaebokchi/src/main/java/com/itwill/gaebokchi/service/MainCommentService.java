package com.itwill.gaebokchi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.gaebokchi.dto.MainCommentCreateDto;
import com.itwill.gaebokchi.dto.MainCommentItemDto;
import com.itwill.gaebokchi.repository.MainComment;
import com.itwill.gaebokchi.repository.MainCommentDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainCommentService {
	@Autowired
	private MainCommentDao mainCommentDao;
	
	public int mainPostCommentCreate(MainCommentCreateDto dto) {
		log.debug("mainPostCommentCreate({})", dto);
		int result = mainCommentDao.insertComment(dto.toEntity());

		return result;
	}

	public List<MainCommentItemDto> commentReadByPostId(Integer postId) {
		log.debug("commentReadByPostId()");
		List<MainComment> list = mainCommentDao.selectCommentsByPostId(postId);

		return list.stream().map(MainCommentItemDto::fromEntity).toList();
	}

	public List<MainCommentItemDto> commentReadByUserid(String userid) {
		log.debug("commentReadByUserid()");
		List<MainComment> list = mainCommentDao.selectCommentsByUserid(userid);

		return list.stream().map(MainCommentItemDto::fromEntity).toList();
	}

	@Transactional
	public void selectCommentAndGiftPoint(Integer id) {
		log.debug("selectComment(id={})", id);
        mainCommentDao.selectComment(id);
        mainCommentDao.updateUserPoint(id);
	}
	
	public int deleteComment(Integer id) {
		log.debug("deleteComment(id={})",id);
		int result = mainCommentDao.deleteCommentById(id);
		return result;
	}
	
	public int editCommentById(Integer id) {
		int result = mainCommentDao.edit(id);
		return result;
	}

	
//	public int userGiftPoint(Integer id) {
//		log.debug("userGiftPoint(id={})", id);
//		int result = mainCommentDao.updateUserPoint(id);
//		return result;
//	}

}
