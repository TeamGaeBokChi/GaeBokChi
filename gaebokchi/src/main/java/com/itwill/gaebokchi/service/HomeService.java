package com.itwill.gaebokchi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwill.gaebokchi.repository.Home;
import com.itwill.gaebokchi.repository.HomeDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class HomeService {
	
	@Autowired
	private HomeDao homeDao;
	
	public List<Home> pointsRank() {
		log.debug("homeDao pointsRank()");
		List<Home> home = homeDao.getUsersPointRank();
		return home;	
	}

}
