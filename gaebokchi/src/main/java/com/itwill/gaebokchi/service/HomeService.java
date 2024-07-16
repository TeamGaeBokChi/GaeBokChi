package com.itwill.gaebokchi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwill.gaebokchi.repository.Home;
import com.itwill.gaebokchi.repository.HomeDao;
import com.itwill.gaebokchi.repository.Post;
import com.itwill.gaebokchi.repository.PostDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class HomeService {
	
	@Autowired
	private HomeDao homeDao;
	
	@Autowired
	private PostDao postDao;
	
	public List<Home> pointsRank() {
		log.debug("homeDao pointsRank()");
		List<Home> home = homeDao.getUsersPointRank();
		return home;	
	}
	
	
	public List<Post> viewsRank(){
		log.debug("viewsRank()");
		
		List<Post> viewsRank = postDao.getUsersViewsRank();
		System.out.println(viewsRank);
		return viewsRank;
	}
	
	public List<Post> likesRank(){
		log.debug("viewsRank()");
		
		List<Post> likesRank = postDao.getUsersLikesRank();
		System.out.println(likesRank);
		return likesRank;
	}

}
