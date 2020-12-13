package com.mungmungjackjack.mmjj.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mungmungjackjack.mmjj.board.domain.BoardAttachDTO;
import com.mungmungjackjack.mmjj.board.domain.BoardRankDTO;
import com.mungmungjackjack.mmjj.board.service.IBoardService;

@Controller
public class HomeController {
	
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	private String uploadPath =
			"D:\\workspace\\sts_4.8.1\\mmjj\\src\\main\\webapp\\resources\\fileUpload";
	
	@Autowired
	private IBoardService service;
	
//	@RequestMapping(value = "/home", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		log.info("Welcome home! The client locale is {}.", locale);
//		
//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );
//		
//		return "home";
//	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index( Model model) throws Exception{
		log.info("index.............");
		
		model.addAttribute("rank", service.rank());
		return "index";
	}
	
	@GetMapping(value = "/test")
	public void test(){
	log.info("test .......");
	
	}
	
	
//	@GetMapping(value = "/getAttachList",
//			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public ResponseEntity<List<BoardAttachDTO>> getAttachList(int bno){
//	log.info("getAttachList " + bno);
//	
//	return new ResponseEntity<List<BoardAttachDTO>>(service.getAttachList(bno), HttpStatus.OK);
//	}
//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public void rankThree(Model model) throws Exception{
//		log.info("show rank............");
//		
//		log.info(service.rank().toString());
//		model.addAttribute("rank", service.rank());
//		
//	}
	
}
