package com.itwill.gaebokchi.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

// import static com.itwill.gaebokchi.filter.AuthenticationFilter.SESSION_ATTR_USER;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.gaebokchi.dto.UserProfileDto;
import com.itwill.gaebokchi.dto.UserUpdateDto;
import com.itwill.gaebokchi.repository.Pro;
// import com.itwill.gaebokchi.repository.Point;
import com.itwill.gaebokchi.repository.UserMypage;
import com.itwill.gaebokchi.service.UserMypageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
@Controller
public class UserProfileController {

	private final UserMypageService userService;
	private String userid = "banggu";
	
	@GetMapping({ "/profile", "/privacy" })
	public void privacy(Model model) {
		Pro pro = userService.readPro(userid);
        model.addAttribute("user", pro);
        
        log.debug("user={}", pro);
	}

	@GetMapping("/modify")
    public void details(@RequestParam(name = "userid") String userid, Model model) {
        log.debug("modify(userid={})", userid);
        
        UserMypage user = userService.read(userid);
        
        model.addAttribute("user", user);
    }
	
	// 사용자 닉네임 중복체크 REST 컨트롤러
    @GetMapping("/checkname")
    @ResponseBody // 메서드 리턴 값이 클라이언트로 전달되는 데이터.
    public ResponseEntity<String> checkNickname(@RequestParam(name = "nickname") String nickname) {
        log.debug("checkname(nickname={})", nickname);
        
        boolean result = userService.checkNickname(nickname);
        if (result) {
            return ResponseEntity.ok("Y");
        } else {
            return ResponseEntity.ok("N");
        }
    }
	
	@PostMapping("/update")
    public String update(UserUpdateDto user) {
        log.debug("update(dto={})", user);
        
        // 서비스 컴포넌트의 메서드를 호출해서 데이터베이스 테이블 업데이트를 수행.
        userService.update(user);
        
        // 내 정보 페이지로 리다이렉트.
        return "redirect:/";
    }
	
	@PutMapping({ "/{userid}", "/professional/{userid}" })
	public ResponseEntity<Pro> saveUserInfo(@PathVariable(name = "userid") String userid, @RequestBody UserProfileDto dto) {
		log.debug("saveUserInfo(dto={})", dto);

		dto.setUserid(userid);
		Pro user = userService.updateProfile(dto);

		return ResponseEntity.ok(user);
	}
	
	@PutMapping("/file/image")
	public ResponseEntity<String> saveUserImage(@RequestParam("file") MultipartFile file) {
		// 파일이 비어있는지 체크
		if (file.isEmpty()) {
			log.debug("Please select a file to upload.");
		}

		try {
			// 업로드할 디렉토리 경로 설정
			String uploadDir = "C:\\Users\\itwill\\Desktop\\images\\";

			// 업로드할 파일 경로 설정
			String filePath = uploadDir + file.getOriginalFilename();
			File dest = new File(filePath);

			// 파일을 지정된 경로로 복사
			file.transferTo(dest);
			
			UserProfileDto dto = new UserProfileDto();
			dto.setUserid(userid);
			dto.setImage(filePath);
			
			userService.updateImage(dto);
			
			// 업로드 성공 메시지 전달
			log.debug("File uploaded successfully: {}", file.getOriginalFilename());
		} catch (IOException e) {
			e.printStackTrace();
			// 업로드 실패 메시지 전달
			log.debug("Failed to upload file: {}", file.getOriginalFilename());
		}

		return ResponseEntity.ok("Y");
	}
	
	@GetMapping("/file/image")
	@ResponseBody
	public Resource test(@RequestParam(name = "file") String file) throws IOException {
		log.info("file={}", file);

		Path path = Paths.get(file);
		log.info("path={}", path);

		ByteArrayResource resource = new ByteArrayResource(Files.readAllBytes(path));

		return resource;
	}
}