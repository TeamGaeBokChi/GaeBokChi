package com.itwill.gaebokchi.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.gaebokchi.dto.MainPostCreateDto;
import com.itwill.gaebokchi.dto.MainPostListDto;
import com.itwill.gaebokchi.dto.MainPostPageDto;
import com.itwill.gaebokchi.dto.MainPostSearchDto;
import com.itwill.gaebokchi.dto.MainPostUpdateDto;
import com.itwill.gaebokchi.dto.MyPostSearchDto;
import com.itwill.gaebokchi.repository.Clubs;
import com.itwill.gaebokchi.repository.Post;
import com.itwill.gaebokchi.repository.PostDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class MainPostService {

	private final PostDao postDao;

//	public int mainCreate(MainPostCreateDto dto) {
//		log.debug("mainPostCreate(post={})", dto);
//		String uuid = UUID.randomUUID().toString(); //랜덤스트림 생성(파일명 중복되지 않게 파일명에 부착해주는 스트링)
//		MultipartFile media = dto.getMedia(); // input media네임의 값을 multipartfile	타입으로 저장
//		if(media != null && !media.isEmpty()) { // 만약 media의 값이 널이 아니면
//			String mediaName = media.getName(); // mediaName 변수에 media 이름을 값을 가지고 오고,
//			mediaName = mediaName.replaceAll(" ", ""); // 가지고 온 media 이름에 공백을 모두 삭제를 하고
//			int idx = mediaName.lastIndexOf("."); // 이름에서 마지막 . index를 찾아서
//			String orgMediaName = mediaName.substring(0, idx); // file 이름에 첫번째 인덱스부터 . 인덱스 전까지만 orgMediaName	 변수에 저장
//			String orgMediaType = mediaName.substring(idx-1, mediaName.length()); //file 이름에 . 다음 인덱스부터 다음 인덱스 까지(확장자)를 해당 변수애 저장
//			String sMediaName = orgMediaName+uuid+orgMediaType; // 파일 순수 이름 + 랜덤으로 생성된 uuid + 확장자를 합쳐서 한 변수에 저장
//			String realPath = "/Users/sunman/Desktop/semi_project_repository/videos"; // 실제 파일이 저장 될 경로를 변수에 저장
//			File folder = new File(realPath);
//		
//			if(!folder.exists()) { // 만약 설정한 경로에 저장 폴더가 존재하지 않는다면,
//				folder.mkdirs(); // 새폴더를 생성
//				}
//			File file = new File(realPath + "/" + sMediaName);
//			
//			try {
//				media.transferTo(file);
//				 String mediaPath = realPath + "/" + sMediaName;
//                 dto.setMediaPath(mediaPath); // DTO에 파일 경로 설정
//			} catch (Exception e) {
//				log.error("Failed to save media file", e);
//                throw new RuntimeException("Failed to save media file", e);
//			}
//		}
//		int result = postDao.insertMainPost(dto.toEntity());
//		return result;
//		
//	}

	public int mainCreate(MainPostCreateDto dto) {
		log.debug("mainPostCreate(post={})", dto);
		String uuid = UUID.randomUUID().toString(); // 랜덤스트림 생성(파일명 중복되지 않게 파일명에 부착해주는 스트링)
		MultipartFile media = dto.getMedia(); // input media 네임의 값을 MultipartFile 타입으로 저장
		if (media != null && !media.isEmpty()) { // 만약 media의 값이 null이 아니면
			String mediaName = media.getOriginalFilename(); // mediaName 변수에 media 이름을 값을 가지고 오고,
			mediaName = mediaName.replaceAll(" ", ""); // 가지고 온 media 이름에 공백을 모두 삭제를 하고
			int idx = mediaName.lastIndexOf("."); // 이름에서 마지막 . index를 찾아서

			if (idx > 0) { // idx가 유효한지 확인
				String orgMediaName = mediaName.substring(0, idx); // file 이름에 첫번째 인덱스부터 . 인덱스 전까지만 orgMediaName 변수에 저장
				String orgMediaType = mediaName.substring(idx); // file 이름에 . 다음 인덱스부터 다음 인덱스 까지(확장자)를 해당 변수애 저장
				String sMediaName = orgMediaName + uuid + orgMediaType; // 파일 순수 이름 + 랜덤으로 생성된 uuid + 확장자를 합쳐서 한 변수에 저장

				String realPath = "/Users/sunman/Desktop/semi_project_repository/videos"; // 실제 파일이 저장될 경로를 변수에 저장

				File folder = new File(realPath);

				if (!folder.exists()) { // 만약 설정한 경로에 저장 폴더가 존재하지 않는다면,
					folder.mkdirs(); // 새폴더를 생성
				}
				File file = new File(realPath + "/" + sMediaName);

				try {
					media.transferTo(file);
					String mediaPath = realPath + "/" + sMediaName;
					dto.setMediaPath(mediaPath); // DTO에 파일 경로 설정
				} catch (Exception e) {
					log.error("Failed to save media file", e);
					throw new RuntimeException("Failed to save media file", e);
				}
			} else {
				log.error("Invalid media file name: {}", mediaName);
				throw new IllegalArgumentException("Invalid media file name: " + mediaName);
			}
		}
		int result = postDao.insertMainPost(dto.toEntity());
		return result;
	}

	public int mainPostUpdate(MainPostUpdateDto dto) {
		log.debug("mainPostCreate(post={})", dto);
		String uuid = UUID.randomUUID().toString(); // 랜덤스트림 생성(파일명 중복되지 않게 파일명에 부착해주는 스트링)
		MultipartFile media = dto.getMedia(); // input media 네임의 값을 MultipartFile 타입으로 저장
		if (media != null && !media.isEmpty()) { // 만약 media의 값이 null이 아니면
			String mediaName = media.getOriginalFilename(); // mediaName 변수에 media 이름을 값을 가지고 오고,
			mediaName = mediaName.replaceAll(" ", ""); // 가지고 온 media 이름에 공백을 모두 삭제를 하고
			int idx = mediaName.lastIndexOf("."); // 이름에서 마지막 . index를 찾아서

			if (idx > 0) { // idx가 유효한지 확인
				String orgMediaName = mediaName.substring(0, idx); // file 이름에 첫번째 인덱스부터 . 인덱스 전까지만 orgMediaName 변수에 저장
				String orgMediaType = mediaName.substring(idx); // file 이름에 . 다음 인덱스부터 다음 인덱스 까지(확장자)를 해당 변수애 저장
				String sMediaName = orgMediaName + uuid + orgMediaType; // 파일 순수 이름 + 랜덤으로 생성된 uuid + 확장자를 합쳐서 한 변수에 저장
				String realPath = "/Users/sunman/Desktop/semi_project_repository/videos"; // 실제 파일이 저장될 경로를 변수에 저장
				File folder = new File(realPath);

				if (!folder.exists()) { // 만약 설정한 경로에 저장 폴더가 존재하지 않는다면,
					folder.mkdirs(); // 새폴더를 생성
				}
				File file = new File(realPath + "/" + sMediaName);

				try {
					media.transferTo(file);
					String mediaPath = realPath + "/" + sMediaName;
					dto.setMediaPath(mediaPath); // DTO에 파일 경로 설정
				} catch (Exception e) {
					log.error("Failed to save media file", e);
					throw new RuntimeException("Failed to save media file", e);
				}
			} else {
				log.error("Invalid media file name: {}", mediaName);
				throw new IllegalArgumentException("Invalid media file name: " + mediaName);
			}
		}
		int result = postDao.updateMainPost(dto.toEntity());
		return result;
	}

	public List<Clubs> clubTypes() {
		List<Clubs> clubs = postDao.selectByClubType();
		return clubs;
	}

	public List<MainPostListDto> readAll() {
		log.debug("listAllRead()");
		List<Post> list = postDao.selectReadAll();
		return list.stream().map(MainPostListDto::fromEntity).toList();
	}

	public List<MainPostListDto> readAllByUserid(String userid) {
		log.debug("readAllByUserid()");
		List<Post> list = postDao.selectReadAllByUserid(userid);
		return list.stream().map(MainPostListDto::fromEntity).toList();
	}
	
	public Post selectPostId(Integer id) {
		log.debug("selectId()id={}", id);
		Post post = postDao.selectByPostId(id);
		postDao.updatePostView(id);

		return post;
	}

	public int deleteById(Integer id) {
		log.debug("delete(id={})", id);
		int result = postDao.selectDeleteById(id);
		return result;
	}

	// 좋아요 업데이트 메서드
	public int updatePostLikes(Integer id) {
		log.debug("likeUpdate(id={})", id);
		int result = postDao.updatePostLikes(id);

		return result;

	}

	// 좋아요 불러오는 메서드
	public int getPostLikes(Integer postId) {
		return postDao.selectLikes(postId);
	}
	
	public List<MainPostListDto> searchRead(MainPostSearchDto dto) {
		log.debug("search({})", dto);
		List<Post> list = postDao.search(dto);
		return list.stream().map(MainPostListDto::fromEntity).toList();
	}
	
	public List<MainPostListDto> searchReadByUserid(MyPostSearchDto dto) {
		log.debug("search({})", dto);
		List<Post> list = postDao.searchMyPost(dto);
		return list.stream().map(MainPostListDto::fromEntity).toList();
	}

	// 페이징에 사용 될 메서드
	public MainPostPageDto getPostPage(int page, int size) {
		int offset = (page - 1) * size;
		List<Post> posts = postDao.getPostList(size, offset);
		int totalPosts = postDao.getTotalCount();

		MainPostPageDto pageDto = new MainPostPageDto();
		pageDto.setContent(posts.stream().map(MainPostListDto::fromEntity).toList());
		pageDto.setCurrentPage(page);
		pageDto.setSize(size);
		pageDto.setTotalElements(totalPosts);
		pageDto.setTotalPages((int) Math.ceil((double) totalPosts / size));

		return pageDto;
	}
	
}
