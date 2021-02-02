package com.mungmungjackjack.mmjj.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mungmungjackjack.mmjj.board.service.IBoardService;

@Controller
public class HomeController {
	
	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	private String uploadPath =
			"D:\\workspace\\sts_4.8.1\\mmjj\\src\\main\\webapp\\resources\\fileUpload";
	
	@Autowired
	private IBoardService service;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index( Model model) throws Exception{
		log.info("index.............");
		model.addAttribute("rank", service.rank());
		model.addAttribute("monthRank", service.monthRank());
		return "index";
	}
	
	@GetMapping(value = "/tmap/test")
	public void test(){
	log.info("test .......");
	
	}
	
	@GetMapping(value = "/tmap/test2")
	public void test2(){
	log.info("test2 .......");
	
	}
	
	@GetMapping(value = "/tmap/route")
	public void Route(){
	log.info("Route .......");
	
	}
	
	@GetMapping(value = "/tmap/test4")
	public void test4(){
	log.info("test4 .......");
	
	}
	
	@GetMapping(value = "/tmap/search")
	public void search(){
	log.info("search .......");
	
	}
	@GetMapping(value = "/tmap/search2")
	public void search2(){
		log.info("search2 .......");
		
	}
	@GetMapping(value = "/tmap/search3")
	public void search3(){
		log.info("search3 .......");
		
	}
	
	@GetMapping(value = "/tmap/geo")
	public void geo(){
	log.info("geo .......");
	
	}
	
	@GetMapping(value = "/tmap/walking")
	public void walking(){
	log.info("walking .......");
	
	}
}
