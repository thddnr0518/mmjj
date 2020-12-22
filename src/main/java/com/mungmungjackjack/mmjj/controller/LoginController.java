package com.mungmungjackjack.mmjj.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LoginController {
	
	@GetMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		log.info("login controller");
		
		return "login";
	}
	
}
