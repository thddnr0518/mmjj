package com.mungmungjackjack.mmjj.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardDTO;
import com.mungmungjackjack.mmjj.board.service.IBoardService;
import com.mungmungjackjack.mmjj.domain.Criteria;
import com.mungmungjackjack.mmjj.domain.PageDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	@Autowired
	private IBoardService service;
	
	private String uploadPath = "D:\\workspace\\sts_4.8.1\\mmjj\\src\\main\\webapp\\resources\\fileUpload";
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listAll(Criteria cri, Model model) throws Exception{
		log.info("show all list............" + cri);
		
		model.addAttribute("list", service.listAll(cri));
		
		int total = service.getTotalCnt(cri);
		log.info("total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public void registerGET(BoardDTO bDto, Model model) throws Exception {
		log.info("register get.............");
	}
	
	@RequestMapping(value = "/register",method = RequestMethod.POST)
	@PreAuthorize("isAuthenticated()")
	public String registerPOST(BoardDTO bDto, RedirectAttributes rttr) throws Exception{
		log.info("register post.............");
		log.info("BoardDTO : " + bDto.toString());
		
		service.register(bDto);
		
		if (bDto.getAttachList() != null) {
			bDto.getAttachList().forEach(attach -> log.info(""+attach));
		}
		rttr.addFlashAttribute("result", bDto.getBno());
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value = {"/read","/modify"}, method = RequestMethod.GET)
	public void modifyGET(@RequestParam("bno") int bno,@ModelAttribute ("cri") Criteria cri, Model model) throws Exception{
		log.info("read or modify .............");
		model.addAttribute("board", service.read(bno));
	}
	
	@PreAuthorize("principal.username == #bDto.writer")
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BoardDTO bDto, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception {
		log.info("modify post.............." + service.modify(bDto));
		
		if (service.modify(bDto)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer")
	@RequestMapping(value = "/remove",method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) throws Exception{
		log.info("remove .............");
		
		List<BoardAttachDTO> attachList = service.getAttachList(bno);
		
		if (service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	private void deleteFiles(List<BoardAttachDTO> attachList) {
		if (attachList == null || attachList.size() <= 0) {
			return;
		}
		
		log.info("delete attach files..............");
		log.info("" + attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(uploadPath+"\\"
						   +attach.getUploadPath()+"\\"
						   +attach.getUuid()+"\\"
						   +attach.getFileName());
						
				Files.deleteIfExists(file); // 만약에 존재한다면 삭제해라
				
				if (Files.probeContentType(file).startsWith("iamge")) {
					Path thumbNail = Paths.get(uploadPath+"\\"
									+attach.getUploadPath()+"\\"
									+attach.getUuid()+"\\s_"
									+attach.getFileName());
					
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error : " + e.getMessage());
			}
		});
	}
	
	// 비동기 처리 방식
	@GetMapping(value = "/getAttachList",
						produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> getAttachList(int bno){
		log.info("getAttachList " + bno);
		
		return new ResponseEntity<List<BoardAttachDTO>>(service.getAttachList(bno), HttpStatus.OK);
	}
	
}
