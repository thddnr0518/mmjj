package com.mungmungjackjack.mmjj.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mungmungjackjack.mmjj.member.domain.MemberDTO;
import com.mungmungjackjack.mmjj.member.service.IMemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@AllArgsConstructor
@Log4j
public class MemberController {
	
	@Autowired
	private IMemberService service;
	
	@Autowired
	private PasswordEncoder pwencoder;
	
	@RequestMapping("/catch")
	public void loginCatch(@ModelAttribute("mDto")MemberDTO mDto) {
		log.info("catch.....");
	}
	
	@RequestMapping("/fail")
	public void loginFail(@ModelAttribute("mDto")MemberDTO mDto) {
		log.info("fail.....");
	}
	
	@GetMapping(value = "/idChk",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> idChk(@RequestParam("userid") String inputID) {
		
		log.info("id check....");
		String message = service.idChk(inputID) == null ? "1" : "0";
		return new ResponseEntity<String>(message,HttpStatus.OK);
	}
	
	@PostMapping(value = "/join")
	public String join(MemberDTO mDto,HttpServletResponse response, RedirectAttributes rttr) throws Exception{
		
		log.info("join post.............");
		
		mDto.setUserpw(pwencoder.encode(mDto.getUserpw()));
		
		service.insertMem(mDto);
		
		String userid = mDto.getUserid();
		
		service.authMem(userid);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		pw.print("<script>" + "alert('회원가입에 성공하셨습니다.');" + "location.href='" + "/mmjj/';" + "</script>");
		
		return null; /*"redirect:/";*/
	}
}
