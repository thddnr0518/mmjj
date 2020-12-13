package com.mungmungjackjack.mmjj.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mungmungjackjack.mmjj.member.domain.ResponseDataCode;
import com.mungmungjackjack.mmjj.member.domain.ResponseDataDTO;
import com.mungmungjackjack.mmjj.member.domain.ResponseDataStatus;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginFailHandler extends SavedRequestAwareAuthenticationSuccessHandler implements AuthenticationFailureHandler{
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		log.info("Login Fail");

//		response.sendRedirect("/member/fail");
		
		ObjectMapper mapper = new ObjectMapper();	//JSON 변경용
    	
    	ResponseDataDTO responseDataDTO = new ResponseDataDTO();
    	responseDataDTO.setCode(ResponseDataCode.ERROR);
    	responseDataDTO.setStatus(ResponseDataStatus.ERROR);
		/* responseDataDTO.setMessage("아이디 혹은 비밀번호가 일치하지 않습니다."); */

    	
    	response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print(mapper.writeValueAsString(responseDataDTO));
        response.getWriter().flush();
	}
	
}
