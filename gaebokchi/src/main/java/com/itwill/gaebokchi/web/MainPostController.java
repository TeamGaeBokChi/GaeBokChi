package com.itwill.gaebokchi.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

import com.itwill.gaebokchi.dto.MainPostCreateDto;
import com.itwill.gaebokchi.dto.MainPostListDto;
import com.itwill.gaebokchi.dto.MainPostUpdateDto;
import com.itwill.gaebokchi.repository.Clubs;
import com.itwill.gaebokchi.repository.Post;
import com.itwill.gaebokchi.service.MainPostService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/mainPost")
public class MainPostController {
	private final MainPostService mainPostService;

//	private final MainPostCreateDto mainPostCreatDto;

	@GetMapping("/create")
	public void mainPostCreate(Model model) {
		List<Clubs> clubs = mainPostService.clubTypes();
		model.addAttribute("clubs", clubs);
	}

	@PostMapping("/create")
	public String mainPostCreate(@ModelAttribute MainPostCreateDto dto) {
		log.debug("POST: create(dto = {})", dto);
		log.debug("file={}", dto.getMedia());
		mainPostService.mainCreate(dto);
		return "redirect:/mainPost/list";
	}

	@GetMapping("/list")
	public void mainPostList(Model model) {
		log.debug("list()");

		List<MainPostListDto> list = mainPostService.readAll();
		model.addAttribute("post", list);

	}

	@GetMapping("/details")
	public void mainPostDetails(@RequestParam(name = "id") Integer id, Model model) {
		log.debug("mainPostDetails(id={})", id);
		Post post = mainPostService.selectPostId(id);
		model.addAttribute("post", post);
	}

	@GetMapping("/modify")
	public void mainPostModify(@RequestParam(name = "id") Integer id, Model model) {

		List<Clubs> clubs = mainPostService.clubTypes();

		log.debug("mainPostDetails(id={})", id);
		Post post = mainPostService.selectPostId(id);
		model.addAttribute("clubs", clubs);
		model.addAttribute("post", post);
	}

	@GetMapping("/video")
	@ResponseBody
	public Resource test(@RequestParam String file) throws IOException {
		log.info("file={}", file);

		Path path = Paths.get(file);
		log.info("path={}", path);

		ByteArrayResource resource = new ByteArrayResource(Files.readAllBytes(path));

		return resource;
	}

	@PostMapping("/update")
	public String mainPostUpdate(MainPostUpdateDto dto) {
		log.debug("mainPostUpdate(dto={})", dto);
		mainPostService.mainPostUpdate(dto);

		return "redirect:/mainPost/details?id=" + dto.getId();
	}

	@GetMapping("/delete")
	public String deleteMainPost(Integer id) {
		log.debug("deleteMainPost(id={})", id);

		mainPostService.deleteById(id);
		return "redirect:/mainPost/list";
	}

	@PutMapping("/likes/{id}")
	public ResponseEntity<Void> updateLikes(@PathVariable("id") int id) {
		log.debug("updateLikes(id={})", id);
		mainPostService.updatePostLikes(id);
		return ResponseEntity.ok().build();
	}

	@GetMapping("/likes/{id}")
	@ResponseBody
	public int getLikes(@PathVariable("id") int id) {
		log.debug("getLikes(id={})", id);
		return mainPostService.getPostLikes(id);
	}

}
