package com.itwill.gaebokchi.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.itwill.gaebokchi.dto.MyPostListDto;
import com.itwill.gaebokchi.dto.MyPostListSearchDto;
import com.itwill.gaebokchi.repository.CommPostDao;
import com.itwill.gaebokchi.repository.MyPost;
import com.itwill.gaebokchi.repository.MyPostDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class MyPostService {

	private final MyPostDao myPostDao;
	private final CommPostDao commPostDao;

	public List<MyPostListDto> search(MyPostListSearchDto dto) {
		log.debug("search({})", dto);
		List<MyPost> list = myPostDao.search(dto);
		log.debug("Raw search results: {}", list);

		return list.stream().map(MyPostListDto::fromEntity).collect(Collectors.toList());
	}

	public List<MyPostListDto> selectAll() {
		log.debug("listAllRead()");
		List<MyPost> list = myPostDao.selectAll();
		return list.stream().map(MyPostListDto::fromEntity).toList();
	}

	public List<MyPostListDto> getPagedPosts(int page, String author, int pageSize) {
		int startRow = (page - 1) * pageSize;
		int endRow = page * pageSize;
		return myPostDao.selectPagedPosts(startRow, author, endRow).stream().map(MyPostListDto::fromEntity)
				.collect(Collectors.toList());
	}

	public int getTotalPostCount(String author) {
		return myPostDao.selectTotalPostCount(author);
	}
	
	public int delete(int id) {
		log.debug("delete(id={})", id);
		return commPostDao.deletePost(id);
	}

}
